package com.example.models

import kotlinx.serialization.Serializable

@Serializable
data class User(
    val user_id:Int,
    val user_name:String,
    val user_pwd:String
    //, val user_level:String
)