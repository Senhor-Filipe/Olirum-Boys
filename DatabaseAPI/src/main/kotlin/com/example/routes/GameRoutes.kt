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
        getAll()
        gameById()
        insertGame()
        updateGame()
        deleteGame()
    }
}

fun Route.getAll() {
    get {
        val games = GameDAO().getAll()
        return@get call.respond(games)
    }
}

fun Route.gameById() {
    get("{id}") {
        val gameId = call.parameters["id"] ?: return@get call.respondText(
            "Missing or malformed id",
            status = HttpStatusCode.BadRequest
        )

        val game: List<Game> = GameDAO().idSearch(gameId.toInt())

        if (game.isEmpty())
            return@get call.respondText(
                "No game with id $gameId",
                status = HttpStatusCode.NotFound
            )
        call.respond(game)
    }
}

fun Route.insertGame() {
    //Not tested yet!!
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
}

fun Route.updateGame() {
    // TODO: 23/10/2021  
}

fun Route.deleteGame() {
    delete("{id}") {
        val gameId = call.parameters["id"] ?: return@delete call.respond(HttpStatusCode.BadRequest)
        if (GameDAO().delete(gameId.toInt()))
            call.respondText("Game removed succesfully", status = HttpStatusCode.Accepted)
        else
            call.respondText("Not found", status = HttpStatusCode.NotFound)
    }
}