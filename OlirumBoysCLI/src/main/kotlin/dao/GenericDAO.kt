package dao

interface GenericDAO
{
    fun idSearch(id: Int): Any
    fun getAll(): List<Any>
    fun insert(obj: Any): Unit
    fun update(obj: Any): Unit
    fun delete(id: Int): Unit
}