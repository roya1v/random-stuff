import { Button } from "@/components/ui/button";
import { auth, db } from "@/firebase";
import { signOut } from "firebase/auth";
import { doc, updateDoc } from "firebase/firestore";
import { useEffect, useState } from "react";
import {
    Card,
    CardContent,
    CardFooter,
    CardHeader,
} from "@/components/ui/card"
import { Separator } from "@/components/ui/separator";

import { fetchAvailablePresents, fetchMyPresents } from "./fetchPresents";
import type { Present } from "./present";

export function PresentsPage() {
    const [availablePresents, setAvailablePresents] = useState<Present[]>([])
    const [myPresents, setMyPresents] = useState<Present[]>([])
    const [refreshKey, setRefreshKey] = useState(0);

    useEffect(() => {
        fetchAvailablePresents().then((presents) => { setAvailablePresents(presents) })
        fetchMyPresents().then((presents) => { setMyPresents(presents) })
    }, [refreshKey]);

    return (
        <div className="bg-slate-100">
            <div className="p-4 flex items-center h-screen justify-center flex-col ">
                <Card className="w-full lg:w-[600px]">
                    <CardHeader className="flex flex-col items-center">
                        <h1 className="text-xl">Подарки для</h1>
                        <div className="flex flex-row items-center lg:text-8xl text-5xl font-[Great_Vibes] ">
                            <h1 className="">Алек</h1>
                            <img src="alex.png" className="inline lg:w-32 w-24"></img>
                            <h1 className="">сандра</h1>
                        </div>
                    </CardHeader>
                    <CardContent>
                        <h2 className="text-xl font-bold">Свободные подарки:</h2>
                        {availablePresents.map((present) => {
                            console.log(present.id)
                            return (
                                <div key={present.id} className="m-4">
                                    <div className="flex flex-row items-center">
                                        {present.title}
                                        <div className="flex-auto"></div>
                                        <Button onClick={() => {
                                            updateDoc(doc(db, "presents", present.id), { presenter: auth.currentUser!.uid }).then(() => { setRefreshKey(prev => prev + 1) })
                                        }}>
                                            Дарю
                                        </Button>
                                    </div>
                                </div>
                            )
                        })}
                        <Separator className="my-2" />
                        <h2 className="text-xl font-bold">Подарок от меня (видны только мне и Саше):</h2>
                        {myPresents.map((present) => {
                            console.log(present.id)
                            return (
                                <div key={present.id} className="m-4">
                                    <div className="flex flex-row items-center">
                                        {present.title}
                                        <div className="flex-auto"></div>
                                        <Button variant="destructive" onClick={() => {
                                            updateDoc(doc(db, "presents", present.id), { presenter: null }).then(() => { setRefreshKey(prev => prev + 1) })
                                        }}>
                                            Не дарю
                                        </Button>
                                    </div>
                                </div>
                            )
                        })}
                    </CardContent>
                    <CardFooter className="flex flex-col">
                        <Separator className="my-2" />
                        <Button variant="destructive" onClick={() => { signOut(auth) }}>Вылогиниться</Button>
                    </CardFooter>
                </Card>
            </div>
        </div>
    )
}