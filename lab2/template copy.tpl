% if page == "Anonymous Home Page":
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
                <img src="/images/ACELOGO.png" style="position:absolute;width:500px;height:300px;top:60px;left:35%" alt="broken image"/>
                <form class ="form-horizontal" action="/" method ="get">
                <div style="min-width: 500px;position:absolute;top:360px;left:35%">
                    <input type="text" class="form-control" name="keywords">
                    <div class="form-group">
                    <div style="position:absolute;top:0;left: 100%;">
                         <button type="submit" class="btn btn-default">Search</button>
                    </div>
                    </div>
                </div>

                </form>

                    <div class='btn-toolbar pull-right'>
                        <div class='btn-group'>
                            <form action="/signin" method ="get">
                                <button type="submit" class="btn btn-primary">Sign In</button>

                            </form>
                        </div>
                    </div>


            </div>
            </body>
        </html>


52.90.231.182:80

%elif page =="User Home Page":
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
                    <img src="/images/ACELOGO.png" style="position:absolute;width:500px;height:300px;top:60px;left:35%" alt="broken image"/>
                    <form class ="form-horizontal" action="/" method ="get">
                    <div style="min-width: 500px;position:absolute;top:360px;left:35%">
                        <input type="text" class="form-control" name="keywords">
                        <div class="form-group">
                        <div style="position:absolute;top:0;left: 100%;">
                             <button type="submit" class="btn btn-default">Search</button>
                        </div>
                        </div>
                    </div>
                    </form>

                        <div class='btn-toolbar pull-right'>
                         <div class="btn-group">
                            <ul class="drop-down">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                 <img src= "{{current_user_pic}} " width = 50px height = 50px  class ="profile-image img-circle"/>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><i class="fa fa-cog"></i> {{current_user_name}}</a></li>
                                    <li><a href="#"><i class="fa fa-cog"></i> {{current_user_email}}</a></li>
                                </ul>
                            </ul>
                        </div>
                        <div class='btn-group'>
                            <form action="/signout" method ="get">
                                <button type="submit" class="btn btn-primary">Sign Out</button>

                            </form>
                        </div>
                    </div>
                </div>
            </body>

     </html>



%elif page == "Anonymous Search Page":

        <html>
            <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <style>
                 table, th, td {
                      position: relative;
                      left: 10px;
                      border: 1px solid black;
                      padding: 25px 25px 25px 25px;
                  }
            </style>
            </head>
            <body>
                <div class="container">
                    <form class ="form-horizontal" action="/" method ="get">
                    <div style="min-width: 500px;position:absolute;top: 200px;left: 35%;">
                        <input type="text" class="form-control" name="keywords">
                        <div style="position:absolute;top: 0;left: 100%;">
                             <button type="submit" class="btn btn-default">Search</button>
                        </div>

                    </div>
                    </form>

                     <div class='btn-toolbar pull-right'>
                        <div class='btn-group'>
                            <form action="/signin" method ="get">
                                <button type="submit" class="btn btn-primary">Sign In</button>

                            </form>
                        </div>
                    </div>
                </div>
        <fieldset>
        <div style="position:absolute;left: 200px; top: 100px;">
        <legend>Search for {{userInput}}</legend>
        <h2>Result Table</h2>
            <table id = "results">
            <tr>
            <th>Keyword</th>
            <th>Frequency</th>
            </tr>
           %for keyword in userInputResult:
                <tr>
                    <td>
                        {{keyword}}
                    </td>
                    <td>
                        {{str(userInputResult[keyword])}}
                    </td>
                </tr>
                %end
            </table>
        </div>
        </fieldset>
            </body>
            </html>




%elif page == "User Search Page":

    <html>
            <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <style>
                 table, th, td {
                      position: relative;
                      left: 10px;
                      border: 1px solid black;
                      padding: 25px 25px 25px 25px;
                  }
            </style>
            </head>
            <body>
                <div class="container">
                    <form class ="form-horizontal" action="/" method ="get">
                    <div style="min-width: 500px;position:absolute;top: 200px;left: 35%;">
                        <input type="text" class="form-control" name="keywords">
                        <div style="position:absolute;top: 0;left: 100%;">
                             <button type="submit" class="btn btn-default">Search</button>
                        </div>
                    </div>
                    </form>

                     <div class='btn-toolbar pull-right'>
                         <div class="btn-group">
                            <ul class="drop-down">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                 <img src= "{{current_user_pic}} " width = 50px height = 50px  class ="profile-image img-circle"/>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="#"><i class="fa fa-cog"></i> {{current_user_name}}</a></li>
                                    <li><a href="#"><i class="fa fa-cog"></i> {{current_user_email}}</a></li>
                                </ul>
                            </ul>
                        </div>
                        <div class='btn-group'>
                            <form action="/signout" method ="get">
                                <button type="submit" class="btn btn-primary">Sign Out</button>

                            </form>
                        </div>
                    </div>
                </div>
        <fieldset>
        <div style="position:absolute;left: 200px; top: 100px;">
        <legend>Search for {{userInput}}</legend>
        <h2>Result Table</h2>
            <table id = "results">
            <tr>
            <th>Keyword</th>
            <th>Frequency</th>
            </tr>
           %for keyword in userInputResult:
                <tr>
                    <td>
                        {{keyword}}
                    </td>
                    <td>
                        {{str(userInputResult[keyword])}}
                    </td>
                </tr>
                %end
            </table>
        <h2>History Table</h2>
            <table id = "history">
            <tr>
            <th>Keyword</th>
            <th>Frequency</th>
            </tr>

        %for word in history:
                <tr>
                    <td>
                        {{word}}
                    </td>
                    <td>
                        {{history[word]}}
                    </td>
                </tr>
            %end
            </table>
        <h2>Recent Search Table</h2>
            <table id = "recent search">
            <tr>
            <th>Keyword</th>
            </tr>
                %for i in range(0,len(recentSearch)):
                <tr>
                    <td>
                        {{recentSearch[i]}}
                    </td>
                </tr>
                %end
            </table>
        </div>
        </fieldset>
            </body>
            </html>

%else:
    print("error")
%end
