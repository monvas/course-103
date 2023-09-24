import os
import requests
import sys

# Get the value of the "token" environment variable
token = os.environ.get("canvas_token")

# Check if the variable is set
if token is not None:
    print("token:", token)
else:
    print("Canvas token environment variable is not set.")
    sys.exit(1)

headers = {
    "Authorization": "Bearer " + token,
}

course_id = 19899

r = requests.get(
    f"https://canvas.ltu.se/api/v1/courses/{course_id}/users",
    headers=headers)

print(r.status_code)

# Check if the response status code is 200 (OK) before attempting to parse the JSON response
if r.status_code == 200:
    users_data = r.json()
    for user in users_data:
        # Access the 'name' key within each user dictionary
        print(user['name'])

        # for now, exit after outputting the first user
        sys.exit(0)
else:
    print(f"Request failed with status code {r.status_code}")
    sys.exit(1)
