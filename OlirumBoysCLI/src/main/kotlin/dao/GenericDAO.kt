package dao

interface GenericDAO
{
    fun idSearch(id: Int): Any
    fun showAll(): List<Any>
    fun insertOne(obj: Any): Unit
    fun update(abj: Any): Unit
    fun delete(id: Int): Unit
}