import { Pool } from 'pg'

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: 5432,
})

pool.query('SELECT NOW()', (err, res) => {
    console.log(err, res)
})

module.exports = {
    query: (text, params) => pool.query(text, params)
}