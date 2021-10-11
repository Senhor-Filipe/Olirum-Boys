import dao.GameDAO

fun main() {
    val gameDAO = GameDAO()
    var game = gameDAO.idSearch(1)
    println(game)
}