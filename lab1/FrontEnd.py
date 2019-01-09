import sqlite3

conn = sqlite3.connect('searchEngine.db')

cursor = conn.cursor()

# clear history from table every time before the first search
cursor.execute("DELETE FROM wordList")

"""


"""

from oauth2client.client import OAuth2WebServerFlow
from googleapiclient.errors import HttpError
from googleapiclient.discovery import build







from bottle import get,post,request,route,run,redirect,static_file

@route('/')
# home page display search engine and history of words
def home():

    return '''
    <html>
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
        <body>    
        <div class="container">
            <img src="/images/ACELOGO.png" style="position:absolute;width:500px;height:300px;top:4%;left:35%" alt="broken image"/>
            <form class ="form-horizontal" action="/" method ="get">
            <div style="min-width: 500px;position:absolute;top: 50%;left: 35%;">
                <input type="text" class="form-control" name="keywords">
            </div>
            <div class="form-group">
            <div style="position:absolute;top: 50%;left: 70%;">
                <button type="submit" class="btn btn-default">Search</button>
            </div>
            </div> 
            </form>
        
        </div>
        </body>
    </html>
    '''
@route('/images/<filename:re:.*\.png>')
def send_image(filename):
    return static_file(filename, root='', mimetype='image/png')

@get('/')
def handle_keywords():
    request.query.keywords = "hhh"
    userInput = request.query.keywords


    if len(userInput)==0:
        return home()

    subUserInput = userInput.split()

    # Add all keyword into database, lowercase all words
    for keyword in subUserInput:
        keyword = keyword.lower()
        cursor.execute("SELECT * FROM wordList where keyword =(?)", (keyword,))
        result = cursor.fetchall()
        if not result:
            newInput = [keyword, 1]
            cursor.execute("INSERT INTO wordList VALUES(?,?)", newInput)
        else:
            cursor.execute("UPDATE wordList SET count = count+1 where keyword = (?)", (keyword,))

    # Add a dictionary because do not want duplicate words print out in results ex."hello hello" it will on appear once in dict
    # this is for looping the results later. instead of looping the userInput, we loop the dictionary
    dict = {}
    for keyword in subUserInput:
        keyword = keyword.lower()
        if keyword in dict:
            dict[keyword] += 1
        else:
            dict[keyword] = 1

    # Show each word from user input and number of occurrences of each word
    result = ""
    for keyword in dict:
        result = result + "<tr><td>"+keyword+"</td><td>"+str(dict[keyword])+"</td></tr>"


    history = ""
    for row in cursor.execute('SELECT * FROM wordList order by count desc LIMIT 5'):
        history = history + "<tr><td>"+row[0]+"</td><td>"+str(row[1])+"</td></tr>"

    return '''
    <html>
    <body">
        <div class="container">
            <form class ="form-horizontal" action="/" method ="get">
            <div>
                <input type="text" class="form-control" name="keywords">
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-default">Search</button>
            </div> 
            </form>
        </div>
    <p>Search for "'''+userInput+'''"</p>
    <h2>Result Table</h2>
    <table id = "results">
    <tr><th>Keyword</th>
    <th>Frequency</th></tr>
    '''+result+'''
    </table>
    <h2>History Table</h2>
    <table id = "history">
    <tr><th>Keyword</th>
    <th>Frequency</th></tr>
    '''+history+'''
    </table>
    </body>
    </html>
    '''


run(host='localhost', port=8080, debug=True)
conn.commit()
conn.close()
