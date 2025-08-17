import { useEffect, useState } from 'react'
import './App.css'

function App() {
  const [items, setItems] = useState([])

  useEffect(() => {
    async function fetchData() {
      const res = await fetch('http://localhost:3000/api/v1')
      const data = await res.json()
      setItems(data)
    }
    fetchData();
  }, [])

  return (
    <>
      <div>
        {items.map((item) => <div key={item.id}>{item.content}<input type="checkbox"></input></div>)}
        <input type="text"></input>
        <button>Create</button>
      </div>
    </>
  )
}

export default App
