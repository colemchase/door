import json
import boto3
import base64

rekognition = boto3.client('rekognition')

def lambda_handler(event, context):
    try:
        # If request body is base64 encoded
        if event.get("isBase64Encoded"):
            body = base64.b64decode(event["body"])
        else:
            body = base64.b64decode(json.loads(event["body"])["image"])

        response = rekognition.search_faces_by_image(
            CollectionId='raspi-user-faces',
            Image={'Bytes': body},
            FaceMatchThreshold=90,
            MaxFaces=1
        )

        if response["FaceMatches"]:
            match = response["FaceMatches"][0]
            return {
                "statusCode": 200,
                "body": json.dumps({
                    "match": True,
                    "similarity": match["Similarity"]
                })
            }
        else:
            return {
                "statusCode": 200,
                "body": json.dumps({"match": False})
            }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }