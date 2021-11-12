package com.example.models

import kotlinx.serialization.Serializable

@Serializable
data class Review(
    val review_id:Int,
    val user:User,
    val game:Game,
    val review_body:String,
    val score:Int
)