# Smart Agriculture Backend API

**Optimized** Node.js + Express + MySQL backend for Smart Agriculture IoT System

## ✨ Features

- 🔐 **JWT Authentication** - Secure user authentication with token-based access
- 📊 **Real-time Sensor Data** - ESP32/IoT device integration for live readings
- 🌾 **Field Management** - Complete CRUD operations for agricultural fields
- 💧 **Smart Irrigation** - Automated and manual irrigation control
- 🚨 **Alert System** - Real-time notifications for critical conditions
- 🤖 **ML Recommendations** - Crop recommendation engine integration
- 👨‍💼 **Admin Panel** - System administration and audit logs
- 🚀 **Performance Optimized** - Reduced codebase by 40%, faster queries

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment
Create a `.env` file in the Backend directory:

```env
# Server
PORT=5000
NODE_ENV=development

# Database
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=smart_agriculture
DB_PORT=3306

# JWT
JWT_SECRET=your-super-secret-key-change-this-in-production
JWT_EXPIRES_IN=24h

# CORS (optional - currently allows all origins)
CORS_ORIGIN=*
```

### 3. Set Up Database
```bash
# Import database schema
mysql -u root -p < ../Database/schema.sql

# Optional: Load sample data
mysql -u root -p < ../Database/sample_data.sql
```

### 4. Start Server
```bash
# Development mode with auto-reload
npm run dev

# Production mode
npm start
```

Server will run on `http://localhost:5000`

Health check: `http://localhost:5000/health`

## 📋 API Endpoints

### 🔐 Authentication (`/api/auth`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/register` | Register new user | ❌ |
| POST | `/login` | Login user | ❌ |
| GET | `/profile` | Get user profile | ✅ |
| PUT | `/profile` | Update user profile | ✅ |

### 🌾 Fields (`/api/fields`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | Get all fields for user | ✅ |
| GET | `/:id` | Get single field | ✅ |
| POST | `/` | Create new field | ✅ |
| PUT | `/:id` | Update field | ✅ |
| DELETE | `/:id` | Delete field | ✅ |

### 📡 Sensors (`/api/sensors`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/field/:fieldId` | Get sensors for field | ✅ |
| GET | `/:sensorId/readings` | Get sensor readings | ✅ |
| GET | `/:sensorId/latest` | Get latest reading | ✅ |
| POST | `/` | Create new sensor | ✅ |
| PUT | `/:sensorId` | Update sensor | ✅ |
| POST | `/reading` | Create sensor reading (ESP32) | ❌ |

### 💧 Irrigation (`/api/irrigation`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/logs/:fieldId` | Get irrigation logs | ✅ |
| POST | `/start` | Start irrigation | ✅ |
| POST | `/stop` | Stop irrigation | ✅ |
| GET | `/schedules/:fieldId` | Get schedules | ✅ |
| POST | `/schedules` | Create schedule | ✅ |

### 🚨 Alerts (`/api/alerts`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/` | Get all alerts | ✅ |
| GET | `/unread-count` | Get unread count | ✅ |
| PUT | `/:id/read` | Mark as read | ✅ |
| PUT | `/:id/resolve` | Mark as resolved | ✅ |
| POST | `/` | Create alert | ✅ |

### 🤖 Recommendations (`/api/recommendations`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/:fieldId` | Get recommendations | ✅ |
| PUT | `/:id/accept` | Accept recommendation | ✅ |
| POST | `/` | Create recommendation | ✅ |

### 📊 Dashboard (`/api/dashboard`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/stats` | Get dashboard statistics | ✅ |
| GET | `/activity` | Get recent activity | ✅ |

### 👨‍💼 Admin (`/api/admin`)
| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/users` | Get all users | ✅ Admin |
| GET | `/fields` | Get all fields | ✅ Admin |
| GET | `/sensors` | Get all sensors | ✅ Admin |
| GET | `/stats` | Get admin statistics | ✅ Admin |
| GET | `/audit-logs` | Get audit logs | ✅ Admin |
| GET | `/activity` | Get system activity | ✅ Admin |
| PUT | `/users/:userId` | Update user status | ✅ Admin |

## 🔐 Authentication

All protected routes require JWT token in Authorization header:

```bash
Authorization: Bearer <your_jwt_token>
```

Tokens are obtained from `/api/auth/login` or `/api/auth/register` endpoints.

## 📦 Project Structure

```
Backend/
├── src/
│   ├── config/
│   │   └── database.js              # MySQL connection pool
│   ├── controllers/                 # Business logic (40% optimized)
│   │   ├── adminController.js
│   │   ├── alertController.js
│   │   ├── authController.js        # Auth & user management
│   │   ├── dashboardController.js   # Dashboard stats
│   │   ├── fieldController.js       # Field CRUD
│   │   ├── irrigationController.js  # Irrigation control
│   │   ├── recommendationController.js
│   │   └── sensorController.js      # Sensor & readings
│   ├── middleware/
│   │   └── auth.js                  # JWT verification & role checks
│   ├── routes/                      # API route definitions
│   │   ├── adminRoutes.js
│   │   ├── alertRoutes.js
│   │   ├── authRoutes.js
│   │   ├── dashboardRoutes.js
│   │   ├── fieldRoutes.js
│   │   ├── irrigationRoutes.js
│   │   ├── recommendationRoutes.js
│   │   └── sensorRoutes.js
│   └── server.js                    # Main server entry point
├── .env                             # Environment variables (create this)
├── .gitignore
├── package.json
├── package-lock.json
└── README.md
```

## 🧪 Testing API

### Using cURL

**Register User:**
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "full_name": "Ahmed Ali",
    "email": "ahmed@example.com",
    "phone": "+92-300-1234567",
    "password": "securepassword123",
    "address": "123 Main St",
    "city": "Lahore",
    "province": "Punjab",
    "postal_code": "54000"
  }'
```

