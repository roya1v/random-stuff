import { collection, doc, getDocs, onSnapshot, query, QueryDocumentSnapshot, type DocumentData } from 'firebase/firestore';
import { useEffect, useState } from 'react'
import { db } from './firebase';

function App() {
  const [presents, setPresents] = useState<QueryDocumentSnapshot<DocumentData, DocumentData>[]>([])

  useEffect(() => {
    getDocs(query(collection(db, "presents"))).then((docs) => {
      const items: QueryDocumentSnapshot<DocumentData, DocumentData>[] = []
      docs.forEach((doc) => { items.push(doc) })
      setPresents(items)
    })
  });

  return (
    <>
      <h1 className="text-3xl font-bold underline">Подарки для Александра!</h1>
      {presents.map((present) => {
        return <>
          <div key={present.id}>
            {present.data()["title"]}

          </div>
        </>
      })}
    </>
  )
}

export default App
