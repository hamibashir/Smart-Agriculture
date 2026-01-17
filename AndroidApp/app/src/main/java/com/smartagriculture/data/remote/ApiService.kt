package com.smartagriculture.data.remote

import com.smartagriculture.data.model.*
import retrofit2.Response
import retrofit2.http.*

interface ApiService {
    
    // Authentication
    @POST("auth/login")
    suspend fun login(@Body request: LoginRequest): Response<LoginResponse>
    
    @POST("auth/register")
    suspend fun register(@Body request: RegisterRequest): Response<RegisterResponse>
    
    @GET("auth/profile")
    suspend fun getProfile(): Response<ProfileResponse>
    
    // Dashboard
    @GET("dashboard/stats")
    suspend fun getDashboardStats(): Response<DashboardResponse>
    
    @GET("dashboard/activity")
    suspend fun getRecentActivity(): Response<List<RecentActivity>>
    
    // Fields
    @GET("fields")
    suspend fun getFields(): Response<FieldsResponse>
    
    @GET("fields/{id}")
    suspend fun getFieldById(@Path("id") fieldId: Int): Response<FieldResponse>
    
    @POST("fields")
    suspend fun createField(@Body request: CreateFieldRequest): Response<FieldResponse>
    
    @PUT("fields/{id}")
    suspend fun updateField(
        @Path("id") fieldId: Int,
        @Body request: CreateFieldRequest
    ): Response<FieldResponse>
    
    @DELETE("fields/{id}")
    suspend fun deleteField(@Path("id") fieldId: Int): Response<FieldResponse>
    
    // Sensors
    // Alerts
    // etc.
}
