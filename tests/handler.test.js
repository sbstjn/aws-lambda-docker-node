const handler = require('../src/handler');

test('returns expected value', async () => {
  expect(await handler.run()).toBe('Done');
});