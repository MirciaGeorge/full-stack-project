module.exports = {
  preset: 'ts-jest',
  coveragePathIgnorePatterns: ['node_modules'],
  testPathIgnorePatterns: ['/node_modules/', '/server/build/'],
  moduleDirectories: ['node_modules', '<rootDir>'],
  transform: {
    '^.+\\.ts$': [
      'ts-jest',
      {
        isolatedModules: true
      }
    ]
  }
}
