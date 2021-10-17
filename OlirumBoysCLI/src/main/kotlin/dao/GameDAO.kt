package dao

import models.Game

class GameDAO: GenericDAO {
    override fun idSearch(id: Int): Any
    {
        var games = mutableListOf<Game>()

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
                        resultSet.getString("genre")
                    )
                )
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }

        return games
    }

    fun nameSearch(game_name: String): Any
    {
        var games = mutableListOf<Game>()

        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM Games WHERE game_name = \"${game_name}\";")
            while (resultSet?.next()!!)
            {
                games.add(
                    Game(
                        resultSet.getInt("game_id"),
                        resultSet.getString("game_name"),
                        resultSet.getString("developer"),
                        resultSet.getString("genre")
                    )
                )
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }

        return games
    }

    override fun getAll(): List<Any>
    {
        var games = mutableListOf<Game>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM olirum_boys.Games")

            while (resultSet?.next()!!)
            {
                games.add(
                    Game(
                        resultSet.getInt("game_id"),
                        resultSet.getString("game_name"),
                        resultSet.getString("developer"),
                        resultSet.getString("genre")
                    )
                )
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }
        return games
    }

    override fun insert(obj: Any)
    {
        val game = obj as Game
        if (!possibleDuplicateDetector(game.game_name))
        {
            try {
                val connection = ConnectionDAO()
                val preparedStatement = connection.getPreparedStatement(
                    """
                INSERT INTO olirum_boys.Games
                (game_name, developer, genre)
                VALUES (?, ?, ?);
                """.trimMargin()
                )
                preparedStatement?.setString(1, game.game_name)
                preparedStatement?.setString(2, game.developer)
                preparedStatement?.setString(3, game.genre)
                preparedStatement?.executeUpdate()
                connection.commit()
                connection.close()
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
        else
        {
            println("Game already exists in the database.")
            println(nameSearch(game.game_name))
            println("\n")
        }
    }

    override fun update(obj: Any)
    {
        val game = obj as Game
        try {
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("""
                UPDATE olirum_boys.Games
                SET game_name = ?, developer = ?, genre = ?
                WHERE game_id = ?;
                """.trimMargin())
            preparedStatement?.setString(1, game.game_name)
            preparedStatement?.setString(2, game.developer)
            preparedStatement?.setString(3, game.genre)
            preparedStatement?.setInt(4, game.game_id)
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }
    }

    override fun delete(id: Int)
    {
        try {
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("DELETE FROM olirum_boys.Games WHERE game_id = ${id}")
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }
    }

    /*
        This function will detect, when inserting a new Game object to the database, if said game already exists
      in the database.
     */
    fun possibleDuplicateDetector(game_name: String): Boolean
    {
        var possibleDuplicates = mutableListOf<String>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("""
                SELECT *
                FROM olirum_boys.Games
                WHERE game_name = "${game_name}"
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