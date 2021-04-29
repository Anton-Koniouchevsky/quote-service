import { Router } from 'express';

const router = new Router();

router.get('', (_, res) => {
  res.json({
    statusCode: 200,
    message: 'OK',
    time: Date.now(),
  });
});

export default router;
