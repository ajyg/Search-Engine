from oauth2client.client import OAuth2WebServerFlow
from oauth2client.client import flow_from_clientsecrets
from googleapiclient.errors import HttpError
from googleapiclient.discovery import build
import httplib2
import bottle
from bottle import get,post,request,route,run,redirect,static_file,template
import time
from beaker.middleware import SessionMiddleware


trackLogin = 0
logInTime = 0
userHistory = {}


"""----------------------------------------------HOME PAGE------------------------------------------------"""
@route('/')

def home():

# Display Sign In Page if no user log in, or user log out explicitly or session expire

    timeDiff = time.mktime(time.localtime()) - logInTime

    if trackLogin == 0 or timeDiff >= session_opts['session.cookie_expires']:
        return template('template', page="Anonymous Home Page")
    else:
        return template('template', page="User Home Page", current_user_email = current_user_email, current_user_pic = current_user_pic,
                        current_user_name = current_user_name)


@route('/images/<filename:re:.*\.png>')
def send_image(filename):
    return static_file(filename, root='../lab1_group_21', mimetype='image/png')


"""-----------------------------------------------------DISPLAY RESULT PAGE--------------------------------------------------------------------------"""
@get('/')
def handle_keywords():

    userInput = request.query.keywords
    if len(userInput)==0:
        return home()
    global subUserInput
    subUserInput = userInput.split()


# SAVE USER INPUT RESULTS
    userInputResult = {}
    for keyword in subUserInput:
        keyword = keyword.lower()
        if keyword in userInputResult:
            userInputResult[keyword] += 1
        else:
            userInputResult[keyword] = 1


# IF A USER IS LOGGED IN, DISPLAY RECENT SEARCH, HISTORY AND USER INPUT TABLE
    if trackLogin == 1:

        # DISPLAY HISTORY FOR DIFFERENT USERS
        if current_user_email not in userHistory:
            userHistory[current_user_email] = {}

        for keyword in subUserInput:
            keyword = keyword.lower()

            if keyword not in userHistory[current_user_email]:
                userHistory[current_user_email][keyword] = 1
            else:
                userHistory[current_user_email][keyword] += 1

        sortedHistoryList = sorted(userHistory[current_user_email].items(),key=lambda kv: kv[1], reverse=True)

        # Only display top 2 words in history
        history = {}

        for i in range(0, min(2,len(sortedHistoryList))):
            word = sortedHistoryList[i][0]
            countNum = sortedHistoryList[i][1]
            history[word] = str(countNum)


        # SAVE RECENT SEARCHES FOR DIFFERENT USER

        if current_user_email not in session:
            session[current_user_email] = []
        for word in subUserInput:
            word = word.lower()
            if word not in session[current_user_email]:
                session[current_user_email].append(word)
            else:
                session[current_user_email].remove(word)
                session[current_user_email].append(word)

        print(session[current_user_email])
        recentSearch = []
        for i in range(0,min(3,len(session[current_user_email]))):
            size = len(session[current_user_email])-1
            recentSearch.append(session[current_user_email][size-i])


        return template('template', page = "User Search Page", userInput = userInput,
                        userInputResult = userInputResult, history = history, recentSearch = recentSearch,
                        current_user_email = current_user_email, current_user_pic = current_user_pic,
                        current_user_name = current_user_name)


# If Anonymous Search, Only display user input results on result page
    else:
        return template('template', page = "Anonymous Search Page", userInput = userInput, userInputResult = userInputResult )


"""------------------------------------------------------CONFIGURE SESSION-----------------------------------------------------------"""

session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 30,
    'session.data_dir': './data',
    'session.auto': True
}
app = SessionMiddleware(bottle.app(), session_opts)


"""-----------------------------------------------------HANDLE SIGN IN BUTTON----------------------------------------------------------------"""
@route('/signin','GET')
def getAuthorization():
    flow = flow_from_clientsecrets("client_secrets.json", scope='https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.email', redirect_uri="http://localhost:8080/redirect")
    uri = flow.step1_get_authorize_url()
    redirect(str(uri))



"""------------------------------------------------------REDIRECT------------------------------------------------------------"""
@route('/redirect')

def redirect_page():
    code = request.query.get('code','')

    flow = OAuth2WebServerFlow(client_id = "303884494013-pse8grs2qipbicv1mp5tj2di74k3f2eb.apps.googleusercontent.com",
                               client_secret="cF4Qn_Fx4bkMKpPrBb6gXigC",
                               scope='https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.email',
                               redirect_uri="http://localhost:8080/redirect")

    credentials = flow.step2_exchange(code)
    global token
    token = credentials.id_token['sub']


    http = httplib2.Http()
    http = credentials.authorize(http)



    current_users_service = build('oauth2','v2',http=http)
    current_user_document = current_users_service.userinfo().get().execute()



    # GET USER INFORMATION, EMAIL, NAME, PICTURE
    global current_user_email

    print(current_user_document)
    current_user_email= current_user_document['email']

    global current_user_pic
    current_user_pic = current_user_document['picture']

    global current_user_name
    if 'name' in current_user_document:
        current_user_name = current_user_document['name']
    else:
        current_user_name=""


    global session
    session = bottle.request.environ.get('beaker.session')

    global logInTime
    logInTime = time.mktime(time.localtime())


    global trackLogin
    trackLogin = 1

    return home()

@route('/signout','GET')
def signout():
    global trackLogin
    trackLogin = 0
    return home()



run(host='localhost', port=8080, debug=True, app=app)



