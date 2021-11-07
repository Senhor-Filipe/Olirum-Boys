package com.example.models.lists

import com.example.models.User
import kotlinx.serialization.Serializable

@Serializable
data class UserList(
    val user_list:List<User>
)