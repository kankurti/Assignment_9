#!/bin/bash
yum update -y
yum install python3 -y
pip3 install flask

cat <<EOF > app.py
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/submit", methods=["POST"])
def submit():
    name = request.form.get("name")
    email = request.form.get("email")
    return jsonify({"message":"Data received","name":name,"email":email})

app.run(host="0.0.0.0", port=5000)
EOF

nohup python3 app.py &
