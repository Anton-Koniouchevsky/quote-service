import { v4 as uuidv4 } from 'uuid';
import quotes from '../data/quotes.json';
import quoteSchema from '../data/quote-schema';

function getAllQuotes() {
  return quotes;
}

function getRandomQuote(quoteList = quotes) {
  return quoteList[Math.floor(Math.random() * quoteList.length)];
}

function getRandomQuoteByTag(tag) {
  const filteredQuotes = quotes
    .filter((q) => q.text.includes(tag) || (q.tags && q.tags.includes(tag)));

  if (!filteredQuotes) {
    throw new Error('No quotes found');
  }

  return getRandomQuote(filteredQuotes);
}

function validate(quote) {
  if (!quote) {
    throw new Error('Quote is not passed');
  }

  if (!quoteSchema.isValidSync(quote)) {
    throw new Error('Quote is not valid');
  }
}

function findIndexById(id) {
  const index = quotes.findIndex((q) => q.id === id);
  if (index < 0) {
    throw new Error('Quote is not found');
  }

  return index;
}

function getQuote(id) {
  const index = findIndexById(id);
  return quotes[index];
}

function addQuote(quote) {
  const newQuote = {
    id: uuidv4(),
    ...quote,
  };

  validate(newQuote);
  quotes.push(newQuote);
}

function updateQuote(id, quote) {
  const index = findIndexById(id);
  validate(quote);

  quotes[index] = quote;
}

function deleteQuote(id) {
  const index = findIndexById(id);
  quotes.splice(index, 1);
}

export default {
  getAllQuotes,
  getRandomQuote,
  getRandomQuoteByTag,
  getQuote,
  addQuote,
  updateQuote,
  deleteQuote,
};
