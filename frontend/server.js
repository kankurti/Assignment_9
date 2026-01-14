const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios");

const app = express();
const PORT = 3000;

const BACKEND_URL = process.env.BACKEND_URL || "http://localhost:5000";

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
    res.render("index");
});

app.post("/submit", async (req, res) => {
    try {
        const response = await axios.post(
            `${BACKEND_URL}/submit`,
            req.body
        );
        res.send(response.data);
    } catch {
        res.send("Backend not reachable");
    }
});

app.listen(PORT, () => {
    console.log(`Frontend running on port ${PORT}`);
});
