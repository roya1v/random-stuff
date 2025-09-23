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
        {todos.map((item) => <div key={item.id}>{item.content}<input type="checkbox"></input></div>)}
        <NewTodoField />
      </div>
    </>
  )
}

export default App
