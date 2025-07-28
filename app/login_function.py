import json

def lambda_handler(event, context):
    body = json.loads(event.get("body", "{}"))
    username = body.get("username")
    password = body.get("password")

    if username == "testuser" and password == "secret123":
        return {
            "statusCode": 200,
            "body": json.dumps({"message": f"Welcome, {username}!"})
        }
    else:
        return {
            "statusCode": 401,
            "body": json.dumps({"error": "Invalid credentials"})
        }
