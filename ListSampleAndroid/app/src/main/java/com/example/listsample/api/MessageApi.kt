package com.example.listsample.api

import com.example.listsample.model.Message
import com.google.gson.annotations.SerializedName
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST

data class MessageResp (
    val items: List<Message>,
    val totalPages: Int
)

data class AddMessageResp(
    val id: Int
)

data class AddMessageReq(
    @SerializedName("content")
    val content: String
)

interface MessageApi {
    @POST("/message")
    suspend fun addMessage(@Body() message: AddMessageReq): AddMessageResp

    @GET("/message")
    suspend fun getMessages(): MessageResp
}