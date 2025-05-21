import { collection, doc, getDocs, onSnapshot, query } from 'firebase/firestore';
import { useEffect, useState } from 'react'
import { db } from './firebase';

function App() {
  const [presents, setPresents] = useState<string[]>([])

  useEffect(() => {
    // const unsub = onSnapshot(doc(db, "presents"), (doc) => {
    //   console.log("Current data: ", doc.data());
    // });
    getDocs(query(collection(db, "presents"))).then((docs) => {
      const items: string[] = []
      docs.forEach((doc) => { items.push(doc.data()["title"]) })
      setPresents(items)
    })
  });

  return (
    <>
      <h1 className="text-3xl font-bold underline">Подарки для Александра!</h1>
      {presents.map((present) => { return <>{present}</> })}
    </>
  )
}

export default App
