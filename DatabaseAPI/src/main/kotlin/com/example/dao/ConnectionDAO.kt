package com.example.dao

import com.example.shared.SharedPaths
import java.sql.*

class ConnectionDAO
{
    var preparedStatement: PreparedStatement?
    val connection: Connection
    var statement: Statement?
    var resultSet: ResultSet?

    init {
        this.connection = DriverManager.getConnection(SharedPaths.JDBC_CONNECTION_STRING, SharedPaths.USERNAME, SharedPaths.PASSWORD)
        this.statement = null
        this.resultSet = null
        this.preparedStatement = null
    }

    fun executeQuery(sqlString: String): ResultSet?
    {
        this.statement = this.connection.createStatement()
        this.resultSet = this.statement?.executeQuery(sqlString)
        return this.resultSet
    }

    fun close()
    {
        this.connection.close()
        this.statement?.close()
        this.resultSet?.close()
    }

    fun getPreparedStatement(sqlString: String): PreparedStatement?
    {
        this.preparedStatement = this.connection.prepareStatement(sqlString)
        return this.preparedStatement
    }

    fun commit()
    {
        this.connection.commit()
    }
}