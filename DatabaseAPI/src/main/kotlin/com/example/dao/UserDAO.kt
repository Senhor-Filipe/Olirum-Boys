package com.example.dao

import com.example.models.User
import com.example.models.lists.UserList

class UserDAO: GenericDAO
{
    override fun idSearch(id: Int): User
    {
        val users = mutableListOf<User>()

        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM Users WHERE user_id = $id;")
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

        return users[0]
    }

    fun nameSearch(name: String): User
    {
        val users = mutableListOf<User>()

        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("SELECT * FROM Users WHERE user_name = $name;")
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

        return users[0]
    }

    override fun getAll(): UserList
    {
        val users = mutableListOf<User>()
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
        return UserList(users)
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
                println("Username already exists in the database.")
                println(user.user_name)
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

    override fun delete(id: Int): Boolean
    {
        try {
            val connection = ConnectionDAO()
            val preparedStatement = connection.getPreparedStatement("DELETE FROM olirum_boys.Users WHERE user_id = $id")
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
    private fun possibleDuplicateDetector(user_name: String): Boolean
    {
        val possibleDuplicates = mutableListOf<String>()
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

    fun login(user: User): Boolean {
        val possibleLogin = mutableListOf<User>()
        try {
            val connection = ConnectionDAO()
            val resultSet = connection.executeQuery("""
                SELECT *
                FROM olirum_boys.Users
                WHERE user_name = "${user.user_name}"
            """.trimIndent())

            while (resultSet?.next()!!)
            {
                possibleLogin.add(
                    User(
                        resultSet.getInt("user_id"),
                        resultSet.getString("user_name"),
                        resultSet.getString("user_pwd")
                    )
                )
            }
            connection.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        for (u in possibleLogin) {
            if (u.user_pwd == user.user_pwd)
                return true
        }
        return false
    }
}