package shared

class SharedPaths
{
    companion object {
        //Insert in host and port accordingly to your dbeaver/VM. The same will apply to database, username and password.
        //try using .gitignore on this file
        val JDBC_CONNECTION_STRING = "jdbc:mysql://192.168.56.101:3306/olirum_boys"
        val USERNAME = "admin"
        val PASSWORD = "admin"
    }
}