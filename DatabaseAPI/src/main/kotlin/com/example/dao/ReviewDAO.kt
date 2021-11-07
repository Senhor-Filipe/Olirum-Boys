package com.example.dao

import com.example.models.Review
import com.example.models.lists.ReviewList

class ReviewDAO : GenericDAO
{
    override fun idSearch(id: Int): Review
    {
        val reviews = mutableListOf<Review>()

        try {
            val connection = ConnectionDAO()
            val resultSet= connection.executeQuery("SELECT * FROM Reviews WHERE review_id= ${id};")
            while (resultSet?.next()!!){
                reviews.add(
                    Review(
                        resultSet.getInt("review_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("game_id"),
                        resultSet.getString("review_body"),
                        resultSet.getInt("score")
                    )
                )
            }
            connection.close()
        } catch (e:Exception){
            e.printStackTrace()
        }

        return reviews[0]
    }

    fun userIDSearch(user_id: Int): ReviewList
    {
        val reviews = mutableListOf<Review>()
        try {
            val connection = ConnectionDAO()
            val resultSet= connection.executeQuery("SELECT * FROM Reviews WHERE user_id = ${user_id};")
            while (resultSet?.next()!!){
                reviews.add(
                    Review(
                        resultSet.getInt("review_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("game_id"),
                        resultSet.getString("review_body"),
                        resultSet.getInt("score")
                    )
                )
            }
            connection.close()
        } catch (e:Exception){
            e.printStackTrace()
        }

        return ReviewList(reviews)
    }

    fun gameIDSearch(game_id: Int): ReviewList
    {
        val reviews= mutableListOf<Review>()

        try {
            val connection = ConnectionDAO()
            val resultSet= connection.executeQuery("SELECT * FROM Reviews WHERE game_id= ${game_id};")
            while (resultSet?.next()!!){
                reviews.add(
                    Review(
                        resultSet.getInt("review_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("game_id"),
                        resultSet.getString("review_body"),
                        resultSet.getInt("score")
                    )
                )
            }
            connection.close()
        } catch (e:Exception){
            e.printStackTrace()
        }

        return ReviewList(reviews)
    }

    override fun getAll(): ReviewList
    {

        val reviews= mutableListOf<Review>()

        try {
            val connection = ConnectionDAO()
            val resultSet= connection.executeQuery("SELECT * FROM olirum_boys.Reviews")
            while (resultSet?.next()!!){
                reviews.add(
                    Review(
                        resultSet.getInt("review_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("game_id"),
                        resultSet.getString("review_body"),
                        resultSet.getInt("score")
                    )
                )
            }
            connection.close()
        } catch (e:Exception){
            e.printStackTrace()
        }

        return ReviewList(reviews)
    }

    override fun insert(obj: Any): Boolean
    {
        try {
            val review = obj as Review
            try {
                val connection = ConnectionDAO()
                val preparedStatement = connection.getPreparedStatement(
                    """
                    INSERT INTO olirum_boys.Reviews
                    (user_id, game_id, review_body, score)
                    VALUES(?,?,?,?);
                """.trimIndent()
                )
                preparedStatement?.setInt(1, review.user_id)
                preparedStatement?.setInt(2, review.game_id)
                preparedStatement?.setString(3, review.review_body)
                preparedStatement?.setInt(4, review.score)
                preparedStatement?.executeUpdate()
                connection.commit()
                connection.close()
                return true
            } catch (e: Exception) {
                e.printStackTrace()
            }
        } catch (e: Exception) {
            println("Object received is not a Review object \n")
        }
        return false
    }

    override fun update(obj: Any): Boolean
    {
        try {
            val review = obj as Review
            try {
                val connection = ConnectionDAO()
                val preparedStatement = connection.getPreparedStatement(
                    """
                UPDATE olirum_boys.Reviews
                SET user_id = ?, game_id = ?, review_body = ?, score = ?
                WHERE review_id= ?;
            """.trimIndent()
                )
                preparedStatement?.setInt(1, review.user_id)
                preparedStatement?.setInt(2, review.game_id)
                preparedStatement?.setString(3, review.review_body)
                preparedStatement?.setInt(4, review.score)
                preparedStatement?.executeUpdate()
                connection.commit()
                connection.close()
                return true
            } catch (e: Exception) {
                e.printStackTrace()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return false
    }

    override fun delete(id: Int): Boolean
    {
        try {
            val connection= ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("DELETE FROM olirum_boys.Reviews WHERE review_id = $id")
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
            return true
        } catch (e:Exception){
            e.printStackTrace()
        }
        return false
    }
}