import * as yup from 'yup';

const schema = yup.object().shape({
  author: yup.string().required(),
  text: yup.string().required(),
  id: yup.string().uuid().required(),
  source: yup.string(),
  tags: yup.string(),
  createdBy: yup.string(),
  createdAt: yup.string(),
  updatedAt: yup.string(),
  isDeleted: yup.boolean(),
});

export default schema;
