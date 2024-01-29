<script>
  export let item;

  function toggle(item) {
    item.is_done = !item.is_done;
    updateItem(item).then(() => {
      loadItems();
    });
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

<label class="list-group-item d-flex gap-3">
  <input
    class="form-check-input flex-shrink-0"
    type="checkbox"
    value=""
    style="font-size: 1.375em;"
    on:click={() => {
      toggle(item);
    }}
    bind:checked={item.is_done}
  />
  <span class="pt-1 form-checked-content">
    <strong>
      {item.content}
    </strong>
  </span>
</label>
