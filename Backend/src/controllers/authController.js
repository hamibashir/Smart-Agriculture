import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import pool from '../config/database.js';

const generateToken = (user) => jwt.sign(
  { user_id: user.user_id, email: user.email, role: user.role },
  process.env.JWT_SECRET,
  { expiresIn: process.env.JWT_EXPIRES_IN || '24h' }
);

// Register new user
export const register = async (req, res) => {
  try {
    const { full_name, email, phone, password, address, city, province, postal_code } = req.body;

    if (!full_name || !email || !phone || !password) {
      return res.status(400).json({ success: false, message: 'Please provide all required fields' });
    }

    const [existing] = await pool.query('SELECT user_id FROM users WHERE email = ? OR phone = ?', [email, phone]);
    if (existing.length > 0) {
      return res.status(400).json({ success: false, message: 'User with this email or phone already exists' });
    }

    const password_hash = await bcrypt.hash(password, 10);
    const [result] = await pool.query(
      `INSERT INTO users (full_name, email, phone, password_hash, address, city, province, postal_code, role) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'farmer')`,
      [full_name, email, phone, password_hash, address, city, province, postal_code]
    );

    const [[user]] = await pool.query(
      'SELECT user_id, full_name, email, phone, address, city, province, role, is_active, created_at FROM users WHERE user_id = ?',
      [result.insertId]
    );

    res.status(201).json({ success: true, message: 'User registered successfully', token: generateToken(user), user });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ success: false, message: 'Server error during registration' });
  }
};

// Login user
export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ success: false, message: 'Please provide email and password' });
    }

    const [[user]] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
    if (!user) {
      return res.status(401).json({ success: false, message: 'Invalid email or password' });
    }

    if (!user.is_active) {
      return res.status(403).json({ success: false, message: 'Account is deactivated. Please contact support.' });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password_hash);
    if (!isPasswordValid) {
      return res.status(401).json({ success: false, message: 'Invalid email or password' });
    }

    await pool.query('UPDATE users SET last_login = NOW() WHERE user_id = ?', [user.user_id]);
    delete user.password_hash;

    res.json({ success: true, message: 'Login successful', token: generateToken(user), user });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ success: false, message: 'Server error during login' });
  }
};

// Get current user profile
export const getProfile = async (req, res) => {
  try {
    const [[user]] = await pool.query(
      'SELECT user_id, full_name, email, phone, address, city, province, postal_code, role, is_active, email_verified, phone_verified, created_at, last_login FROM users WHERE user_id = ?',
      [req.user.user_id]
    );

    if (!user) return res.status(404).json({ success: false, message: 'User not found' });
    res.json({ success: true, data: user });
  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Update user profile
export const updateProfile = async (req, res) => {
  try {
    const { full_name, phone, address, city, province, postal_code } = req.body;

    await pool.query(
      `UPDATE users SET full_name = ?, phone = ?, address = ?, city = ?, province = ?, postal_code = ?, updated_at = NOW() WHERE user_id = ?`,
      [full_name, phone, address, city, province, postal_code, req.user.user_id]
    );

    const [[user]] = await pool.query(
      'SELECT user_id, full_name, email, phone, address, city, province, postal_code, role, is_active, created_at FROM users WHERE user_id = ?',
      [req.user.user_id]
    );

    res.json({ success: true, message: 'Profile updated successfully', data: user });
  } catch (error) {
    console.error('Update profile error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};
