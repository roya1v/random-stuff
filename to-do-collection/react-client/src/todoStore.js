import { create } from 'zustand'

export const useTodoStore = create((set, get) => ({
    todos: [],
    refresh: async () => {
        const res = await fetch('http://localhost:3000/api/v1')
        const data = await res.json()
        set((state) => ({ todos: data }))
    },
    create: async (content) => {
        await fetch('http://localhost:3000/api/v1', {
            method: "post",
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
            },

            body: JSON.stringify({
              content: content,
              is_done: false
            })
          })
        await get().refresh()
    },
    update: async (item) => {
      await fetch('http://localhost:3000/api/v1', {
        method: "put",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },

        body: JSON.stringify(item)
      })
    await get().refresh()
    },
    remove: async (id) => {
      await fetch(`http://localhost:3000/api/v1/${id}`, {
        method: "delete",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      })
    await get().refresh()
    }
}))