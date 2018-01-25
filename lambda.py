# lambda.py

import json

def handler(event, context):
	print('hello world!')
	print(f"Received event: {json.dumps(event, indent=2)}")