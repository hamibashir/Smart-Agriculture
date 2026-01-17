package com.smartagriculture.ui.screen.home

import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp
import com.smartagriculture.ui.screen.dashboard.DashboardScreen
import com.smartagriculture.ui.screen.fields.FieldsScreen
import com.smartagriculture.ui.theme.PrimaryGreen

sealed class BottomNavItem(
    val route: String,
    val icon: ImageVector,
    val label: String
) {
    object Dashboard : BottomNavItem("dashboard", Icons.Default.Dashboard, "Dashboard")
    object Fields : BottomNavItem("fields", Icons.Default.Landscape, "Fields")
    object Alerts : BottomNavItem("alerts", Icons.Default.Notifications, "Alerts")
    object Profile : BottomNavItem("profile", Icons.Default.Person, "Profile")
}

@Composable
fun HomeScreen() {
    var selectedTab by remember { mutableStateOf(0) }
    
    val items = listOf(
        BottomNavItem.Dashboard,
        BottomNavItem.Fields,
        BottomNavItem.Alerts,
        BottomNavItem.Profile
    )
    
    Scaffold(
        bottomBar = {
            NavigationBar(
                containerColor = MaterialTheme.colorScheme.surface,
                contentColor = PrimaryGreen
            ) {
                items.forEachIndexed { index, item ->
                    NavigationBarItem(
                        icon = {
                            Icon(item.icon, contentDescription = item.label)
                        },
                        label = { Text(item.label) },
                        selected = selectedTab == index,
                        onClick = { selectedTab = index },
                        colors = NavigationBarItemDefaults.colors(
                            selectedIconColor = PrimaryGreen,
                            selectedTextColor = PrimaryGreen,
                            indicatorColor = PrimaryGreen.copy(alpha = 0.1f)
                        )
                    )
                }
            }
        }
    ) { padding ->
        when (selectedTab) {
            0 -> DashboardScreen(
                modifier = Modifier.padding(padding),
                onNavigateToFields = { selectedTab = 1 },
                onNavigateToSensors = { /* TODO */ },
                onNavigateToAlerts = { selectedTab = 2 }
            )
            1 -> FieldsScreen(
                modifier = Modifier.padding(padding),
                onNavigateToFieldDetail = { fieldId ->
                    // TODO: Navigate to field detail
                },
                onNavigateToAddField = {
                    // TODO: Navigate to add field
                }
            )
            2 -> PlaceholderScreen("Alerts", Modifier.padding(padding))
            3 -> PlaceholderScreen("Profile", Modifier.padding(padding))
        }
    }
}

@Composable
private fun PlaceholderScreen(title: String, modifier: Modifier = Modifier) {
    Surface(modifier = modifier) {
        Box(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "$title Screen - Coming Soon!",
                style = MaterialTheme.typography.headlineSmall
            )
        }
    }
}
