package com.smartagriculture.ui.screen.auth

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.smartagriculture.data.model.RegisterRequest
import com.smartagriculture.data.remote.RetrofitClient
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class RegisterUiState(
    val fullName: String = "",
    val email: String = "",
    val phone: String = "",
    val password: String = "",
    val confirmPassword: String = "",
    val fullNameError: String? = null,
    val emailError: String? = null,
    val phoneError: String? = null,
    val passwordError: String? = null,
    val confirmPasswordError: String? = null,
    val isLoading: Boolean = false,
    val error: String? = null,
    val isSuccess: Boolean = false
)

class RegisterViewModel : ViewModel() {
    
    private val _uiState = MutableStateFlow(RegisterUiState())
    val uiState: StateFlow<RegisterUiState> = _uiState.asStateFlow()
    
    fun updateFullName(value: String) {
        _uiState.value = _uiState.value.copy(
            fullName = value,
            fullNameError = null
        )
    }
    
    fun updateEmail(value: String) {
        _uiState.value = _uiState.value.copy(
            email = value,
            emailError = null
        )
    }
    
    fun updatePhone(value: String) {
        _uiState.value = _uiState.value.copy(
            phone = value,
            phoneError = null
        )
    }
    
    fun updatePassword(value: String) {
        _uiState.value = _uiState.value.copy(
            password = value,
            passwordError = null
        )
    }
    
    fun updateConfirmPassword(value: String) {
        _uiState.value = _uiState.value.copy(
            confirmPassword = value,
            confirmPasswordError = null
        )
    }
    
    fun register() {
        // Clear previous errors
        _uiState.value = _uiState.value.copy(
            fullNameError = null,
            emailError = null,
            phoneError = null,
            passwordError = null,
            confirmPasswordError = null,
            error = null
        )
        
        val state = _uiState.value
        var hasError = false
        
        // Validate full name
        if (state.fullName.isBlank()) {
            _uiState.value = _uiState.value.copy(fullNameError = "Name is required")
            hasError = true
        }
        
        // Validate email
        if (state.email.isBlank()) {
            _uiState.value = _uiState.value.copy(emailError = "Email is required")
            hasError = true
        } else if (!android.util.Patterns.EMAIL_ADDRESS.matcher(state.email).matches()) {
            _uiState.value = _uiState.value.copy(emailError = "Invalid email format")
            hasError = true
        }
        
        // Validate phone
        if (state.phone.isBlank()) {
            _uiState.value = _uiState.value.copy(phoneError = "Phone number is required")
            hasError = true
        }
        
        // Validate password
        if (state.password.isBlank()) {
            _uiState.value = _uiState.value.copy(passwordError = "Password is required")
            hasError = true
        } else if (state.password.length < 6) {
            _uiState.value = _uiState.value.copy(passwordError = "Password must be at least 6 characters")
            hasError = true
        }
        
        // Validate confirm password
        if (state.confirmPassword.isBlank()) {
            _uiState.value = _uiState.value.copy(confirmPasswordError = "Please confirm your password")
            hasError = true
        } else if (state.password != state.confirmPassword) {
            _uiState.value = _uiState.value.copy(confirmPasswordError = "Passwords do not match")
            hasError = true
        }
        
        if (hasError) return
        
        // Make API call
        _uiState.value = _uiState.value.copy(isLoading = true, error = null)
        
        viewModelScope.launch {
            try {
                val request = RegisterRequest(
                    fullName = state.fullName.trim(),
                    email = state.email.trim(),
                    phone = state.phone.trim(),
                    password = state.password
                )
                
                val response = RetrofitClient.apiService.register(request)
                
                if (response.isSuccessful && response.body() != null) {
                    val result = response.body()!!
                    
                    if (result.success) {
                        // Save token if provided
                        result.token?.let { RetrofitClient.setAuthToken(it) }
                        
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            isSuccess = true,
                            error = null
                        )
                    } else {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = result.message ?: "Registration failed"
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
}
