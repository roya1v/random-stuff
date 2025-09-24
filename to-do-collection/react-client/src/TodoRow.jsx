import { useTodoStore } from './todoStore'

export function TodoRow({item}) {
    const update = useTodoStore((state) => state.update)
    const remove = useTodoStore((state) => state.remove)
    return (
      <div>
        {item.content}
        <input 
        type="checkbox"
        checked={item.is_done}
        onChange={(e) => {update({
          id: item.id,
          content: item.content,
          is_done: e.target.checked
        })}}></input>
        <button onClick={() => remove(item.id)}>X</button>
      </div>
    )
  }