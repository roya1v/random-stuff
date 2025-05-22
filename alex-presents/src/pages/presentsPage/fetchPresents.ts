import { collection, getDocs, or, query, QueryDocumentSnapshot, where, type DocumentData } from "firebase/firestore"
import type { Present } from "./present"
import { auth, db } from "@/firebase"

const presentsRef = collection(db, "presents")

export async function fetchPresents(): Promise<Present[]> {
    const docs = await getDocs(query(presentsRef, or(where("presenter", "==", null), where("presenter", "==", auth.currentUser!.uid))))
    const result: Present[] = []
    docs.forEach((doc) => {
        result.push(presentFromSnapshot(doc))
    })
    return result
}

export async function fetchAvailablePresents(): Promise<Present[]> {
    const docs = await getDocs(query(presentsRef, where("presenter", "==", null)))
    const result: Present[] = []
    docs.forEach((doc) => {
        result.push(presentFromSnapshot(doc))
    })
    return result
}

export async function fetchMyPresents(): Promise<Present[]> {
    const docs = await getDocs(query(presentsRef, where("presenter", "==", auth.currentUser!.uid)))
    const result: Present[] = []
    docs.forEach((doc) => {
        result.push(presentFromSnapshot(doc))
    })
    return result
}

function presentFromSnapshot(doc: QueryDocumentSnapshot<DocumentData, DocumentData>): Present {
    return {
        id: doc.id,
        title: doc.data()["title"],
        presenter: doc.data()["presenter"],
        site: doc.data()["site"],
        note: doc.data()["note"]
    }
}