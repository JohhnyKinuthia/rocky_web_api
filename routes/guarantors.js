import Router from 'express-promise-router'
import pool from '../models'

const router = Router();

//Get all guarantors
router.get('/', async (req, res) => {
    const { results } = pool.query(`SELECT * FROM guarantor`)
    res.status(200).json(results.rows)
})

router.get('/:id', async (req, res) => {
    try {
        const id = parseInt(req.params.id)
    }
    catch(error){
        res.status(500).end(error)
    }


    const { results } = pool.query(`SELECT * FROM guarantor WHERE id_number=$1`, [id])
    res.status(200).json(results.rows)
})

router.post('/', async (req, res) => {
    
})

router.put('/:id', async (req, res) => {
    try {
        const id = parseInt(req.params.id)
        const { name, mobile } = req.body
    }
    catch(error){
        res.status(500).end(error)
    }


    const {results} = pool.query(`UPDATE guarantor SET name=$2, mobile_number=$3 WHERE id_number=$1 `, [id, name, mobile])
    res.status(200).json(results.rows)
})

router.delete('/:id', async (req, res) => {
    
})

export default router