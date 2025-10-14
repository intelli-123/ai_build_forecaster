from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

# This function is vulnerable to SQL Injection
@app.route('/user')
def get_user():
    user_id = request.args.get('id') # User provides an ID, e.g., /user?id=1

    # DANGEROUS: The user_id is put directly into the SQL query string.
    # An attacker could provide input like "1 OR 1=1" to bypass logic.
    db = sqlite3.connect('example.db')
    cursor = db.cursor()
    query = "SELECT * FROM users WHERE id = " + user_id
    
    try:
        cursor.execute(query)
        user = cursor.fetchone()
        db.close()
        if user:
            return jsonify(user)
        else:
            return "User not found", 404
    except Exception as e:
        return f"An error occurred: {e}", 500

if __name__ == '__main__':
    # Setup a dummy database for testing
    conn = sqlite3.connect('example.db')
    c = conn.cursor()
    c.execute('''
        CREATE TABLE IF NOT EXISTS users (id INTEGER, name TEXT, email TEXT)
    ''')
    c.execute("INSERT INTO users VALUES (1, 'Alice', 'alice@example.com')")
    conn.commit()
    conn.close()
    
    app.run(debug=True)
