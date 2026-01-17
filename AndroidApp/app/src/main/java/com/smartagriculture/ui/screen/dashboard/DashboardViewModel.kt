package com.smartagriculture.ui.screen.dashboard

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.smartagriculture.data.model.CurrentConditions
import com.smartagriculture.data.model.DashboardStats
import com.smartagriculture.data.remote.RetrofitClient
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class DashboardUiState(
    val isLoading: Boolean = false,
    val stats: DashboardStats? = null,
    val conditions: CurrentConditions? = null,
    val error: String? = null
)

class DashboardViewModel : ViewModel() {
    
    private val _uiState = MutableStateFlow(DashboardUiState())
    val uiState: StateFlow<DashboardUiState> = _uiState.asStateFlow()
    
    fun loadDashboard() {
        _uiState.value = _uiState.value.copy(
            isLoading = true,
            error = null
        )
        
        viewModelScope.launch {
            try {
                val response = RetrofitClient.apiService.getDashboardStats()
                
                if (response.isSuccessful && response.body() != null) {
                    val dashboardData = response.body()!!
                    
                    if (dashboardData.success) {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            stats = dashboardData.stats,
                            conditions = dashboardData.conditions,
                            error = null
                        )
                    } else {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = dashboardData.message ?: "Failed to load dashboard"
                        )
                    }
                } else {
                    _uiState.value = _uiState.value.copy(
                        isLoading = false,
                        error = "Server error: ${response.code()}"
                    )
                }
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    isLoading = false,
                    error = "Network error: ${e.localizedMessage}"
                )
            }
        }
    }
    
    fun refresh() {
        loadDashboard()
    }
}
