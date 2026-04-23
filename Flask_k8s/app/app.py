from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <html>
    <head>
        <title>Flask Login</title>
        <style>
            body {
                font-family: Arial;
                background: #eef2f7;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
                text-align: center;
                width: 260px;
            }
            h2 {
                margin-bottom: 20px;
            }
            input {
                width: 100%;
                padding: 8px;
                margin: 8px 0;
                border-radius: 5px;
                border: 1px solid #ccc;
            }
            .forgot {
                font-size: 12px;
                color: #007bff;
                text-decoration: none;
            }
            .status {
                margin-top: 15px;
                color: green;
                font-size: 13px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Flask App</h2>
            <input type="text" placeholder="Login Name">
            <input type="password" placeholder="Password">
            <a class="forgot" href="#">Forgot Password?</a>
            <div class="status">
                ✔ Application running successfully
            </div>
        </div>
    </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
