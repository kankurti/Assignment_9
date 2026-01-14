#!/bin/bash
yum update -y
yum install -y python3 git
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Backend
mkdir /backend
cat <<EOF >/backend/app.py
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/submit", methods=["POST"])
def submit():
    name = request.form.get("name")
    email = request.form.get("email")
    return jsonify({"message": "Data received", "name": name, "email": email})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

pip3 install flask
nohup python3 /backend/app.py &

# Frontend
mkdir /frontend && cd /frontend
npm init -y
npm install express body-parser axios ejs

cat <<EOF >server.js
const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios");

const app = express();
const PORT = 3000;
const BACKEND_URL = process.env.BACKEND_URL || "http://localhost:5000";

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => res.render("index"));

app.post("/submit", async (req, res) => {
    try {
        const response = await axios.post(\`\${BACKEND_URL}/submit\`, req.body);
        res.send(response.data);
    } catch {
        res.send("Backend not reachable");
    }
});

app.listen(PORT, () => console.log(`Frontend running on port ${PORT}`));
EOF

mkdir views
cat <<EOF >views/index.ejs
<form action="/submit" method="POST">
  <input name="name" placeholder="Name" required/>
  <input name="email" placeholder="Email" required/>
  <button type="submit">Submit</button>
</form>
EOF

nohup node server.js &

