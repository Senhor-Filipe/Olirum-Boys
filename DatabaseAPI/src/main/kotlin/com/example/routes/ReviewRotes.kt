package com.example.routes

import com.example.dao.ReviewDAO
import com.example.models.Review
import com.example.models.lists.ReviewList
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.reviewRouting() {
    route("/game") {
        get("/review/{game_id}") {
            val gameId = call.parameters["game_id"] ?: return@get call.respondText(
                "Missing or malformed id",
                status = HttpStatusCode.BadRequest
            )

            val reviews: ReviewList = ReviewDAO().gameIDSearch(gameId.toInt())

            return@get call.respond(reviews)
        }
    }

    route("/user") {
        get("review/{user_id}") {
            val userId = call.parameters["user_id"] ?: return@get call.respondText(
                "Missing or malformed id",
                status = HttpStatusCode.BadRequest
            )

            val reviews: ReviewList = ReviewDAO().userIDSearch(userId.toInt())

            return@get call.respond(reviews)
        }
    }

    route("/review") {
        get {
            val reviews = ReviewDAO().getAll()
            return@get call.respond(reviews)
        }

        get("{review_id}") {
            val reviewId = call.parameters["review_id"] ?: return@get call.respondText(
                "Missing or malformed id",
                status = HttpStatusCode.BadRequest
            )

            val review: Review = ReviewDAO().idSearch(reviewId.toInt())

            return@get call.respond(review)
        }

        delete("{review_id}") {
            val reviewId = call.parameters["review_id"] ?: return@delete call.respond(HttpStatusCode.BadRequest)
            if (ReviewDAO().delete(reviewId.toInt()))
                call.respondText("Review removed succesfully", status = HttpStatusCode.Accepted)
            else
                call.respondText("Not found", status = HttpStatusCode.NotFound)
        }

        post {
            val review = call.receive<Review>()

            if (ReviewDAO().insert(review)) {
                call.respondText(
                    "Review succesfully created",
                    status = HttpStatusCode.Created
                )
            } else {
                call.respondText(
                    "Review could not be created",
                    status = HttpStatusCode.BadRequest
                )
            }
        }

        post("/update") {
            val review = call.receive<Review>()

            if (ReviewDAO().update(review)) {
                call.respondText(
                    "Review succesfully updated",
                    status = HttpStatusCode.Created
                )
            } else {
                call.respondText(
                    "Review could not be updated",
                    status = HttpStatusCode.BadRequest
                )
            }
        }
    }
}
