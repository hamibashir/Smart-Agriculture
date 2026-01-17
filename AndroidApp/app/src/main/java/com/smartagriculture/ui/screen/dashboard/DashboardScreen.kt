package com.smartagriculture.ui.screen.dashboard

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.pulltorefresh.PullToRefreshContainer
import androidx.compose.material3.pulltorefresh.rememberPullToRefreshState
import com.smartagriculture.data.model.CurrentConditions
import com.smartagriculture.data.model.DashboardStats
import com.smartagriculture.ui.theme.*
import androidx.lifecycle.viewmodel.compose.viewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DashboardScreen(
    modifier: Modifier = Modifier,
    onNavigateToFields: () -> Unit = {},
    onNavigateToSensors: () -> Unit = {},
    onNavigateToAlerts: () -> Unit = {},
    onNavigateToAddField: () -> Unit = {},
    viewModel: DashboardViewModel = viewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    
    // Load data on first composition
    LaunchedEffect(Unit) {
        viewModel.loadDashboard()
    }
    
    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Column {
                        Text(
                            "Dashboard",
                            style = MaterialTheme.typography.headlineSmall,
                            fontWeight = FontWeight.Bold
                        )
                        Text(
                            "Welcome back!",
                            style = MaterialTheme.typography.bodySmall,
                            color = TextSecondary
                        )
                    }
                },
                actions = {
                    IconButton(onClick = { /* TODO: Notifications */ }) {
                        BadgedBox(
                            badge = {
                                if ((uiState.stats?.activeAlerts ?: 0) > 0) {
                                    Badge(
                                        containerColor = ErrorRed
                                    ) {
                                        Text(
                                            "${uiState.stats?.activeAlerts}",
                                            color = Color.White,
                                            fontSize = 10.sp
                                        )
                                    }
                                }
                            }
                        ) {
                            Icon(Icons.Default.Notifications, "Notifications")
                        }
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = PrimaryGreen,
                    titleContentColor = Color.White,
                    actionIconContentColor = Color.White
                )
            )
        }
    ) { padding ->
        val pullRefreshState = rememberPullToRefreshState()
        
        if (pullRefreshState.isRefreshing) {
            LaunchedEffect(true) {
                viewModel.loadDashboard()
            }
        }
        
        LaunchedEffect(uiState.isLoading) {
            if (!uiState.isLoading) {
                pullRefreshState.endRefresh()
            }
        }
        
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .nestedScroll(pullRefreshState.nestedScrollConnection)
        ) {
            LazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .background(BackgroundLight),
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                // Stats Cards Section
                item {
                    if (uiState.stats != null) {
                        StatsSection(
                            stats = uiState.stats!!,
                            onFieldsClick = onNavigateToFields,
                            onSensorsClick = onNavigateToSensors,
                            onAlertsClick = onNavigateToAlerts
                        )
                    } else if (uiState.isLoading) {
                        LoadingStatsSection()
                    }
                }
                
                // Current Conditions Section
                item {
                    if (uiState.conditions != null) {
                        CurrentConditionsSection(uiState.conditions!!)
                    }
                }
                
                // Quick Actions Section
                item {
                    QuickActionsSection(
                        onAddField = onNavigateToAddField,
                        onViewSensors = onNavigateToSensors,
                        onCheckAlerts = onNavigateToAlerts
                    )
                }
                
                // Error State
                if (uiState.error != null) {
                    item {
                        ErrorCard(
                            message = uiState.error!!,
                            onRetry = { viewModel.loadDashboard() }
                        )
                    }
                }
            }
            
            PullToRefreshContainer(
                state = pullRefreshState,
                modifier = Modifier.align(Alignment.TopCenter)
            )
        }
    }
}

@Composable
private fun StatsSection(
    stats: DashboardStats,
    onFieldsClick: () -> Unit,
    onSensorsClick: () -> Unit,
    onAlertsClick: () -> Unit
) {
    Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Text(
            "Overview",
            style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold,
            color = TextPrimary
        )
        
        LazyRow(
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            item {
                StatCard(
                    title = "Total Fields",
                    value = stats.totalFields.toString(),
                    icon = Icons.Default.Landscape,
                    color = PrimaryGreen,
                    onClick = onFieldsClick
                )
            }
            item {
                StatCard(
                    title = "Active Sensors",
                    value = stats.activeSensors.toString(),
                    icon = Icons.Default.Sensors,
                    color = InfoBlue,
                    onClick = onSensorsClick
                )
            }
            item {
                StatCard(
                    title = "Alerts",
                    value = stats.activeAlerts.toString(),
                    icon = Icons.Default.Warning,
                    color = if (stats.activeAlerts > 0) WarningOrange else SuccessGreen,
                    onClick = onAlertsClick
                )
            }
            item {
                StatCard(
                    title = "Water Saved",
                    value = "${stats.waterSaved}L",
                    icon = Icons.Default.WaterDrop,
                    color = InfoBlue,
                    onClick = {}
                )
            }
        }
    }
}

