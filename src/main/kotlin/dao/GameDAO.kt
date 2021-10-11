package dao

import models.Game

class GameDAO: GenericDAO {
    override fun takeOne(id: Int): Any {
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

    override fun takeAll(): List<Any>
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

    override fun insertOne(obj: Any) {
        TODO("Not yet implemented")
    }

    override fun insertMany(list: List<Any>) {
        TODO("Not yet implemented")
    }

    override fun update(abj: Any) {
        TODO("Not yet implemented")
    }

    override fun delete(id: Int) {
        TODO("Not yet implemented")
    }
}