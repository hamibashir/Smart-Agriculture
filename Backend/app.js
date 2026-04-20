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
const NODE_ENV = process.env.NODE_ENV || 'development';

// Development:
//   CORS_ORIGIN=*  (easy local testing)
// Production:
//   CORS_ORIGIN=https://yourdomain.com,https://www.yourdomain.com
const ALLOWED_ORIGINS = (process.env.CORS_ORIGIN || '*')
  .split(',')
  .map((origin) => origin.trim())
  .filter(Boolean);

const corsOriginValidator = (origin, callback) => {
  // Development (current): allow requests with no Origin header (mobile tools/postman/device calls).
  if (!origin) return callback(null, true);

  // Development quick mode: allow all.
  if (ALLOWED_ORIGINS.includes('*')) return callback(null, true);

  // Production mode: allow only listed domains.
  if (ALLOWED_ORIGINS.includes(origin)) return callback(null, true);

  return callback(new Error('Not allowed by CORS'));
};

// Middleware
app.use(cors({
  // Development (current): set CORS_ORIGIN=* in .env
  // Production: set CORS_ORIGIN to your real app domains
  origin: corsOriginValidator,
  credentials: true,
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
    environment: NODE_ENV,
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
      admin: '/api/admin',
    },
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
    message: 'Route not found',
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);

  // Development: show real message.
  // Production: hide internal details from clients.
  const safeMessage = NODE_ENV === 'production' ? 'Internal server error' : (err.message || 'Internal server error');

  res.status(err.status || 500).json({
    success: false,
    message: safeMessage,
  });
});

// Start server function
const startServer = async () => {
  try {
    // Production safety check:
    // Development: permissive for local work.
    // Production: do not start without a strong JWT secret.
    if (NODE_ENV === 'production') {
      const secret = process.env.JWT_SECRET || '';
      if (!secret || secret.length < 24 || secret === 'dev_change_me_before_production') {
        throw new Error('JWT_SECRET is missing/weak. Set a strong production secret in environment variables.');
      }
    }

    // Test database connection
    const dbConnected = await testConnection();

    if (!dbConnected) {
      console.error('Failed to connect to database. Please check your configuration.');
      // In development, fail fast.
      // In production, keep process alive so cPanel can restart while you fix DB.
      if (NODE_ENV === 'development') {
        process.exit(1);
      }
    }

    app.listen(PORT, '0.0.0.0', () => {
      console.log('');
      console.log('========================================');
      console.log(' Smart Agriculture API Server');
      console.log('========================================');
      console.log(`Server listening on 0.0.0.0:${PORT}`);
      console.log(`Environment: ${NODE_ENV}`);
      console.log(`Database: ${dbConnected ? 'Connected' : 'Not Connected'}`);
      console.log('========================================');
      console.log('');
    });
  } catch (error) {
    console.error('Failed to start server:', error);
    // In development, fail fast.
    // In production, keep process alive for cPanel supervision.
    if (NODE_ENV === 'development') {
      process.exit(1);
    }
  }
};

// Start the server
startServer();

// Export app for testing or external use
module.exports = app;
