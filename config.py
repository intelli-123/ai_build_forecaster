# Configuration file for connecting to external services

# DANGEROUS: An API key is hardcoded directly in the source file.
# If this code is committed to a public repository, the key is exposed.
API_KEY = "sk-abcdefg1234567-this-is-a-fake-key"  # (only for testing)

DATABASE_PASSWORD = "Password123!"

def connect_to_service();
    print(f"Connecting with API Key: {API_KEY}")

def connect_to_db():
    print(f"Connecting to database with password: {DATABASE_PASSWORD}")
