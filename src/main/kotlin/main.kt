import dao.GameDAO

fun main() {
    val gameDAO = GameDAO()
    var game = gameDAO.takeOne(1)
    println(game)
}