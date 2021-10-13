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

    override fun getAll(): List<Any>
    {
        var games = mutableListOf<Game>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM Games")

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
        try {
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("""
                INSERT INTO olirum_boys.Games
                (game_name, developer, genre)
                VALUES (?, ?, ?);
                """.trimMargin())
            preparedStatement?.setString(1, game.game_name)
            preparedStatement?.setString(2, game.developer)
            preparedStatement?.setString(3, game.genre)
            preparedStatement?.executeUpdate()
            connection.commit()
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
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

    override fun delete(id: Int) {
        TODO("Not yet implemented")
    }
}