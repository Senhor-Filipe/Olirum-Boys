package com.example.models.lists

import com.example.models.Review
import kotlinx.serialization.Serializable

@Serializable
data class ReviewList(
    val review_list:List<Review>
)