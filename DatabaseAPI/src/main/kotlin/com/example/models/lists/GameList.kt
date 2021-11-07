package com.example.models.lists

import com.example.models.Game
import kotlinx.serialization.Serializable

@Serializable
data class GameList(
    val game_list:List<Game>
)
