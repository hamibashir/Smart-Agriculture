import pool from './src/config/database.js';

async function migrate() {
  try {
    console.log('Adding moisture_threshold column to fields table...');
    // Check if column exists first
    const [columns] = await pool.query(`SHOW COLUMNS FROM fields LIKE 'moisture_threshold'`);
    if (columns.length === 0) {
      await pool.query(`ALTER TABLE fields ADD COLUMN moisture_threshold INT DEFAULT 30 COMMENT 'Threshold for automated irrigation'`);
      console.log('Column moisture_threshold added successfully.');
    } else {
      console.log('Column moisture_threshold already exists.');
    }
  } catch (error) {
    console.error('Migration failed:', error);
  } finally {
    process.exit(0);
  }
}

migrate();
