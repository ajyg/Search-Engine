import bottle
from bottle import get,post,request,route,run,redirect,static_file,template,error
from crawler import crawler
import sqlite3 as lite

con = lite.connect("server.db")
bot = crawler(con, "urls.txt")


recent = {}
recentSHP = []
userInputList = ["haha","heihei","hohpph","unicode","uni is good"]

"""----------------------------------------------HOME PAGE------------------------------------------------"""
@route('/')

def home():
    print("here is ", recentSHP)
    return template('lab4Template', view="Anonymous Home Page", recentSHP = recentSHP, userInputList = userInputList)


"""-----------------------------------------------------DISPLAY RESULT PAGE--------------------------------------------------------------------------"""
@get('/')
def handle_keywords():

    userInput = request.query.keywords
    if userInput not in userInputList:
        userInputList.append(userInput)

    print("user input list is", userInputList)
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
        return template('lab4Template', view="Word not find", keywords = userInput)
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



    # Recent Search
    if "history" not in recent:
        recent["history"] = []

    for word in subUserInput:
        word = word.lower()
        if word not in recent["history"]:
            recent["history"].append(word)
        else:
            recent["history"].remove(word)
            recent["history"].append(word)


    recentSearch= []
    for i in range(0,min(3,len(recent["history"]))):
        size = len(recent["history"])-1
        if recent["history"][size-i] not in recentSearch:
            recentSearch.append(recent["history"][size-i])
        else:
            continue
    global recentSHP
    recentSHP = recentSearch
    print("recentSHP is",recentSHP)
    print("recent search is",recentSearch)


    """----------------------IF USER WANTS TO KNOW ABOUT WEATHER------------------"""

    print("subUserInput is", subUserInput)
    if "weather" in subUserInput and subUserInput[0]!="weather":
        return template('lab4Template', view="Anonymous Search Page", page = page,keywords = userInput,result = result,recentSHP = recentSHP, userInputList = userInputList,city=subUserInput[0])
    else:
        return template('lab4Template', view="Anonymous Search Page", page = page,keywords = userInput,result = result,recentSHP = recentSHP, userInputList = userInputList,city=None)


@route('/images/<filename:re:.*\.png>')
def send_image(filename):
    return static_file(filename, root='../lab3_group_21', mimetype='image/png')

@error(500)
def error500(error):
    return template('lab4Template', view="Error Search Page 500")

@error(404)
def error404(error):
    return template('lab4Template', view="Error Search Page 404")



run(host='localhost', port=8080, debug=True)

