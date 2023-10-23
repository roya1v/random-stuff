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
<div
  class="container-fluid-flex flex-column flex-md-row p-4 gap-4 py-md-5 align-items-center justify-content-centerd"
>
  <div class="list-group">
    {#each items as item}
      <label class="list-group-item d-flex gap-3">
        
        {#if item.is_done}
        <input
          class="form-check-input flex-shrink-0"
          type="checkbox"
          value=""
          style="font-size: 1.375em;"
          on:click={() => {toggle(item)}}
          checked
        />
        {:else}
        <input
          class="form-check-input flex-shrink-0"
          type="checkbox"
          value=""
          style="font-size: 1.375em;"
          on:click={() => {toggle(item)}} 
        />
        {/if}
        <span class="pt-1 form-checked-content">
          <strong>
            {item.content}
          </strong>
        </span>
      </label>
      <div />
    {/each}
  </div>
</div>
