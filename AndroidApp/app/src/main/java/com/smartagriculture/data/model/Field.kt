package com.smartagriculture.data.model

import com.google.gson.annotations.SerializedName

data class Field(
    @SerializedName("id")
    val id: Int,
    
    @SerializedName("name")
    val name: String,
    
    @SerializedName("location")
    val location: String,
    
    @SerializedName("area")
    val area: Double,
    
    @SerializedName("cropType")
    val cropType: String,
    
    @SerializedName("soilType")
    val soilType: String? = null,
    
    @SerializedName("sensorCount")
    val sensorCount: Int = 0,
    
    @SerializedName("status")
    val status: String = "active", // active, inactive, maintenance
    
    @SerializedName("lastIrrigation")
    val lastIrrigation: String? = null,
    
    @SerializedName("createdAt")
    val createdAt: String,
    
    @SerializedName("userId")
    val userId: Int
)

data class FieldsResponse(
    @SerializedName("success")
    val success: Boolean,
    
    @SerializedName("fields")
    val fields: List<Field>,
    
    @SerializedName("message")
    val message: String? = null
)

data class CreateFieldRequest(
    @SerializedName("name")
    val name: String,
    
    @SerializedName("location")
    val location: String,
    
    @SerializedName("area")
    val area: Double,
    
    @SerializedName("cropType")
    val cropType: String,
    
    @SerializedName("soilType")
    val soilType: String? = null
)

data class FieldResponse(
    @SerializedName("success")
    val success: Boolean,
    
    @SerializedName("field")
    val field: Field? = null,
    
    @SerializedName("message")
    val message: String? = null
)
