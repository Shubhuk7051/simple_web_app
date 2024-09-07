from flask import Flask, render_template

# Create a Flask instance
app = Flask(__name__)

# Define a route for the home page
@app.route('/')
def home():
    return render_template('home.html')

# Define a route for the about page
@app.route('/about')
def about():
    return render_template('about.html')

# Run the application
if __name__ == '__main__':
    app.run(debug=True)
