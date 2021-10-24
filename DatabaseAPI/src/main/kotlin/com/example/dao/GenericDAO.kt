package com.example.dao

interface GenericDAO
{
    fun idSearch(id: Int): Any
    fun getAll(): List<Any>
    fun insert(obj: Any): Boolean
    fun update(obj: Any): Boolean
    fun delete(id: Int): Boolean
}