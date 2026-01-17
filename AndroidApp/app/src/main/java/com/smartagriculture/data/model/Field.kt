package com.smartagriculture.data.model

import com.google.gson.annotations.SerializedName

data class Field(
    @SerializedName("field_id")
    val id: Int,
    
    @SerializedName("field_name")
    val name: String,
    
    @SerializedName("location_latitude")
    val location: String? = null,
    
    @SerializedName("area_size")
    val area: Double,
    
    @SerializedName("area_unit")
    val areaUnit: String? = "acres",
    
    @SerializedName("current_crop")
    val cropType: String? = "Unknown",
    
    @SerializedName("soil_type")
    val soilType: String? = null,
    
    @SerializedName("sensor_count")
    val sensorCount: Int = 0,
    
    @SerializedName("is_active")
    val status: String? = "active",
    
    @SerializedName("planting_date")
    val plantingDate: String? = null,
    
    @SerializedName("expected_harvest_date")
    val harvestDate: String? = null,
    
    @SerializedName("created_at")
    val createdAt: String? = null,
    
    @SerializedName("user_id")
    val userId: Int? = null
)

data class FieldsResponse(
    @SerializedName("success")
    val success: Boolean,
    
    @SerializedName("data")
    val fields: List<Field>,
    
    @SerializedName("message")
    val message: String? = null
)

data class CreateFieldRequest(
    @SerializedName("field_name")
    val name: String,
    
    @SerializedName("location_latitude")
    val location: String,
    
    @SerializedName("area_size")
    val area: Double,
    
    @SerializedName("area_unit")
    val areaUnit: String = "acres",
    
    @SerializedName("current_crop")
    val cropType: String,
    
    @SerializedName("soil_type")
    val soilType: String? = null
)

data class FieldResponse(
    @SerializedName("success")
    val success: Boolean,
    
    @SerializedName("data")
    val field: Field? = null,
    
    @SerializedName("message")
    val message: String? = null
)
