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

        val manager = ToDoPersistenceManager()
        var list = manager.getAllToDos().toMutableList()

        val adapter = ToDoAdapter(list)

        binding.tvToDos.adapter = adapter
        binding.tvToDos.layoutManager = LinearLayoutManager(this)

        binding.bSubmit.setOnClickListener {
            val title = binding.tiToDoValue.text.toString()
            val todo = ToDo(title)
            list.add(todo)
            adapter.notifyItemInserted(list.size - 1)
            manager.save(todo)
        }
    }
}