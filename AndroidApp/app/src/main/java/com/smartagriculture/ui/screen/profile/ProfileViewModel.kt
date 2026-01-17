package com.smartagriculture.ui.screen.profile

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.smartagriculture.data.model.User
import com.smartagriculture.data.remote.RetrofitClient
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class ProfileUiState(
    val user: User? = null,
    val isLoading: Boolean = false,
    val error: String? = null,
    val isLoggedOut: Boolean = false
)

class ProfileViewModel : ViewModel() {
    
    private val _uiState = MutableStateFlow(ProfileUiState())
    val uiState: StateFlow<ProfileUiState> = _uiState.asStateFlow()
    
    fun loadProfile() {
        _uiState.value = _uiState.value.copy(isLoading = true, error = null)
        
        viewModelScope.launch {
            try {
                val response = RetrofitClient.apiService.getProfile()
                
                if (response.isSuccessful && response.body() != null) {
                    val result = response.body()!!
                    
                    if (result.success && result.data != null) {
                        _uiState.value = _uiState.value.copy(
                            user = result.data,
                            isLoading = false,
                            error = null
                        )
                    } else {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = "Failed to load profile"
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
    
    fun logout() {
        // Clear auth token
        RetrofitClient.setAuthToken(null)
        
        // Update state to trigger navigation
        _uiState.value = _uiState.value.copy(isLoggedOut = true)
    }
}
