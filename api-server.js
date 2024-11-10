const express = require('express');
const Lunar = require('lunardb-js-sdk'); // assuming the Lunar class is saved in lunar.js
const app = express();
const port = 3000;

// Initialize LunarDB client
const lunar = new Lunar();

// Middleware to parse JSON bodies
app.use(express.json());

// Route to set a value
app.post('/set', async (req, res) => {
    const { key, value, ttl } = req.body;
    const result = await lunar.set(key, value, ttl);
    res.json({ result });
});

// Route to get a value
app.get('/get/:key', async (req, res) => {
    const { key } = req.params;
    const result = await lunar.get(key);
    res.json({ result });
});

// Route to delete a value
app.delete('/del/:key', async (req, res) => {
    const { key } = req.params;
    const result = await lunar.del(key);
    res.json({ result });
});

// Route for multi-set
app.post('/mset', async (req, res) => {
    const { pairs } = req.body; // expects array of [key, value] pairs
    const result = await lunar.mset(...pairs);
    res.json({ result });
});

// Route for multi-get
app.post('/mget', async (req, res) => {
    const { keys } = req.body; // expects array of keys
    const result = await lunar.mget(...keys);
    res.json({ result });
});

// Route to get all keys
app.get('/keys', async (req, res) => {
    const result = await lunar.keys();
    res.json({ result });
});

// Route to clear all data
app.post('/clear', async (req, res) => {
    const result = await lunar.clear();
    res.json({ result });
});

// Route to get database size
app.get('/size', async (req, res) => {
    const result = await lunar.size();
    res.json({ result });
});

// Route to perform cleanup
app.post('/cleanup', async (req, res) => {
    const result = await lunar.cleanup();
    res.json({ result });
});

// Route to save the data to a file
app.post('/save', async (req, res) => {
    const { filename } = req.body;
    const result = await lunar.save(filename);
    res.json({ result });
});

// Route to load data from a file
app.post('/load', async (req, res) => {
    const { filename } = req.body;
    const result = await lunar.load(filename);
    res.json({ result });
});

// Start server
app.listen(port, () => {
    console.log(`API server is running on http://localhost:${port}`);
});
