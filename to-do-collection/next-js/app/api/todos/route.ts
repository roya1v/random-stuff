import { ToDoItem } from "@/app/_todoItem"

let items: Array<ToDoItem> = [{
    id: 0,
    content: "Hello, World!",
    is_done: false
}]

export async function GET(request: Request) {
    return Response.json(items)
}

export async function POST(request: Request) {
    let item: ToDoItem = await request.json()
    items.push(item)
    return Response.json({success: true})
}

export async function PUT(request: Request) {
    throw "Not implemented"
}