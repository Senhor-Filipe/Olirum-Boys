package dao

interface GenericDAO
{
    fun takeOne(id: Int): Any
    fun takeAll(): List<Any>
    fun insertOne(obj: Any): Unit
    fun insertMany(list: List<Any>): Unit
    fun update(abj: Any): Unit
    fun delete(id: Int): Unit
}