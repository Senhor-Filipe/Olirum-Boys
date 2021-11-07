package com.example.dao

interface GenericDAO
{
    fun idSearch(id: Int): Any
    fun getAll(): Any
    fun insert(obj: Any): Boolean
    fun update(obj: Any): Boolean
    fun delete(id: Int): Boolean
}