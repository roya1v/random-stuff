import { useState } from 'react'
import { useTodoStore } from './todoStore'

export function NewTodoField() {
    const [content, setContent] = useState("")
    const create = useTodoStore((state) => state.create)
    return (
      <div>
        <input type="text" onChange={(e) => setContent(e.target.value)} value={content}></input>
        <button onClick={async () => {
          await create(content)
          setContent('')
        }}>Create</button>
      </div>
    )
  }