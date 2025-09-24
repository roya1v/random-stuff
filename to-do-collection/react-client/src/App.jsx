import { useEffect } from 'react'
import './App.css'
import { useTodoStore } from './todoStore'
import { NewTodoField } from './NewTodoField'
import { TodoRow } from './TodoRow'

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

export default App
