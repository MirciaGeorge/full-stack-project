module.exports = {
    preset: '../jest.preset.ts',
    testEnvironment: 'node',
    setupFiles: ['./jest.setup.ts'],
    testPathIgnorePatterns: ['/node_modules/'],
    testTimeout: 10000
  }
  