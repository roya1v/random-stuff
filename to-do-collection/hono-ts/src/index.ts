import { serve } from '@hono/node-server'
import { Hono } from 'hono'

import 'dotenv/config';
import { drizzle } from 'drizzle-orm/node-postgres';
import { todosTable } from './db/schema.js';
import { eq } from 'drizzle-orm';

const db = drizzle(process.env.DATABASE_URL!);

const apiV1 = new Hono()

apiV1.get('/', async (c) => {
  const items = await db.select().from(todosTable)
  return c.json(items)
})

apiV1.get('/:id', async (c) => {
  const id = c.req.param('id')
  const items = await db.select().from(todosTable).where(eq(todosTable.id, +id))
  return c.json(items[0])
})

apiV1.post('/', async (c) => {
  const item: typeof todosTable.$inferInsert = await c.req.json()
  const newItem = await db.insert(todosTable).values(item).returning()
  return c.json(newItem)
})

apiV1.put('/:id', async (c) => {
  const id = c.req.param('id')
  const item: typeof todosTable.$inferInsert = await c.req.json()
  const newItem = await db.update(todosTable).set(item).where(eq(todosTable.id, +id)).returning
  return c.json(newItem)
})

apiV1.delete('/:id', async (c) => {
  const id = c.req.param('id')
  await db.delete(todosTable).where(eq(todosTable.id, +id));
  return c.json({})
})

const app = new Hono()

app.get('/api/available', (c) => {
  return c.json(['v1'])
})

app.route('/api/v1', apiV1)

serve({
  fetch: app.fetch,
  port: 3000
}, (info) => {
  console.log(`Server is running on http://localhost:${info.port}`)
})
