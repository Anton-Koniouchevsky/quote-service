import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import pingRouter from './routes/ping';
import quotesRouter from './routes/quotes';

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(express.static('static'));
app.use('/ping', pingRouter);
app.use('/quotes', quotesRouter);

export default app;
