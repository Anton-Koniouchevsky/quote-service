import express from 'express';
import passport from 'passport';
import LocalStrategy from 'passport-local';
import BearerStrategy from 'passport-http-bearer-base64';
import cors from 'cors';
import jwt from 'jwt-simple';
import helmet from 'helmet';
import pingRouter from './routes/ping';
import quotesRouter from './routes/quotes';
import Users from './services/users';

const app = express();

const SECRET = 'my secret';

passport.use(new LocalStrategy(async (username, password, done) => {
  try {
    const user = await Users.findOne(username);
    if (!user) {
      return done(null, false, { message: 'Incorrect username.' });
    }
    if (user.password !== password) {
      return done(null, false, { message: 'Incorrect password.' });
    }

    const token = jwt.encode({ username }, SECRET);
    return done(null, token);
  } catch (err) {
    return done(err);
  }
}));

passport.use(new BearerStrategy(async (token, done) => {
  try {
    const { username } = jwt.decode(token, SECRET);
    const user = await Users.findOne(username);
    if (!user) {
      return done(null, false);
    }

    return done(null, username);
  } catch (error) {
    return done(null, false);
  }
}));

app.use(cors({
  origin: true,
}));
app.use(express.json());
app.use(express.urlencoded({
  extended: true,
}));
app.use(helmet());

app.post('/login', passport.authenticate('local', { session: false }), (req, res) => {
  res.send({
    data: {
      access_token: req.user,
    },
  });
});
app.get('/logout', (req) => {
  req.logout();
});

app.use('/ping', passport.authenticate('bearer', { session: false }), pingRouter);
app.use('/quotes', passport.authenticate('bearer', { session: false }), quotesRouter);

export default app;
