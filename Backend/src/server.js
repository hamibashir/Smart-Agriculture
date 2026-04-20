import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { testConnection } from './config/database.js';

// Import routes
import authRoutes from './routes/authRoutes.js';
import fieldRoutes from './routes/fieldRoutes.js';
import sensorRoutes from './routes/sensorRoutes.js';
import irrigationRoutes from './routes/irrigationRoutes.js';
import alertRoutes from './routes/alertRoutes.js';
import recommendationRoutes from './routes/recommendationRoutes.js';
import dashboardRoutes from './routes/dashboardRoutes.js';
import adminRoutes from './routes/adminRoutes.js';
import chatRoutes from './routes/chatRoutes.js';

// Load environment variables
dotenv.config();

const app = express();
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

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/fields', fieldRoutes);
app.use('/api/sensors', sensorRoutes);
app.use('/api/irrigation', irrigationRoutes);
app.use('/api/alerts', alertRoutes);
app.use('/api/recommendations', recommendationRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/chat', chatRoutes);

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

// Start server
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
      process.exit(1);
    }

    app.listen(PORT, () => {
      console.log('');
      console.log('========================================');
      console.log(' Smart Agriculture API Server');
      console.log('========================================');
      console.log(`Server running on port ${PORT}`);

      // Development (current): localhost logs for local testing.
      console.log(`API URL (development): http://localhost:${PORT}`);
      console.log(`Health (development): http://localhost:${PORT}/health`);

      // Production: APP_URL should be set to your public API URL.
      if (process.env.APP_URL) {
        console.log(`API URL (production): ${process.env.APP_URL}`);
        console.log(`Health (production): ${process.env.APP_URL}/health`);
      }

      console.log(`Environment: ${NODE_ENV}`);
      console.log('========================================');
      console.log('');
    });
  } catch (error) {
    console.error('Failed to start server:', error);
    process.exit(1);
  }
};

startServer();
