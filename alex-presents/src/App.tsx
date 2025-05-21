import { collection, doc, getDocs, onSnapshot, query, QueryDocumentSnapshot, setDoc, updateDoc, type DocumentData } from 'firebase/firestore';
import { useEffect, useState } from 'react'
import { db } from './firebase';
import { Button } from './components/ui/button';

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
          <div key={present.id} className="">
            {present.data()["title"]}
            <Button onClick={() => {
              updateDoc(doc(db, "presents", present.id), { taken: "test" })
            }}>Выбрать</Button>
          </div>
        </>
      })}
    </>
  )
}

export default App
