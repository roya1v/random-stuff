import { useEffect } from 'react'
import './App.css'
import { useTodoStore } from './todoStore'
import { NewTodoField } from './NewTodoField'

function App() {
  const todos = useTodoStore((state) => state.todos)
  const refresh = useTodoStore((state) => state.refresh)
  useEffect(() => {
    refresh();
  }, [])

  return (
    <>
      <div>
        {todos.map((item) => <TodoRow key={item.id} item={item}/>)}
        <NewTodoField />
      </div>
    </>
  )
}

function TodoRow({item}) {
  const update = useTodoStore((state) => state.update)
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
    </div>
  )
}

export default App
