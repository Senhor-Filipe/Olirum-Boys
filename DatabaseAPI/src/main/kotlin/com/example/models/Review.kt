package com.example.models

import kotlinx.serialization.Serializable

@Serializable
data class Review(
    val review_id:Int,
    val user_id:Int,
    val game_id:Int,
    val review_body:String,
    val score:Int
)