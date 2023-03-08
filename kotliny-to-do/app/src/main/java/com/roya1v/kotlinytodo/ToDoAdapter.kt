package com.roya1v.kotlinytodo

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.roya1v.kotlinytodo.databinding.TodoItemBinding

class ToDoAdapter(val toDos: List<ToDo>): RecyclerView.Adapter<ToDoAdapter.ToDoViewHolder>() {
    inner class ToDoViewHolder(val binding: TodoItemBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ToDoViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        val binding = TodoItemBinding.inflate(layoutInflater, parent, false)
        return ToDoViewHolder(binding)
    }

    override fun getItemCount(): Int {
        return toDos.size
    }

    override fun onBindViewHolder(holder: ToDoViewHolder, position: Int) {
        holder.binding.tvTitle.text = toDos[position].title
    }
}