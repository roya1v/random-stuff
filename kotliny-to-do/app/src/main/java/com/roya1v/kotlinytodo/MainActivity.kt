package com.roya1v.kotlinytodo

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.roya1v.kotlinytodo.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val items = mutableListOf<ToDo>()

        val adapter = ToDoAdapter(items)

        binding.tvToDos.adapter = adapter
        binding.tvToDos.layoutManager = LinearLayoutManager(this)

        binding.bSubmit.setOnClickListener {
            val title = binding.tiToDoValue.text.toString()
            val todo = ToDo(title)
            items.add(todo)
            adapter.notifyItemInserted(items.size - 1)
        }
    }
}