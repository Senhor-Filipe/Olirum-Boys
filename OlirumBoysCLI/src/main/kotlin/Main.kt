import dao.GameDAO
import dao.ReviewDAO
import models.Game
import models.Review

fun main() {
    println("GAME DATA:")

    val gdao = GameDAO()
//    gdao.insert(Game(1, "One Step From Eden", "Humble Games", "Roguelike"))
//    gdao.insert(Game(2, "Final Fantasy XII", "Square Soft", "JRPG"))
//    gdao.insert(Game(3, "Call of Duty", "Infinity Ward", "FPS"))
//    gdao.insert(Game(4, "League of Legends","Riot Games", "MOBA"))
//    gdao.insert(Game(5, "Sid Meier's Civilization VI", "Firaxis Games", "Strategy"))

//    var game = gdao.idSearch(1)
//    println(game)
//    var game = gdao.nameSearch("Final Fantasy XII")
//    println(game)

    var games = gdao.getAll()
    for (game in games)
    {
        println(game)
    }

//    gdao.update(Game(3, "GUILTY GEAR -STRIVE-", "Arc System Works", "Fighting"))
//    gdao.update(Game(3, "Call of Duty", "Infinity Ward", "FPS"))

//    gdao.delete(7)



    println("\nREVIEW DATA:")
    val rdao = ReviewDAO()
//    rdao.insert(Review(1, 1,1,"Jogo desafiante, requer pensamento rapido e velocidade na mao. Viciante, muito bom!", 10))
//    rdao.insert(Review(2, 1,2,"Jogo bonito com trilha sonora muito boa! ", 10))
//    rdao.insert(Review(3, 3,3,"Cheio de hacker e balanceamento ruim. Mas divertido quando jogado com amigos", 6))

    var reviews = rdao.getAll()
    for (review in reviews)
    {
        println(review)
    }

//    var review = rdao.idSearch(1)
//    println(review)

    //rdao.delete(1)

}
