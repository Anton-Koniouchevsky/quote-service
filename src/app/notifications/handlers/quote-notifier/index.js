const { SES, SNS } = require('aws-sdk');

const sendEmail = async ({ email, quote }) => {
  console.log('quote-service', 'sendEmail', email, quote);

  const sesClient = new SES({ region: 'eu-west-1' });

  const emailParams = {
    Destination: {
      ToAddresses: [email],
    },
    Message: {
      Body: {
        Html: {
          Charset: 'UTF-8',
          Data: `<p>${quote.text}</p><h1>${quote.author}<h1>`,
        },
      },
      Subject: {
        Charset: 'UTF-8',
        Data: 'Daily Quote',
      },
    },
    Source: 'anton.koniouchevsky@gmail.com',
  };

  console.log('quote-service', 'sendEmail', emailParams);

  return sesClient.sendEmail(emailParams).promise();
};

const sendSMS = async ({ phone, quote }) => {
  console.log('quote-service', 'sendSMS', phone, quote);

  const snsClient = new SNS({
    region: 'eu-west-1',
    apiVersion: '2010-03-31',
  });

  return snsClient.publish({
    Message: `${quote.text}. ${quote.author}`,
    PhoneNumber: phone,
  }).promise();
};

exports.handler = async (event) => {
  let statusCode = 200;
  const response = {};
  console.log('quote-service', event);

  try {
    const body = JSON.parse(event.body);

    if (!body || !body.quote) {
      throw new Error('no quote provided');
    }

    if (body.email) {
      response.status = await sendEmail(body);
    } else if (body.phone) {
      response.status = await sendSMS(body);
    } else {
      throw new Error('unknown notification method');
    }
  } catch (err) {
    statusCode = 404;
    response.error = err.message;
    console.log('quote-service', err);
  } finally {
    // eslint-disable-next-line no-unsafe-finally
    return {
      statusCode,
      body: JSON.stringify(response),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': true,
        'Access-Control-Allow-Methods': 'OPTIONS,POST,GET',
        'Access-Control-Allow-Headers': 'Content-Type',
      },
    };
  }
};
