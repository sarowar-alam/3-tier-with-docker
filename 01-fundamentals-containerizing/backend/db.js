const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL || 'postgresql://bmi_user:password@localhost:5432/bmidb',
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000,
});

// Connection retry logic for Docker environments
async function connectWithRetry(maxRetries = 5, delayMs = 2000) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      const client = await pool.connect();
      const result = await client.query('SELECT NOW()');
      client.release();
      console.log('✅ Database connected successfully at', result.rows[0].now);
      return true;
    } catch (err) {
      console.log(`⏳ Database connection attempt ${attempt}/${maxRetries} failed:`, err.message);
      
      if (attempt === maxRetries) {
        console.error('❌ Failed to connect to database after', maxRetries, 'attempts');
        throw err;
      }
      
      console.log(`   Retrying in ${delayMs / 1000} seconds...`);
      await new Promise(resolve => setTimeout(resolve, delayMs));
    }
  }
}

// Test connection on startup
connectWithRetry()
  .catch(err => {
    console.error('Failed to establish database connection:', err);
    process.exit(1);
  });

// Handle pool errors
pool.on('error', (err, client) => {
  console.error('Unexpected error on idle client', err);
});

module.exports = pool;
