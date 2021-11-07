package com.example.routes

import com.example.dao.UserDAO
import com.example.models.User
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.userRouting() {
    route("/user") {
        get {
            val users = UserDAO().getAll()
            return@get call.respond(users)
        }

        get("{user_id}") {
            val userId = call.parameters["userId"] ?: return@get call.respondText(
                "Missing or malformed id",
                status = HttpStatusCode.BadRequest
            )

            val user: User = UserDAO().idSearch(userId.toInt())

            return@get call.respond(user)
        }

        delete("{user_id}") {
            val userId = call.parameters["user_id"] ?: return@delete call.respond(HttpStatusCode.BadRequest)
            if (UserDAO().delete(userId.toInt()))
                call.respondText("User removed succesfully", status = HttpStatusCode.Accepted)
            else
                call.respondText("Not found", status = HttpStatusCode.NotFound)
        }

        post {
            val user = call.receive<User>()

            if (UserDAO().insert(user)) {
                call.respondText(
                    "User succesfully created",
                    status = HttpStatusCode.Created
                )
            } else {
                call.respondText(
                    "User could not be created",
                    status = HttpStatusCode.BadRequest
                )
            }
        }

        post("/update") {
            val user = call.receive<User>()

            if (UserDAO().update(user)) {
                call.respondText(
                    "User succesfully updated",
                    status = HttpStatusCode.Created
                )
            } else {
                call.respondText(
                    "User could not be updated",
                    status = HttpStatusCode.BadRequest
                )
            }
        }
    }
}