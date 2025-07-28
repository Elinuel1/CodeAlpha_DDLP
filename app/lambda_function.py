import json
import boto3
import base64
from botocore.exceptions import ClientError

kms = boto3.client('kms')
dynamodb = boto3.resource('dynamodb')
user_table = dynamodb.Table('SecureUserData')
token_table = dynamodb.Table('AccessTokens')

def encrypt_data(plaintext):
    response = kms.encrypt(
        KeyId='alias/data-encryption-key',
        Plaintext=plaintext.encode('utf-8')
    )
    return base64.b64encode(response['CiphertextBlob']).decode('utf-8')

def is_token_valid(token):
    response = token_table.get_item(Key={'token': token})
    return 'Item' in response

def lambda_handler(event, context):
    body = json.loads(event['body']) if 'body' in event else {}
    username = body.get('username')
    password = body.get('password')
    token    = body.get('token')

    if not username or not password or not token:
        return {
            'statusCode': 400,
            'body': json.dumps({"error": "Missing username, password, or token"})
        }

    if not is_token_valid(token):
        return {
            'statusCode': 403,
            'body': json.dumps({"error": "Invalid or expired token"})
        }

    encrypted_password = encrypt_data(password)

    user_table.put_item(
        Item={
            'username': username,
            'password': encrypted_password
        }
    )

    return {
        'statusCode': 200,
        'body': json.dumps({
            "message": f"User '{username}' stored securely.",
            "status": "success"
        })
    }
