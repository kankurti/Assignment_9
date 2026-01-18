#!/bin/bash
yum update -y

curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

mkdir -p /home/ec2-user/app
cd /home/ec2-user/app

npm init -y
npm install express body-parser axios ejs

cat <<EOF > app.js
const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios");

const app = express();
const PORT = 3000;
const BACKEND_URL = "http://${FLASK_PRIVATE_IP}:5000";

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
    res.render("index");
});

app.post("/submit", async (req, res) => {
    try {
        const response = await axios.post(
            BACKEND_URL + "/submit",
            req.body
        );
        res.send(response.data);
    } catch (err) {
        res.send("Backend not reachable");
    }
});

app.listen(PORT, () => {
    console.log("Frontend running on port 3000");
});
EOF

mkdir views

cat <<EOF > views/index.ejs
<form action="/submit" method="POST">
  <input name="name" placeholder="Name" required />
  <input name="email" placeholder="Email" required />
  <button type="submit">Submit</button>
</form>
EOF

node app.js &