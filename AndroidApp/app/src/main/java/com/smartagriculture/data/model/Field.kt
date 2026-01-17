package com.smartagriculture.data.model

import com.google.gson.annotations.SerializedName

data class Field(
    @SerializedName("field_id")
    val id: Int,
    
    @SerializedName("name")
    val name: String,
    
    @SerializedName("location")
    val location: String,
    
    @SerializedName("area")
    val area: Double,
    
    @SerializedName("crop_type")
    val cropType: String? = "Unknown",
    
    @SerializedName("soil_type")
    val soilType: String? = null,
    
    @SerializedName("sensor_count")
    val sensorCount: Int = 0,
    
    @SerializedName("status")
    val status: String? = "active", // active, inactive, maintenance
    
    @SerializedName("last_irrigation")
    val lastIrrigation: String? = null,
    
    @SerializedName("created_at")
    val createdAt: String? = null,
    
    @SerializedName("user_id")
    val userId: Int? = null
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
    
    @SerializedName("crop_type")
    val cropType: String,
    
    @SerializedName("soil_type")
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
