package com.smartagriculture.ui.screen.fields

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.smartagriculture.data.model.CreateFieldRequest
import com.smartagriculture.data.remote.RetrofitClient
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class AddFieldUiState(
    val name: String = "",
    val location: String = "",
    val area: String = "",
    val cropType: String = "",
    val soilType: String = "",
    val nameError: String? = null,
    val locationError: String? = null,
    val areaError: String? = null,
    val cropTypeError: String? = null,
    val isLoading: Boolean = false,
    val error: String? = null,
    val isSuccess: Boolean = false
)

class AddFieldViewModel : ViewModel() {
    
    private val _uiState = MutableStateFlow(AddFieldUiState())
    val uiState: StateFlow<AddFieldUiState> = _uiState.asStateFlow()
    
    fun updateName(value: String) {
        _uiState.value = _uiState.value.copy(
            name = value,
            nameError = null
        )
    }
    
    fun updateLocation(value: String) {
        _uiState.value = _uiState.value.copy(
            location = value,
            locationError = null
        )
    }
    
    fun updateArea(value: String) {
        _uiState.value = _uiState.value.copy(
            area = value,
            areaError = null
        )
    }
    
    fun updateCropType(value: String) {
        _uiState.value = _uiState.value.copy(
            cropType = value,
            cropTypeError = null
        )
    }
    
    fun updateSoilType(value: String) {
        _uiState.value = _uiState.value.copy(soilType = value)
    }
    
    fun createField() {
        // Clear previous errors
        _uiState.value = _uiState.value.copy(
            nameError = null,
            locationError = null,
            areaError = null,
            cropTypeError = null,
            error = null
        )
        
        // Validate inputs
        val state = _uiState.value
        var hasError = false
        
        if (state.name.isBlank()) {
            _uiState.value = _uiState.value.copy(nameError = "Field name is required")
            hasError = true
        }
        
        if (state.location.isBlank()) {
            _uiState.value = _uiState.value.copy(locationError = "Location is required")
            hasError = true
        }
        
        if (state.area.isBlank()) {
            _uiState.value = _uiState.value.copy(areaError = "Area is required")
            hasError = true
        } else {
            val areaValue = state.area.toDoubleOrNull()
            if (areaValue == null || areaValue <= 0) {
                _uiState.value = _uiState.value.copy(areaError = "Enter a valid area")
                hasError = true
            }
        }
        
        if (state.cropType.isBlank()) {
            _uiState.value = _uiState.value.copy(cropTypeError = "Please select a crop type")
            hasError = true
        }
        
        if (hasError) return
        
        // Make API call
        _uiState.value = _uiState.value.copy(isLoading = true, error = null)
        
        viewModelScope.launch {
            try {
                val request = CreateFieldRequest(
                    name = state.name.trim(),
                    location = state.location.trim(),
                    area = state.area.toDouble(),
                    cropType = state.cropType,
                    soilType = if (state.soilType.isBlank()) null else state.soilType
                )
                
                val response = RetrofitClient.apiService.createField(request)
                
                if (response.isSuccessful && response.body() != null) {
                    val result = response.body()!!
                    
                    if (result.success) {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            isSuccess = true,
                            error = null
                        )
                    } else {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = result.message ?: "Failed to create field"
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
