package com.example.plugins

import com.example.routes.gameRouting
import io.ktor.routing.*
import io.ktor.application.*

fun Application.configureRouting() {
    routing {
        gameRouting()
    }
}
