# Smart Agriculture Backend API

Node.js + Express + MySQL backend for Smart Agriculture IoT System

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment
```bash
cp .env.example .env
```

Edit `.env` and set your database credentials:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=smart_agriculture
JWT_SECRET=your-secret-key
```

### 3. Set Up Database
```bash
# Run the schema.sql file in MySQL
mysql -u root -p < ../../database/schema.sql

# Optional: Load sample data
mysql -u root -p < ../../database/sample_data.sql
```

### 4. Start Server
```bash
# Development mode with auto-reload
npm run dev

# Production mode
npm start
```

Server will run on `http://localhost:5000`

## 📋 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/profile` - Get user profile (protected)
- `PUT /api/auth/profile` - Update user profile (protected)

### Fields
- `GET /api/fields` - Get all fields for user
- `GET /api/fields/:id` - Get single field
- `POST /api/fields` - Create new field
- `PUT /api/fields/:id` - Update field
- `DELETE /api/fields/:id` - Delete field

### Sensors
- `GET /api/sensors/field/:fieldId` - Get sensors for field
- `GET /api/sensors/:sensorId/readings` - Get sensor readings
- `GET /api/sensors/:sensorId/latest` - Get latest reading
- `POST /api/sensors` - Create new sensor
- `POST /api/sensors/readings` - Create sensor reading (for ESP32)

### Irrigation
- `GET /api/irrigation/logs/:fieldId` - Get irrigation logs
- `POST /api/irrigation/start` - Start irrigation
- `POST /api/irrigation/stop` - Stop irrigation
- `GET /api/irrigation/schedules/:fieldId` - Get schedules
- `POST /api/irrigation/schedules` - Create schedule

### Alerts
- `GET /api/alerts` - Get all alerts
- `GET /api/alerts/unread-count` - Get unread count
- `PUT /api/alerts/:id/read` - Mark as read
- `PUT /api/alerts/:id/resolve` - Mark as resolved
- `POST /api/alerts` - Create alert

### Recommendations
- `GET /api/recommendations/:fieldId` - Get recommendations
- `PUT /api/recommendations/:id/accept` - Accept recommendation
- `POST /api/recommendations` - Create recommendation

### Dashboard
- `GET /api/dashboard/stats` - Get dashboard statistics
- `GET /api/dashboard/activity` - Get recent activity

## 🔐 Authentication

All protected routes require JWT token in Authorization header:
```
Authorization: Bearer <token>
```

## 📦 Project Structure

```
backend/
├── src/
│   ├── config/
│   │   └── database.js          # MySQL connection pool
│   ├── controllers/
│   │   ├── authController.js
│   │   ├── fieldController.js
│   │   ├── sensorController.js
│   │   ├── irrigationController.js
│   │   ├── alertController.js
│   │   ├── recommendationController.js
│   │   └── dashboardController.js
│   ├── middleware/
│   │   └── auth.js              # JWT authentication
│   ├── routes/
│   │   ├── authRoutes.js
│   │   ├── fieldRoutes.js
│   │   ├── sensorRoutes.js
│   │   ├── irrigationRoutes.js
│   │   ├── alertRoutes.js
│   │   ├── recommendationRoutes.js
│   │   └── dashboardRoutes.js
│   └── server.js                # Main server file
├── .env                         # Environment variables
├── .env.example
├── package.json
└── README.md
```

## 🧪 Testing

### Test with cURL

**Register:**
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "full_name": "Test User",
    "email": "test@example.com",
    "phone": "+92-300-1234567",
    "password": "password123"
  }'
```

**Login:**
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }'
```

**Get Fields (with token):**
```bash
curl http://localhost:5000/api/fields \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## 🔧 Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | 5000 |
| `NODE_ENV` | Environment | development |
| `DB_HOST` | MySQL host | localhost |
| `DB_USER` | MySQL user | root |
| `DB_PASSWORD` | MySQL password | - |
| `DB_NAME` | Database name | smart_agriculture |
| `DB_PORT` | MySQL port | 3306 |
| `JWT_SECRET` | JWT secret key | - |
| `JWT_EXPIRES_IN` | Token expiry | 24h |
| `CORS_ORIGIN` | CORS origin | http://localhost:3000 |

## 🚨 Common Issues

### Database Connection Failed
- Check MySQL is running
- Verify credentials in `.env`
- Ensure database exists

### Port Already in Use
- Change PORT in `.env`
- Or kill process using port 5000

### CORS Errors
- Update `CORS_ORIGIN` in `.env`
- Ensure frontend URL matches

## 📝 Notes

- All timestamps are in UTC
- Passwords are hashed with bcrypt
- JWT tokens expire in 24 hours
- Connection pool size: 10
