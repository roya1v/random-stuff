<script>
  import { onMount } from "svelte";

  var items = [];

  onMount(() => {
    loadItems();
  });

  function toggle(item) {
    item.is_done = !item.is_done;
    updateItem(item).then(() => {
      loadItems();
    });
  }

  async function loadItems() {
    const res = fetch("http://localhost:3000/todos");
    const test = await (await res).json();
    items = test;
  }

  async function updateItem(item) {
    const res = await fetch("http://localhost:3000/todos", {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(item),
    });

    await res.json();
  }
</script>

<h1>Welcome to Better ToDo</h1>

{#each items as item}
  <div>
    <button
      on:click={() => {
        toggle(item);
      }}
    >
      {#if !item.is_done}
        ✅
      {/if}
      {item.content}
    </button>
  </div>
{/each}
