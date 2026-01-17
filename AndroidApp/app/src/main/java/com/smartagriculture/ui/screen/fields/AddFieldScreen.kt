package com.smartagriculture.ui.screen.fields

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.smartagriculture.ui.theme.*

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AddFieldScreen(
    modifier: Modifier = Modifier,
    onNavigateBack: () -> Unit = {},
    onFieldAdded: () -> Unit = {},
    viewModel: AddFieldViewModel = viewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    
    // Handle success navigation
    LaunchedEffect(uiState.isSuccess) {
        if (uiState.isSuccess) {
            onFieldAdded()
        }
    }
    
    Scaffold(
        modifier = modifier,
        topBar = {
            TopAppBar(
                title = {
                    Text(
                        "Add New Field",
                        fontWeight = FontWeight.Bold
                    )
                },
                navigationIcon = {
                    IconButton(onClick = onNavigateBack) {
                        Icon(Icons.Default.ArrowBack, "Back")
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = PrimaryGreen,
                    titleContentColor = Color.White,
                    navigationIconContentColor = Color.White
                )
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .background(BackgroundLight)
                .verticalScroll(rememberScrollState())
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            // Header Card
            HeaderCard()
            
            // Field Name
            OutlinedTextField(
                value = uiState.name,
                onValueChange = viewModel::updateName,
                label = { Text("Field Name") },
                leadingIcon = {
                    Icon(Icons.Default.Landscape, contentDescription = null)
                },
                modifier = Modifier.fillMaxWidth(),
                singleLine = true,
                isError = uiState.nameError != null,
                supportingText = uiState.nameError?.let { { Text(it) } },
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = PrimaryGreen,
                    focusedLabelColor = PrimaryGreen
                )
            )
            
            // Location
            OutlinedTextField(
                value = uiState.location,
                onValueChange = viewModel::updateLocation,
                label = { Text("Location") },
                leadingIcon = {
                    Icon(Icons.Default.LocationOn, contentDescription = null)
                },
                placeholder = { Text("e.g., GPS: 31.5204, 74.3587") },
                modifier = Modifier.fillMaxWidth(),
                singleLine = true,
                isError = uiState.locationError != null,
                supportingText = uiState.locationError?.let { { Text(it) } },
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = PrimaryGreen,
                    focusedLabelColor = PrimaryGreen
                )
            )
            
            // Area
            OutlinedTextField(
                value = uiState.area,
                onValueChange = viewModel::updateArea,
                label = { Text("Area (acres)") },
                leadingIcon = {
                    Icon(Icons.Default.Straighten, contentDescription = null)
                },
                modifier = Modifier.fillMaxWidth(),
                singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
                isError = uiState.areaError != null,
                supportingText = uiState.areaError?.let { { Text(it) } },
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = PrimaryGreen,
                    focusedLabelColor = PrimaryGreen
                )
            )
            
            // Crop Type Dropdown
            var cropExpanded by remember { mutableStateOf(false) }
            ExposedDropdownMenuBox(
                expanded = cropExpanded,
                onExpandedChange = { cropExpanded = it }
            ) {
                OutlinedTextField(
                    value = uiState.cropType,
                    onValueChange = {},
                    readOnly = true,
                    label = { Text("Crop Type") },
                    leadingIcon = {
                        Icon(Icons.Default.Grass, contentDescription = null)
                    },
                    trailingIcon = {
                        ExposedDropdownMenuDefaults.TrailingIcon(expanded = cropExpanded)
                    },
                    modifier = Modifier
                        .fillMaxWidth()
                        .menuAnchor(),
                    isError = uiState.cropTypeError != null,
                    supportingText = uiState.cropTypeError?.let { { Text(it) } },
                    colors = OutlinedTextFieldDefaults.colors(
                        focusedBorderColor = PrimaryGreen,
                        focusedLabelColor = PrimaryGreen
                    )
                )
                ExposedDropdownMenu(
                    expanded = cropExpanded,
                    onDismissRequest = { cropExpanded = false }
                ) {
                    listOf("Wheat", "Rice", "Corn", "Cotton", "Sugarcane", "Vegetables", "Fruits", "Other").forEach { crop ->
                        DropdownMenuItem(
                            text = { Text(crop) },
                            onClick = {
                                viewModel.updateCropType(crop)
                                cropExpanded = false
                            }
                        )
                    }
                }
            }
            
            // Soil Type Dropdown (Optional)
            var soilExpanded by remember { mutableStateOf(false) }
            ExposedDropdownMenuBox(
                expanded = soilExpanded,
                onExpandedChange = { soilExpanded = it }
            ) {
                OutlinedTextField(
                    value = uiState.soilType,
                    onValueChange = {},
                    readOnly = true,
                    label = { Text("Soil Type (Optional)") },
                    leadingIcon = {
                        Icon(Icons.Default.Terrain, contentDescription = null)
                    },
                    trailingIcon = {
                        ExposedDropdownMenuDefaults.TrailingIcon(expanded = soilExpanded)
                    },
                    modifier = Modifier
                        .fillMaxWidth()
                        .menuAnchor(),
                    colors = OutlinedTextFieldDefaults.colors(
                        focusedBorderColor = PrimaryGreen,
                        focusedLabelColor = PrimaryGreen
                    )
                )
                ExposedDropdownMenu(
                    expanded = soilExpanded,
                    onDismissRequest = { soilExpanded = false }
                ) {
                    listOf("None", "Loamy", "Sandy", "Clay", "Silty", "Peaty", "Chalky", "Saline").forEach { soil ->
                        DropdownMenuItem(
                            text = { Text(soil) },
                            onClick = {
                                viewModel.updateSoilType(if (soil == "None") "" else soil)
                                soilExpanded = false
                            }
                        )
                    }
                }
            }
            
            // Error Message
            if (uiState.error != null) {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    colors = CardDefaults.cardColors(
                        containerColor = ErrorRed.copy(alpha = 0.1f)
                    )
                ) {
                    Row(
                        modifier = Modifier.padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        Icon(
                            Icons.Default.Error,
                            contentDescription = null,
                            tint = ErrorRed
                        )
                        Text(
                            text = uiState.error!!,
                            color = ErrorRed,
                            style = MaterialTheme.typography.bodyMedium
                        )
                    }
                }
            }
            
            Spacer(modifier = Modifier.height(8.dp))
            
            // Submit Button
            Button(
                onClick = viewModel::createField,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(56.dp),
                enabled = !uiState.isLoading,
                shape = RoundedCornerShape(12.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = PrimaryGreen
                )
            ) {
                if (uiState.isLoading) {
                    CircularProgressIndicator(
                        modifier = Modifier.size(24.dp),
                        color = Color.White
                    )
                } else {
                    Icon(Icons.Default.Add, contentDescription = null)
                    Spacer(modifier = Modifier.width(8.dp))
                    Text(
                        "Add Field",
                        fontSize = MaterialTheme.typography.titleMedium.fontSize,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
    }
}

@Composable
private fun HeaderCard() {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(12.dp),
        colors = CardDefaults.cardColors(
            containerColor = PrimaryGreen.copy(alpha = 0.1f)
        )
    ) {
        Row(
            modifier = Modifier.padding(16.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Icon(
                Icons.Default.Info,
                contentDescription = null,
                tint = PrimaryGreen,
                modifier = Modifier.size(24.dp)
            )
            Column {
                Text(
                    "Add Your Field",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    color = PrimaryGreen
                )
                Text(
                    "Fill in the details to register a new agricultural field",
                    style = MaterialTheme.typography.bodySmall,
                    color = TextSecondary
                )
            }
        }
    }
}
