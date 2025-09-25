use leptos::prelude::*;

fn main() {
    console_error_panic_hook::set_once();
    leptos::mount::mount_to_body(App)
}


#[component]
fn App() -> impl IntoView {
    let (items, set_items) = signal::<Vec<String>>(vec![]);
    let content = RwSignal::new("".to_string());

    view! {
        <div>
            <div>
                {move || items
                    .read()
                    .clone()
                    .into_iter()
                    .map(|item| view! { <div>{item}</div>})
                    .collect_view()}
            </div>
            <input
                bind:value=content
            ></input>
            <button
                on:click=move |_| {
                    let mut existing = items.read().clone();
                    existing.push(content.read().clone());
                    content.set("".to_owned());
                    set_items.set(existing)
                }
            >Create</button>
        </div>
    }
}