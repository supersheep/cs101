package com.example.listsample.model

import java.time.LocalDateTime
import java.util.Date
import java.util.UUID

data class Message(
    val id: Int = 0,
    val content: String,
    val time: Date
) {
}