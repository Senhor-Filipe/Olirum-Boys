package com.example.plugins

import com.example.routes.gameRouting
import com.example.routes.userRouting
import io.ktor.routing.*
import io.ktor.application.*

fun Application.configureRouting() {
    routing {
        gameRouting()
        userRouting()
    }
}
