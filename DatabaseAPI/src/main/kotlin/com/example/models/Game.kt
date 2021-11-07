package com.example.models

import kotlinx.serialization.*

@Serializable
data class Game(
    val game_id:Int,
    val game_name:String,
    val developer:String,
    val genre:String,
    val cover:String
)