package com.example.plugins

import io.ktor.gson.*
import io.ktor.features.*
import io.ktor.serialization.*
import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*

fun Application.configureSerialization() {
    install(ContentNegotiation) {
        json()
        gson {
        }
    }

    routing {
        get("/json/gson") {
                call.respond(mapOf("hello" to "world"))
            }
        get("/json/kotlinx-serialization") {
                call.respond(mapOf("hello" to "world"))
            }
    }
}
