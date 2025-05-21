import { collection, doc, getDocs, onSnapshot, query, QueryDocumentSnapshot, setDoc, updateDoc, type DocumentData } from 'firebase/firestore';
import { useEffect, useState } from 'react'
import { auth, db, provider } from './firebase';
import { Button } from './components/ui/button';
import { getAuth, GoogleAuthProvider, onAuthStateChanged, signInWithPopup, signOut } from 'firebase/auth';

function App() {

  const [isLoggedIn, setLoggedIn] = useState(false);

  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
      if (user) {
        setLoggedIn(true);
      } else {
        setLoggedIn(false);
      }
    });
  })

  if (isLoggedIn) {
    return (
      <>
        <PresentsList />
      </>
    )
  } else {
    return (
      <>
        <AuthPage />
      </>
    )
  }


}

function AuthPage() {
  return (<><Button onClick={() => {
    const auth = getAuth();
    signInWithPopup(auth, provider)
      .then((result) => {
        // This gives you a Google Access Token. You can use it to access the Google API.
        const credential = GoogleAuthProvider.credentialFromResult(result);
        const token = credential!.accessToken;
        // The signed-in user info.
        const user = result.user;
        // IdP data available using getAdditionalUserInfo(result)
        // ...
      }).catch((error) => {
        // Handle Errors here.
        const errorCode = error.code;
        const errorMessage = error.message;
        // The email of the user's account used.
        const email = error.customData.email;
        // The AuthCredential type that was used.
        const credential = GoogleAuthProvider.credentialFromError(error);
        // ...
      });
  }}>Войти через гугл</Button></>)
}

function PresentsList() {
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
      <Button onClick={() => { signOut(auth) }}>Sign out</Button>
      <h1 className="text-3xl font-bold underline">Подарки для Александра!</h1>
      {presents.map((present) => {
        return <>
          <div key={present.id} className="">
            {present.data()["title"]}
            <Button onClick={() => {
              updateDoc(doc(db, "presents", present.id), { presenter: auth.currentUser!.uid })
            }}>Выбрать</Button>
          </div>
        </>
      })}
    </>
  )
}

export default App
