package com.example.dao

import com.example.models.Game
import com.example.models.lists.GameList

class GameDAO: GenericDAO
{
    override fun idSearch(id: Int): Game
    {
        val games = mutableListOf<Game>()

        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM Games WHERE game_id = ${id};")
            while (resultSet?.next()!!)
            {
                games.add(
                    Game(
                        resultSet.getInt("game_id"),
                        resultSet.getString("game_name"),
                        resultSet.getString("developer"),
                        resultSet.getString("genre"),
                        resultSet.getString("cover")
                    )
                )
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }

        return games[0]
    }

    override fun getAll(): GameList
    {
        val games = mutableListOf<Game>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM olirum_boys.Games")

            while (resultSet?.next()!!) {
                games.add(
                    Game(
                        resultSet.getInt("game_id"),
                        resultSet.getString("game_name"),
                        resultSet.getString("developer"),
                        resultSet.getString("genre"),
                        resultSet.getString("cover")
                    )
                )
            }
            connection.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return GameList(games)
    }

    override fun insert(obj: Any): Boolean
    {
        try {
            val game = obj as Game
            if (!possibleDuplicateDetector(game.game_name))
            {
                try {
                    val connection = ConnectionDAO()
                    val preparedStatement = connection.getPreparedStatement(
                        """
                INSERT INTO olirum_boys.Games
                (game_name, developer, genre, cover)
                VALUES (?, ?, ?, ?);
                """.trimMargin()
                    )
                    preparedStatement?.setString(1, game.game_name)
                    preparedStatement?.setString(2, game.developer)
                    preparedStatement?.setString(3, game.genre)
                    preparedStatement?.setString(4, game.cover)
                    preparedStatement?.executeUpdate()
                    connection.commit()
                    connection.close()
                    return true
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        } catch (e: Exception) {
            println("Object received is not a Game object \n")
        }
        return false
    }

    override fun update(obj: Any): Boolean
    {
        try {
            val game = obj as Game
            try {
                val connection = ConnectionDAO()
                val preparedStatement = connection.getPreparedStatement(
                    """
                UPDATE olirum_boys.Games
                SET game_name = ?, developer = ?, genre = ?, cover = ?
                WHERE game_id = ?;
                """.trimMargin()
                )
                preparedStatement?.setString(1, game.game_name)
                preparedStatement?.setString(2, game.developer)
                preparedStatement?.setString(3, game.genre)
                preparedStatement?.setString(4, game.cover)
                preparedStatement?.setInt(5, game.game_id)
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
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("DELETE FROM olirum_boys.Games WHERE game_id = $id")
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
            return true
        } catch (e:Exception) {
            e.printStackTrace()
        }
        return false
    }

    /*
        This function will detect, when inserting a new Game object to the database, if said game already exists
      in the database.
     */
    private fun possibleDuplicateDetector(game_name: String): Boolean
    {
        val possibleDuplicates = mutableListOf<String>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("""
                SELECT *
                FROM olirum_boys.Games
                WHERE game_name = "$game_name"
                """.trimMargin())

            while (resultSet?.next()!!)
            {
                possibleDuplicates.add(resultSet.getString("game_name"))
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }
        if (possibleDuplicates.isEmpty())
            return false
        return true
    }
}