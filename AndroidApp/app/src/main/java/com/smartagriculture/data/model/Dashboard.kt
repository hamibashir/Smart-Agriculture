package com.smartagriculture.data.model

import com.google.gson.annotations.SerializedName

data class DashboardStats(
    @SerializedName("totalFields")
    val totalFields: Int,
    
    @SerializedName("activeSensors")
    val activeSensors: Int,
    
    @SerializedName("activeAlerts")
    val activeAlerts: Int,
    
    @SerializedName("waterSaved")
    val waterSaved: Double
)

data class CurrentConditions(
    @SerializedName("soilMoisture")
    val soilMoisture: Double,
    
    @SerializedName("temperature")
    val temperature: Double,
    
    @SerializedName("humidity")
    val humidity: Double,
    
    @SerializedName("lastUpdated")
    val lastUpdated: String
)

data class DashboardResponse(
    @SerializedName("success")
    val success: Boolean,
    
    @SerializedName("stats")
    val stats: DashboardStats,
    
    @SerializedName("conditions")
    val conditions: CurrentConditions,
    
    @SerializedName("message")
    val message: String? = null
)

data class RecentActivity(
    @SerializedName("id")
    val id: Int,
    
    @SerializedName("type")
    val type: String,
    
    @SerializedName("title")
    val title: String,
    
    @SerializedName("description")
    val description: String,
    
    @SerializedName("timestamp")
    val timestamp: String,
    
    @SerializedName("icon")
    val icon: String? = null
)
