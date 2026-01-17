package com.smartagriculture.ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.smartagriculture.ui.screen.auth.LoginScreen
import com.smartagriculture.ui.screen.auth.RegisterScreen
import com.smartagriculture.ui.screen.home.HomeScreen
import com.smartagriculture.ui.screen.fields.AddFieldScreen

sealed class Screen(val route: String) {
    object Login : Screen("login")
    object Register : Screen("register")
    object Home : Screen("home")
    object Dashboard : Screen("dashboard")
    object AddField : Screen("add_field")
    // Add more screens as we build them
}

@Composable
fun AppNavigation() {
    val navController = rememberNavController()
    
    NavHost(
        navController = navController,
        startDestination = Screen.Login.route
    ) {
        composable(Screen.Login.route) {
            LoginScreen(
                onLoginSuccess = {
                    navController.navigate(Screen.Home.route) {
                        popUpTo(Screen.Login.route) { inclusive = true }
                    }
                },
                onNavigateToRegister = {
                    navController.navigate(Screen.Register.route)
                }
            )
        }
        
        composable(Screen.Register.route) {
            RegisterScreen(
                onNavigateToLogin = {
                    navController.popBackStack()
                },
                onRegisterSuccess = {
                    navController.navigate(Screen.Home.route) {
                        popUpTo(Screen.Login.route) { inclusive = true }
                    }
                }
            )
        }
        
        composable(Screen.Home.route) {
            HomeScreen(
                onNavigateToAddField = {
                    navController.navigate(Screen.AddField.route)
                },
                onLogout = {
                    navController.navigate(Screen.Login.route) {
                        popUpTo(0) { inclusive = true }
                    }
                }
            )
        }
        
        composable(Screen.AddField.route) {
            AddFieldScreen(
                onNavigateBack = {
                    navController.popBackStack()
                },
                onFieldAdded = {
                    navController.popBackStack()
                }
            )
        }
        
        // Other screens will be added next
    }
}
