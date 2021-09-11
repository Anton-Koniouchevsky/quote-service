const users = [
  {
    userId: 1,
    username: 'Anton',
    password: 'testpass',
  },
  {
    userId: 2,
    username: 'admin',
    password: 'adminPass',
  },
];

async function findOne(username) {
  return users.find((user) => user.username === username);
}

export default {
  findOne,
};
