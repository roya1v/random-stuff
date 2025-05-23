import { useEffect, useState } from 'react'
import { auth } from './firebase';
import { onAuthStateChanged } from 'firebase/auth';
import { AuthPage } from './pages/AuthPage';
import { PresentsPage } from './pages/presentsPage/PresentsPage';

function App() {

    const [isLoggedIn, setLoggedIn] = useState<boolean | null>(null);

    useEffect(() => {
        onAuthStateChanged(auth, (user) => {
            if (user) {
                setLoggedIn(true);
            } else {
                setLoggedIn(false);
            }
        });
    })

    if (isLoggedIn == null) {
        return (
            <div className="flex justify-center items-center h-screen">
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    className="animate-spin"
                >
                    <path d="M21 12a9 9 0 1 1-6.219-8.56" />
                </svg>
            </div>
        )
    } else if (isLoggedIn) {
        return (<PresentsPage />)

    } else {
        return (<AuthPage />)
    }
}

export default App
