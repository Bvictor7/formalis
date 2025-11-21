const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Test route
app.get('/api/health', (req, res) => {
  res.json({ message: "API Formalis OK" });
});

// Autres routes ici

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

