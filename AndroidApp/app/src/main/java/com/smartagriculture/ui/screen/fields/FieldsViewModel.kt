package com.smartagriculture.ui.screen.fields

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.smartagriculture.data.model.Field
import com.smartagriculture.data.remote.RetrofitClient
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class FieldsUiState(
    val isLoading: Boolean = false,
    val fields: List<Field> = emptyList(),
    val error: String? = null
)

class FieldsViewModel : ViewModel() {
    
    private val _uiState = MutableStateFlow(FieldsUiState())
    val uiState: StateFlow<FieldsUiState> = _uiState.asStateFlow()
    
    fun loadFields() {
        _uiState.value = _uiState.value.copy(
            isLoading = true,
            error = null
        )
        
        viewModelScope.launch {
            try {
                val response = RetrofitClient.apiService.getFields()
                
                if (response.isSuccessful && response.body() != null) {
                    val fieldsResponse = response.body()!!
                    
                    if (fieldsResponse.success) {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            fields = fieldsResponse.fields,
                            error = null
                        )
                    } else {
                        _uiState.value = _uiState.value.copy(
                            isLoading = false,
                            error = fieldsResponse.message ?: "Failed to load fields"
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
    
    fun deleteField(fieldId: Int) {
        viewModelScope.launch {
            try {
                val response = RetrofitClient.apiService.deleteField(fieldId)
                
                if (response.isSuccessful && response.body()?.success == true) {
                    // Remove field from local list
                    _uiState.value = _uiState.value.copy(
                        fields = _uiState.value.fields.filter { it.id != fieldId }
                    )
                } else {
                    // Show error but don't reload
                    _uiState.value = _uiState.value.copy(
                        error = "Failed to delete field"
                    )
                }
            } catch (e: Exception) {
                _uiState.value = _uiState.value.copy(
                    error = "Error deleting field: ${e.localizedMessage}"
                )
            }
        }
    }
}
