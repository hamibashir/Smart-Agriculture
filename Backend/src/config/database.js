import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

// Development vs Production:
// Development: keep DB_CONNECTION_LIMIT=10 for local testing.
// Production (cPanel): set DB_CONNECTION_LIMIT=5 (or lower) to avoid exhausting shared resources.
const DB_CONNECTION_LIMIT = Number(
  process.env.DB_CONNECTION_LIMIT || (process.env.NODE_ENV === 'production' ? 5 : 10)
);

// Create connection pool
const pool = mysql.createPool({
  // Development: DB_HOST=localhost, DB_USER=root
  // Production: DB_HOST/DB_USER/DB_NAME must be cPanel values from environment variables.
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'smart_agriculture',
  port: process.env.DB_PORT || 3306,
  waitForConnections: true,
  connectionLimit: DB_CONNECTION_LIMIT,
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0
});

// Test database connection
export const testConnection = async () => {
  try {
    const connection = await pool.getConnection();
    console.log('✅ Database connected successfully');
    connection.release();
    return true;
  } catch (error) {
    console.error('❌ Database connection failed:', error.message);
    return false;
  }
};

export default pool;
