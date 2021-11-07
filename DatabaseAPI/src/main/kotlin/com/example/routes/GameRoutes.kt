package com.example.routes

import com.example.dao.GameDAO
import com.example.models.Game
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.gameRouting() {
    route("/game") {
        get {
            val games = GameDAO().getAll()
            return@get call.respond(games)
        }

        get("{game_id}") {
            val gameId = call.parameters["game_id"] ?: return@get call.respondText(
                "Missing or malformed id",
                status = HttpStatusCode.BadRequest
            )

            val game = GameDAO().idSearch(gameId.toInt())

            return@get call.respond(game)
        }

        delete("{game_id}") {
            val gameId = call.parameters["game_id"] ?: return@delete call.respond(HttpStatusCode.BadRequest)
            if (GameDAO().delete(gameId.toInt()))
                call.respondText("Game removed succesfully", status = HttpStatusCode.Accepted)
            else
                call.respondText("Not found", status = HttpStatusCode.NotFound)
        }

        post {
            val game = call.receive<Game>()

            if (GameDAO().insert(game)) {
                call.respondText(
                    "Game succesfully created",
                    status = HttpStatusCode.Created
                )
            } else {
                call.respondText(
                    "Game could not be created",
                    status = HttpStatusCode.BadRequest
                )
            }
        }

        post("/update") {
            val game = call.receive<Game>()

            if (GameDAO().update(game)) {
                call.respondText(
                    "Game succesfully updated",
                    status = HttpStatusCode.Created
                )
            } else {
                call.respondText(
                    "Game could not be updated",
                    status = HttpStatusCode.BadRequest
                )
            }
        }
    }
}