import Router from 'express-promise-router'
import pool from '../models'

const router = Router();

router.get('/', (req, res) => {
    const { results } = pool.query(`
        SELECT id_number, surname, other_name, mobile_number, loan_amount, loan_status, status_note 
        FROM applicant NATURAL JOIN loan`)
    res.status(200).json(results.rows)
})

router.get('/:id', async (req, res) => {
    try {
        const id = parseInt(req.params.id)
    }
    catch(error){
        res.status(500).end(error)
    }

    const {results} = pool.query(`
        SELECT id_number, surname, other_name, mobile_number, loan_amount, loan_status, status_note 
        FROM applicant NATURAL JOIN loan WHERE id_number=$1`, [id])
    res.status(200).json(results.rows)
})

router.get('/:id/riders', async (req, res) => {
    try {
        const id = parseInt(req.params.id)
    }
    catch(error){
        res.status(500).end(error)
    }

    const { results } = pool.query(
        `SELECT applicant.id_number, surname, other_name, applicant.mobile_number, guarantor_id, name, guarantor.mobile_number 
        FROM applicant, guaranteed_loans, guarantor 
        WHERE id_number=$1 AND applicant.id_number=guaranteed_loans.applicant_id 
        AND guaranteed_loans.guarantor_id=guarantor.id_number`, [id])
    res.status(200).json(results.rows)
        
    }
)

//Create a new Riders details
//Such an ambitious undertaking
router.post('/', async  (req, res) => {
    
})

router.put('/:id', async (req, res) => {
    
})

//Do we really need this?
router.delete('/:id', async (req, res) => {
    
})

export default router