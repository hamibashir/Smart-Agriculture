package com.smartagriculture.data.model

import com.google.gson.annotations.SerializedName

data class User(
    @SerializedName("id")
    val id: Int,
    
    @SerializedName("name")
    val name: String,
    
    @SerializedName("email")
    val email: String,
    
    @SerializedName("phone")
    val phone: String? = null,
    
    @SerializedName("location")
    val location: String? = null
)

data class LoginRequest(
    val email: String,
    val password: String
)

data class LoginResponse(
    val success: Boolean,
    val token: String,
    val user: User,
    val message: String? = null
)

data class RegisterRequest(
    @SerializedName("full_name")
    val fullName: String,
    val email: String,
    val password: String,
    val phone: String? = null
)

data class RegisterResponse(
    val success: Boolean,
    val message: String? = null,
    val token: String? = null,
    val user: User? = null
)

data class ProfileResponse(
    val success: Boolean,
    val data: User? = null,
    val message: String? = null
)
