// cPanel-compatible entry point for Smart Agriculture Backend
// This file uses CommonJS for maximum compatibility with shared hosting

require('dotenv').config();
const express = require('express');
const cors = require('cors');

// Import database test function
const { testConnection } = require('./src/config/database.cjs');

// Import routes
const authRoutes = require('./src/routes/authRoutes.cjs');
const fieldRoutes = require('./src/routes/fieldRoutes.cjs');
const sensorRoutes = require('./src/routes/sensorRoutes.cjs');
const irrigationRoutes = require('./src/routes/irrigationRoutes.cjs');
const alertRoutes = require('./src/routes/alertRoutes.cjs');
const recommendationRoutes = require('./src/routes/recommendationRoutes.cjs');
const dashboardRoutes = require('./src/routes/dashboardRoutes.cjs');
const adminRoutes = require('./src/routes/adminRoutes.cjs');

const app = express();

// Port configuration for cPanel (uses environment variable or default)
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors({
  origin: '*', // Allow all origins for mobile app support
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Request logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Smart Agriculture API is running',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'production'
  });
});

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    success: true,
    message: 'Smart Agriculture API',
    version: '1.0.0',
    endpoints: {
      health: '/health',
      auth: '/api/auth',
      fields: '/api/fields',
      sensors: '/api/sensors',
      irrigation: '/api/irrigation',
      alerts: '/api/alerts',
      recommendations: '/api/recommendations',
      dashboard: '/api/dashboard',
      admin: '/api/admin'
    }
  });
});

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/fields', fieldRoutes);
app.use('/api/sensors', sensorRoutes);
app.use('/api/irrigation', irrigationRoutes);
app.use('/api/alerts', alertRoutes);
app.use('/api/recommendations', recommendationRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/admin', adminRoutes);

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Route not found'
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Internal server error'
  });
});

// Start server function
const startServer = async () => {
  try {
    // Test database connection
    const dbConnected = await testConnection();
    
    if (!dbConnected) {
      console.error('❌ Failed to connect to database. Please check your configuration.');
      // In production, we'll still start the server but log the error
      if (process.env.NODE_ENV === 'development') {
        process.exit(1);
      }
    }

    app.listen(PORT, () => {
      console.log('');
      console.log('🌾 ========================================');
      console.log('🌾  Smart Agriculture API Server');
      console.log('🌾 ========================================');
      console.log(`🚀 Server running on port ${PORT}`);
      console.log(`🔒 Environment: ${process.env.NODE_ENV || 'production'}`);
      console.log(`✅ Database: ${dbConnected ? 'Connected' : 'Not Connected'}`);
      console.log('🌾 ========================================');
      console.log('');
    });
  } catch (error) {
    console.error('Failed to start server:', error);
    // In production, log but don't exit
    if (process.env.NODE_ENV === 'development') {
      process.exit(1);
    }
  }
};

// Start the server
startServer();

// Export app for testing or external use
module.exports = app;
