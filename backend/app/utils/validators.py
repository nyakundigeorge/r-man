from functools import wraps
from flask import (
    jsonify,
    request,
)


def validate_json(f):
    @wraps(f)
    def wrapper(*args, **kw):
        try:
            request.get_json()
        except Exception as e:
            msg = "payload must be a valid json"
            return jsonify({"error": msg}), 400
        return f(*args, **kw)
    return wrapper