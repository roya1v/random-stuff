import { useState } from 'react'
import { useTodoStore } from './todoStore'

export function NewTodoField() {
    const [content, setContent] = useState("")
    const create = useTodoStore((state) => state.create)
    return (
      <div>
        <input type="text" onChange={(e) => setContent(e.target.value)}></input>
        <button onClick={() => create(content)}>Create</button>
      </div>
    )
  }