const express = require('express');
const path = require('path');

const app = express();

app.use(express.static(path.join(__dirname, 'public')));

app.get('/health', (req, res) => {
  res.json({
    status: 'UP'
  });
});

app.listen(3000, () => {
  console.log('Application running on port 3000');
});
