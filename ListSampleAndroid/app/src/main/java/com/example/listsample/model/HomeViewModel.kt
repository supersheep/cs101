package com.example.listsample.model

import android.os.Build
import androidx.annotation.RequiresApi
import androidx.compose.runtime.*
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.listsample.api.AddMessageReq
import com.example.listsample.api.MessageApi
import com.example.listsample.api.RequestClient
import kotlinx.coroutines.launch
import java.util.Date

class HomeViewModel: ViewModel() {
    private val messageService = RequestClient.getInstance().create(MessageApi::class.java)

    var text = mutableStateOf("")
    var messages: MutableState<List<Message>> = mutableStateOf(listOf())

    fun updateText(it: String) {
        text.value = it
    }

    fun loadData() {
        viewModelScope.launch {
            messages.value = messageService.getMessages().items
        }
    }

    suspend fun addMessage() {
        try {
            val resp = messageService.addMessage(AddMessageReq(text.value))
            val message = Message(resp.id, text.value, Date())
            val result = mutableListOf<Message>()
            result.add(message)
            result.addAll(messages.value)
            messages.value = result
            text.value = ""
        } catch (e: java.lang.Error) {
            print(e)
        }
    }
}