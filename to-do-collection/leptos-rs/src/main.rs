use leptos::prelude::*;

fn main() {
    leptos::mount::mount_to_body(App)
}

struct ToDoItem {
    id: Option<u32>,
    content: String,
    is_done: bool
}

#[component]
fn App() -> impl IntoView {
    let (count, set_count) = signal(0);

    let item = ToDoItem {id: Option::None, content: "Hello, World!".to_string(), is_done: false};

    let mut items = vec![item];

    view! {
        <main class="flex flex-col justify-center items-center h-screen bg-slate-200">
        "ToDo App"
        <ul>
            {items.into_iter()
                .map(|n| view! { <li>{n.content}</li>})
                .collect::<Vec<_>>()}
        </ul>
        <button
            class="p-4 m-4 bg-white rounded-xl"
            on:click=move |_| set_count.set(count.get() + 1)
        >
            "new item"
        </button>
        <div>
        <button
            class="p-4 m-4 bg-white rounded-xl"
            on:click=move |_| set_count.set(count.get() + 1)
        >
            "+"
        </button>
        {count}
        <button
            class="p-4 m-4 bg-white rounded-xl"
            on:click=move |_| set_count.set(count.get() - 1)
        >
            "-"
        </button>
    </div>
        </main>
    }
}