@Composable
private fun StatCard(
    title: String,
    value: String,
    icon: ImageVector,
    color: Color,
    onClick: () -> Unit
) {
    Card(
        modifier = Modifier
            .width(160.dp)
            .height(120.dp),
        shape = RoundedCornerShape(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        onClick = onClick
    ) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp)
        ) {
            // Icon background
            Box(
                modifier = Modifier
                    .size(48.dp)
                    .background(
                        color = color.copy(alpha = 0.1f),
                        shape = RoundedCornerShape(12.dp)
                    )
                    .align(Alignment.TopStart),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = icon,
                    contentDescription = title,
                    tint = color,
                    modifier = Modifier.size(24.dp)
                )
            }
            
            // Value and title
            Column(
                modifier = Modifier.align(Alignment.BottomStart),
                verticalArrangement = Arrangement.spacedBy(4.dp)
            ) {
                Text(
                    text = value,
                    style = MaterialTheme.typography.headlineMedium,
                    fontWeight = FontWeight.Bold,
                    color = TextPrimary
                )
                Text(
                    text = title,
                    style = MaterialTheme.typography.bodySmall,
                    color = TextSecondary
                )
            }
        }
    }
}

@Composable
private fun CurrentConditionsSection(conditions: CurrentConditions) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp),
        colors = CardDefaults.cardColors(
            containerColor = Color.White
        )
    ) {
        Column(
            modifier = Modifier.padding(20.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    "Current Conditions",
                    style = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold,
                    color = TextPrimary
                )
                Icon(
                    Icons.Default.Update,
                    contentDescription = "Last updated",
                    tint = TextSecondary,
                    modifier = Modifier.size(20.dp)
                )
            }
            
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                ConditionItem(
                    icon = Icons.Default.WaterDrop,
                    label = "Soil Moisture",
                    value = "${conditions.soilMoisture}%",
                    color = InfoBlue
                )
                ConditionItem(
                    icon = Icons.Default.Thermostat,
                    label = "Temperature",
                    value = "${conditions.temperature}°C",
                    color = WarningOrange
                )
                ConditionItem(
                    icon = Icons.Default.Air,
                    label = "Humidity",
                    value = "${conditions.humidity}%",
                    color = PrimaryGreen
                )
            }
        }
    }
}

@Composable
private fun ConditionItem(
    icon: ImageVector,
    label: String,
    value: String,
    color: Color
) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        Box(
            modifier = Modifier
                .size(56.dp)
                .background(
                    color = color.copy(alpha = 0.1f),
                    shape = RoundedCornerShape(12.dp)
                ),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = icon,
                contentDescription = label,
                tint = color,
                modifier = Modifier.size(28.dp)
            )
        }
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text(
                text = value,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.Bold,
                color = TextPrimary
            )
            Text(
                text = label,
                style = MaterialTheme.typography.bodySmall,
                color = TextSecondary
            )
        }
    }
}

@Composable
private fun QuickActionsSection(
    onAddField: () -> Unit,
    onViewSensors: () -> Unit,
    onCheckAlerts: () -> Unit
) {
    Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Text(
            "Quick Actions",
            style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold,
            color = TextPrimary
        )
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            QuickActionButton(
                icon = Icons.Default.Add,
                text = "Add Field",
                color = PrimaryGreen,
                onClick = onAddField,
                modifier = Modifier.weight(1f)
            )
            QuickActionButton(
                icon = Icons.Default.Sensors,
                text = "View Sensors",
                color = InfoBlue,
                onClick = onViewSensors,
                modifier = Modifier.weight(1f)
            )
        }
    }
}

@Composable
private fun QuickActionButton(
    icon: ImageVector,
    text: String,
    color: Color,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Button(
        onClick = onClick,
        modifier = modifier.height(64.dp),
        shape = RoundedCornerShape(12.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = color,
            contentColor = Color.White
        )
    ) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(icon, contentDescription = text)
            Text(text, fontWeight = FontWeight.SemiBold)
        }
    }
}

@Composable
private fun LoadingStatsSection() {
    LazyRow(
        horizontalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        items(4) {
            Card(
                modifier = Modifier
                    .width(160.dp)
                    .height(120.dp),
                shape = RoundedCornerShape(16.dp)
            ) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(
                            Brush.linearGradient(
                                colors = listOf(
                                    Color.LightGray.copy(alpha = 0.3f),
                                    Color.LightGray.copy(alpha = 0.1f),
                                    Color.LightGray.copy(alpha = 0.3f)
                                )
                            )
                        )
                )
            }
        }
    }
}

@Composable
private fun ErrorCard(
    message: String,
    onRetry: () -> Unit
) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(12.dp),
        colors = CardDefaults.cardColors(
            containerColor = ErrorRed.copy(alpha = 0.1f)
        )
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Icon(
                    Icons.Default.Error,
                    contentDescription = "Error",
                    tint = ErrorRed
                )
                Text(
                    text = message,
                    color = ErrorRed,
                    style = MaterialTheme.typography.bodyMedium
                )
            }
            Button(
                onClick = onRetry,
                colors = ButtonDefaults.buttonColors(
                    containerColor = ErrorRed
                )
            ) {
                Text("Retry")
            }
        }
    }
}
