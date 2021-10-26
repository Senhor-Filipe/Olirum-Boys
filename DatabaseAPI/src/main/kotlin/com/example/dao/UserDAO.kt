package com.example.dao

import com.example.models.User

class UserDAO: GenericDAO
{
    override fun idSearch(user_id: Int): List<User>
    {
        var users = mutableListOf<User>()

        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM Users WHERE user_id = ${user_id};")
            while (resultSet?.next()!!)
            {
                users.add(
                    User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("user_name"),
                        resultSet.getString("user_pwd")
                        //, resultSet.getString("user_level")
                    )
                )
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }

        return users
    }

    fun nameSearch(user_name: String): List<User>
    {
        var user = mutableListOf<User>()

        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM Users WHERE user_name = \"${user_name}\";")
            while (resultSet?.next()!!)
            {
                user.add(
                    User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("user_name"),
                        resultSet.getString("user_pwd")
                        //, resultSet.getString("user_level")
                    )
                )
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }

        return user
    }

    override fun getAll(): List<User>
    {
        var users = mutableListOf<User>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM olirum_boys.Users")

            while (resultSet?.next()!!)
            {
                users.add(
                    User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("user_name"),
                        resultSet.getString("user_pwd")
                        //, resultSet.getString("user_level")
                    )
                )
            }
            connection.close()
        } catch (e:Exception) {
            e.printStackTrace()
        }
        return users
    }

    override fun insert(obj: Any): Boolean
    {
        try {
            val user = obj as User
            if (!possibleDuplicateDetector(user.user_name)) {
                try {
                    val connection = ConnectionDAO()
                    val preparedStatement = connection.getPreparedStatement(
                        """
                INSERT INTO olirum_boys.Users
                (user_name, user_pwd)
                VALUES (?, ?);
                """.trimMargin()
                    )
                    preparedStatement?.setString(1, user.user_name)
                    preparedStatement?.setString(2, user.user_pwd)
                    preparedStatement?.executeUpdate()
                    connection.commit()
                    connection.close()
                    return true
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            } else {
                println("User already exists in the database.")
                println(nameSearch(user.user_name))
                println("\n")
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return false
    }

    override fun update(obj: Any): Boolean
    {
        try {
            val user = obj as User
            try {
                val connection = ConnectionDAO()
                val preparedStatement = connection.getPreparedStatement(
                    """
                UPDATE olirum_boys.Users
                SET user_name = ?, user_pwd = ?
                WHERE user_id = ?;
                """.trimMargin()
                )
                preparedStatement?.setString(1, user.user_name)
                preparedStatement?.setString(2, user.user_pwd)
                preparedStatement?.setInt(3, user.user_id)
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

    override fun delete(user_id: Int): Boolean
    {
        try {
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("DELETE FROM olirum_boys.Users WHERE user_id = ${user_id}")
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
        This function will detect, when inserting a new User object to the database, if said user already exists
      in the database.
     */
    fun possibleDuplicateDetector(user_name: String): Boolean
    {
        var possibleDuplicates = mutableListOf<String>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("""
                SELECT *
                FROM olirum_boys.Users
                WHERE user_name = "${user_name}"
                """.trimMargin())

            while (resultSet?.next()!!)
            {
                possibleDuplicates.add(resultSet.getString("user_name"))
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