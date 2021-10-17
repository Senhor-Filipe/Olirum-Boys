package dao

import models.Review

class ReviewDAO : GenericDAO {
    override fun idSearch(id: Int): Any {
        var reviews= mutableListOf<Review>()

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

        return reviews
    }

    fun userIDSearch(id: Int): Any {
        var reviews= mutableListOf<Review>()

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

        return reviews
    }

    fun gameIDSearch(id: Int): Any {
        var reviews= mutableListOf<Review>()

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

        return reviews
    }

    override fun getAll(): List<Any> {

        var reviews= mutableListOf<Review>()

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

        return reviews
    }

    override fun insert(obj: Any) {
        val review = obj as Review

        //No need for possibleDuplicateDetector, since there can be multiple reviews for the same game
        try{
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement(
                """
                    INSERT INTO olirum_boys.Reviews
                    (user_id, game_id, review_body, score)
                    VALUES(?,?,?,?);
                """.trimIndent()
            )
            preparedStatement?.setInt(1, review.user_id)
            preparedStatement?.setInt(2,review.game_id)
            preparedStatement?.setString(3, review.review_body)
            preparedStatement?.setInt(4, review.score)
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
        } catch (e: Exception){
            e.printStackTrace()
        }
    }

    override fun update(obj: Any) {
        val review = obj as Review
        try{
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("""
                UPDATE olirum_boys.Reviews
                SET user_id = ?, game_id = ?, review_body = ?, score = ?
                WHERE review_id= ?;
            """.trimIndent()
            )
            preparedStatement?.setInt(1, review.user_id)
            preparedStatement?.setInt(2,review.game_id)
            preparedStatement?.setString(3, review.review_body)
            preparedStatement?.setInt(4, review.score)
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }
    }

    override fun delete(id: Int) {
        try {
            val connection= ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("DELETE FROM olirum_boys.Reviews WHERE review_id = ${id}")
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
        } catch (e:Exception){
            e.printStackTrace()
        }
    }
}