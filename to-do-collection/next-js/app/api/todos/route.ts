import { ToDoItem } from "@/app/_todoItem"

export async function GET(request: Request) {
    return Response.json(items)
}

let items: Array<ToDoItem> = [{
    id: 0,
    content: "Hello, World!",
    is_done: false
}]

export async function POST(request: Request) {
    let item: ToDoItem = await request.json()
    items.push(item)
    return Response.json({success: true})
}