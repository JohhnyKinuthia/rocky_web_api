import Router from 'express-promise-router'
import pool from '../models'

const router = Router();

router.get('/', async (req, res) => {
    const { results } = pool.query(`SELECT loan_id, loan_amount, purpose, interest_rate, issue_date, loan_status, status_note, id_number 
    FROM loan`)
    res.status(200).json(results.rows)
})

router.get('/:id', async (req, res) => {
    try {
        const id = parseInt(req.params.id)
    }
    catch(error){
        res.status(500).end(error)
    }


    const { results } = pool.query(`
        SELECT loan_id, loan_amount, purpose, interest_rate, issue_date, loan_status, status_note, id_number 
        FROM loan WHERE loan_id=$1;`, [id])
    res.status(200).json(results.rows)
})

router.post('/', async (req, res) => {
    
})

router.put('/:id', async (req, res) => {
    
})

router.delete('/:id', async (req, res) => {
    
})

export default router