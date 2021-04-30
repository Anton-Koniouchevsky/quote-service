import { Router } from 'express';
import quotes from '../services/quote-service';

const router = new Router();

router.get('/', (_, res) => {
  res.json({
    data: quotes.getAllQuotes(),
  });
});

router.get('/random', (req, res) => {
  try {
    let quote;
    const { tag } = req.query;
    if (tag) {
      quote = quotes.getRandomQuoteByTag(tag);
    } else {
      quote = quotes.getRandomQuote();
    }

    res.json({
      data: quote,
    });
  } catch (err) {
    res.status(404).send(err.message);
  }
});

router.post('/', (req, res) => {
  try {
    quotes.addQuote(req.body?.quote);

    res.end();
  } catch (err) {
    res.status(404).send(err.message);
  }
});

router.get('/:id', (req, res) => {
  try {
    const quote = quotes.getQuote(req.params.id);
    res.json({
      data: quote,
    });
  } catch (err) {
    res.status(404).send(err.message);
  }
});

router.put('/:id', (req, res) => {
  try {
    quotes.updateQuote(req.params.id, req.body);
    res.send();
  } catch (err) {
    res.status(404).send(err.message);
  }
});

router.delete('/:id', (req, res) => {
  try {
    quotes.deleteQuote(req.params.id, req.body);
    res.end();
  } catch (err) {
    res.status(404).send(err.message);
  }
});

export default router;
