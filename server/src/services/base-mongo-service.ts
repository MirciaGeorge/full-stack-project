import mongoose, { Schema, PopulateOptions, Model, FilterQuery, UpdateQuery, UpdateWithAggregationPipeline } from 'mongoose'
import { ResourceNotFoundErrorResponse } from '../error-response'
import { omit } from 'lodash'

export class BaseMongoService<T extends { id: string }> {
  protected model: Model<T>

  protected collectionName: string
  protected schema: Schema<T>
  protected populateOptions?: PopulateOptions
  protected preInit: (schema: Schema) => Promise<void>
  protected postInit: (schema: Schema, model: Model<T>) => Promise<void>
  protected resourceNotFoundErrorResponse: typeof ResourceNotFoundErrorResponse

  constructor({
    connectionString,
    collectionName,
    schema,
    populateOptions,
    preInit = async () => undefined,
    postInit = async () => undefined,
    resourceNotFoundErrorResponse
  }: {
    connectionString?: string
    collectionName: string
    schema: Schema<T>
    populateOptions?: PopulateOptions
    preInit?: (schema: Schema) => Promise<void>
    postInit?: (schema: Schema, model: Model<T>) => Promise<void>
    resourceNotFoundErrorResponse: typeof ResourceNotFoundErrorResponse
  }) {
    this.collectionName = collectionName
    // @ts-ignore
    this.schema = schema.add({ _id: { type: String, immutable: true } })
    this.populateOptions = populateOptions
    this.preInit = preInit
    this.postInit = postInit
    this.resourceNotFoundErrorResponse = resourceNotFoundErrorResponse

    if (connectionString) {
      this.connect(connectionString)
    }
  }

  async connect(connectionString: string) {
    if (!mongoose.connection.readyState) {
      await mongoose.connect(connectionString)
    }

    if (mongoose.models[this.collectionName]) {
      this.model = mongoose.models[this.collectionName]
    } else {
      await this.preInit(this.schema)
      this.model = mongoose.model<T>(this.collectionName, this.schema)
      await this.postInit(this.schema, this.model)
    }
  }

  parseDocument(doc: mongoose.Document): T {
    return omit(doc.toJSON<T>(), '_id', '__v') as T
  }

  async populateDocument(doc: mongoose.Document) {
    return this.populateOptions ? doc.populate(this.populateOptions) : doc
  }

  async add(payload: T): Promise<T> {
    const doc = await this.model.create({ ...payload, _id: payload.id })
    return this.parseDocument(await this.populateDocument(doc))
  }

  async update(id: string, payload: Partial<T>) {
    const updated = await this.model.findOneAndUpdate({ id }, payload, { new: true, upsert: true })
    if (!updated) {
      throw new this.resourceNotFoundErrorResponse()
    }

    return this.parseDocument(await this.populateDocument(updated))
  }

  async updateMany(filter: FilterQuery<T>, update: UpdateQuery<T> | UpdateWithAggregationPipeline) {
    await this.model.updateMany(filter, update)
  }

  async delete(id: string) {
    await this.model.findByIdAndDelete(id)
  }

  async getById(id: string): Promise<T | null> {
    const doc = await this.model.findOne({ id })
    return doc ? this.parseDocument(await this.populateDocument(doc)) : null
  }

  async getByIds(ids: string[]): Promise<T[]> {
    const docs = await this.model.find({ id: { $in: ids } })
    return (await Promise.all(docs.map(doc => this.populateDocument(doc)))).map(this.parseDocument)
  }

  async getAll(): Promise<T[]> {
    const docs = await this.model.find({})
    return (await Promise.all(docs.map(doc => this.populateDocument(doc)))).map(this.parseDocument)
  }
}