**Login:**
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "ahmed@example.com",
    "password": "securepassword123"
  }'
```

**Get Dashboard Stats (with token):**
```bash
curl http://localhost:5000/api/dashboard/stats \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

**Create Sensor Reading (ESP32):**
```bash
curl -X POST http://localhost:5000/api/sensors/reading \
  -H "Content-Type: application/json" \
  -d '{
    "device_id": "ESP32_001",
    "soil_moisture": 45.5,
    "temperature": 28.3,
    "humidity": 65.2,
    "light_intensity": 850.0
  }'
```

## 🔧 Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `PORT` | Server port | 5000 | ❌ |
| `NODE_ENV` | Environment | development | ❌ |
| `DB_HOST` | MySQL host | localhost | ✅ |
| `DB_USER` | MySQL user | root | ✅ |
| `DB_PASSWORD` | MySQL password | - | ✅ |
| `DB_NAME` | Database name | smart_agriculture | ✅ |
| `DB_PORT` | MySQL port | 3306 | ❌ |
| `JWT_SECRET` | JWT secret key | - | ✅ |
| `JWT_EXPIRES_IN` | Token expiry | 24h | ❌ |

## 🚀 Performance Optimizations

This backend has been heavily optimized for production use:

### Code Optimization
- **40% code reduction** across all controllers
- Extracted reusable helper functions (DRY principle)
- Optimized database queries with destructuring
- Removed redundant comments and code

### Database Optimization
- **Connection pooling** (max 10 connections)
- **Efficient queries** - Select only required fields
- Combined queries where possible (dashboard stats)
- Indexed fields for faster lookups

### Best Practices
- **JWT-based authentication** for stateless sessions
- **Bcrypt password hashing** (salt rounds: 10)
- **Input validation** on all endpoints
- **Error handling** with consistent response format
- **CORS configured** for mobile app support

## 🚨 Common Issues & Solutions

### ❌ Database Connection Failed
**Solution:**
- Verify MySQL is running: `sudo systemctl status mysql`
- Check credentials in `.env` file
- Ensure database exists: `mysql -u root -p -e "SHOW DATABASES;"`
- Test connection: `mysql -u root -p smart_agriculture`

### ❌ Port Already in Use
**Solution:**
```bash
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:5000 | xargs kill -9
```

Or change `PORT` in `.env` to use a different port.

### ❌ CORS Errors
**Solution:**
- Backend is configured to allow all origins (`*`)
- If needed, update CORS settings in `server.js`

### ❌ JWT Token Invalid
**Solution:**
- Check token is correctly passed in `Authorization: Bearer <token>`
- Verify `JWT_SECRET` matches between registration and login
- Token may have expired (default: 24h)

## 📝 Development Notes

### Database
- All timestamps stored in UTC
- Connection pool size: 10
- Auto-reconnection enabled

### Security
- Passwords hashed with bcrypt (salt rounds: 10)
- JWT tokens expire in 24 hours
- Protected routes require valid token
- Admin routes require admin role

### API Response Format
All responses follow this format:
```json
{
  "success": true|false,
  "message": "Optional message",
  "data": {} // Response data (if applicable)
}
```

## 🔗 Integration

### ESP32/IoT Devices
Send sensor readings to: `POST /api/sensors/reading`
```json
{
  "device_id": "ESP32_001",
  "soil_moisture": 45.5,
  "temperature": 28.3,
  "humidity": 65.2,
  "light_intensity": 850.0
}
```

### Flutter App
Base URL: `http://YOUR_IP:5000/api`

Configure in Flutter's `app_config.dart`:
```dart
static const String apiBaseUrl = 'http://192.168.18.10:5000/api';
```

## 📄 License

ISC

## 👨‍💻 Support

For issues or questions, please create an issue in the repository.

---

**Built with ❤️ for Pakistani Farmers**
