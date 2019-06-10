import 'dotenv/config';
import cors from 'cors';
import express from 'express';
import routes from './routes'

const port = 3000;
const app = express();

app.use(cors);

app.get('/', (req, res) => {
	res.send('Hello, World!');
});

app.use('/loans', routes.loans);
app.use('/riders', routes.riders); 
app.use('/guarantors', routes.guarantors);
app.use('/defaulters', routes.defaulters);
app.use('/repayments', routes.repayments);
app.listen(port, () => {
	console.log('App listening on port ${port}');
});
console.log('Hello Node.js project.');
