import express from 'express';
import cors from 'cors';
import pingRouter from './routes/ping';
import quotesRouter from './routes/quotes';

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({
  extended: true,
}));
app.use('/ping', pingRouter);
app.use('/quotes', quotesRouter);

export default app;
