import { useEffect, useState } from 'react'
import { auth } from './firebase';
import { onAuthStateChanged } from 'firebase/auth';
import { AuthPage } from './pages/AuthPage';
import { PresentsPage } from './pages/presentsPage/PresentsPage';

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
                <PresentsPage />
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

export default App
