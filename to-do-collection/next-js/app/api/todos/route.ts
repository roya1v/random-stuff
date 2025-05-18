import { ToDoItem } from "@/app/_todoItem"
import { db } from "@/lib"
import { todosTable, usersTable } from "@/lib/db/schema"
import { eq } from "drizzle-orm"

export async function GET(request: Request) {
    const dbItems = await db.select().from(todosTable);
    return Response.json(dbItems.map((dbItem) => { return {id: dbItem.id, content: dbItem.content, is_done: dbItem.isDone}}))
}

export async function POST(request: Request) {
    let item: ToDoItem = await request.json()
    const dbItem: typeof todosTable.$inferInsert = {
        content: item.content,
        isDone: item.is_done ? 1 : 0
    }
    await db.insert(todosTable).values(dbItem)
    return Response.json({ success: true })
}

export async function PUT(request: Request) {
    let item: ToDoItem = await request.json()
    const dbItem: typeof todosTable.$inferInsert = {
        content: item.content,
        isDone: item.is_done ? 1 : 0
    }

    await db
        .update(todosTable)
        .set({
            content: item.content,
            isDone: item.is_done ? 1 : 0
        })
        .where(eq(todosTable.id, item.id!));
    return Response.json({ success: true })
}