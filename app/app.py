from flask import Flask, jsonify, render_template
from datetime import datetime, timezone, timedelta

app = Flask(__name__)


@app.route("/")
def get_times():
    time_data = {
        "New-York": datetime.now(timezone(timedelta(hours=-4))),
        "Berlin": datetime.now(timezone(timedelta(hours=2))),
        "Tokyo": datetime.now(timezone(timedelta(hours=9))),
    }

    return render_template("times.html", time_data=time_data)


@app.route("/health")
def health_check():
    return jsonify(status="ok")


@app.errorhandler(404)
def page_not_found(e):
    return render_template("404.html"), 404


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
