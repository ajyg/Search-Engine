import bottle
from bottle import get,post,request,route,run,redirect,static_file,template,error

from crawler import crawler
import sqlite3 as lite

con = lite.connect("server.db")
bot = crawler(con, "urls.txt")

"""----------------------------------------------HOME PAGE------------------------------------------------"""
@route('/')

def home():
	return template('lab3Template', view="Anonymous Home Page")


"""-----------------------------------------------------DISPLAY RESULT PAGE--------------------------------------------------------------------------"""
@get('/')
def handle_keywords():

    userInput = request.query.keywords
    page = request.query.page or 1
    if len(userInput)==0:
        return home()
    global subUserInput
    subUserInput = userInput.split()
    firstInput = subUserInput[0]

    page = int(page)
    print('this is page number: ', page)


    cursor = con.cursor()
    word_to_urlList = {}
    word_to_urlList = bot.get_resolved_inverted_index()

    url_list = []

    if firstInput not in word_to_urlList:
        return template('lab3Template', view="Word not find", keywords = userInput)
    else:
        url_list = word_to_urlList[firstInput]


    result = []
    print("url list is", url_list)
    for x in range(0,len(url_list)):
        cursor.execute("""SELECT url,title FROM PRANKS 
                            LEFT JOIN DOCID_URL ON PRANKS.doc_id = DOCID_URL.doc_id 
                            left join TITLES ON PRANKS.doc_id = TITLES.doc_id 
                            WHERE url = (?)
                            ORDER BY score""", (url_list[x],))
        output = cursor.fetchall()

        result.append(output)

    print("result is", result)


    return template('lab3Template', view="Anonymous Search Page", page = page,keywords = userInput,result = result)



@error(500)
def error500(error):
    return template('lab3Template', view="Error Search Page 500")

@error(404)
def error404(error):
    return template('lab3Template', view="Error Search Page 404")



run(host='localhost', port=8080, debug=True)

