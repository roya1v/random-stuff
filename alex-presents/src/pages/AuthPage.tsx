import { getAuth, signInWithPopup } from "firebase/auth";
import { Button } from "../components/ui/button";
import { provider } from "../firebase";

export function AuthPage() {
    return (<div className="flex items-center justify-center h-screen flex-col">
        <h1 className="p-2 text-xl text-center">Чтобы подарить Александру подарок надо сначала залогиниться</h1>
        <Button className="bg-blue-500" onClick={() => {
            const auth = getAuth();
            signInWithPopup(auth, provider)
        }}>
            Войти через Гугл
        </Button>
    </div>)
}