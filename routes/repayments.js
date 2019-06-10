import Router from 'express-promise-router'
import pool from '../models'

const router = Router();
//Return all loan repayments ordered in descending order
router.get('/', async (req, res) => {
    const {results} = pool.query('SELECT * FROM loan_repayment ORDER BY paid_amount DESC')
    res.status(200).json(results.rows)
})

router.get('/:id', async (req, res) => {

})

export default router