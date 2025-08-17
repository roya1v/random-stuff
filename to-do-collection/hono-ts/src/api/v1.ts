import { Hono } from 'hono'
import { db } from '../db/db.js'
import { todosTable } from '../db/schema.js'
import { eq } from 'drizzle-orm'

export const apiV1 = new Hono()

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
  const newItem = await db.update(todosTable).set(item).where(eq(todosTable.id, +id)).returning()
  return c.json(newItem)
})

apiV1.delete('/:id', async (c) => {
  const id = c.req.param('id')
  await db.delete(todosTable).where(eq(todosTable.id, +id));
  return c.json({})
})