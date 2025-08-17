import { serve } from '@hono/node-server'
import { Hono } from 'hono'

import { apiV1 } from './api/v1.js';

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
