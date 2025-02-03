use leptos::prelude::*;

fn main() {
    leptos::mount::mount_to_body(App)
}


#[component]
fn App() -> impl IntoView {
    let (count, set_count) = signal(0);

    view! {
        <div>
            <button
                on:click=move |_| set_count.set(count.get() + 1)
            >
                "+"
            </button>
            {count}
            <button
                on:click=move |_| set_count.set(count.get() - 1)
            >
                "-"
            </button>
        </div>
    }
}