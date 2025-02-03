use leptos::prelude::*;

fn main() {
    leptos::mount::mount_to_body(App)
}


#[component]
fn App() -> impl IntoView {
    let (count, set_count) = signal(0);

    view! {
        <main class="flex flex-col justify-center items-center h-screen bg-slate-200">
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