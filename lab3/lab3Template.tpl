%import math

% if view == "Anonymous Home Page":

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
		            <img src="https://lh4.googleusercontent.com/i-xIilRaT3-cQvD1sAej1AvoB6CYNeE-ZMjLcOb8JLJS-sXS0YH5o3Cj0yuz7xrZgqiW8ExRw70KaavbytM0=w1439-h668-rw" style="position:absolute;width:500px;height:300px;top:60px;left:35%" alt="broken image"/>
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
		        </div>
            </body>
        </html>
%elif view == "Anonymous Search Page":

<html>
    <head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    </head>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="#">
	    <img src="https://lh4.googleusercontent.com/i-xIilRaT3-cQvD1sAej1AvoB6CYNeE-ZMjLcOb8JLJS-sXS0YH5o3Cj0yuz7xrZgqiW8ExRw70KaavbytM0=w1439-h668-rw" width="70" height="40" class="d-inline-block align-top" alt="">
	</a>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <form class="form-inline my-2 my-lg-0" action="/" method ="get">
		<input class="form-control mr-sm-2" type="text" name="keywords">
		<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form>
	</div>
    </nav>


    %for x in range((page-1)*5, min(len(result),page*5)):

            %if len(result[x])==0:
                %continue
            %else:
                 <form action="/" method ="get">
                    <a href="https://www.google.ca/?gws_rd=ssl" class="list-group-item list-group-item-action">
                        %if result[x][0][1] is None:
                            <small style="color:green;" id = "link">{{result[x][0][0]}}</small>
                        %else:
                            %title = result[x][0][1][1:len(result[x][0][1])-1]
                            <h5 style="color:blue;">{{title}}</h5>
                            <small style="color:green;" id = "link">{{result[x][0][0]}}</small>
                        %end
                    </a>
                </form>
            %end
    %end

<div id = "page list">
<form action="/" method ="get">
<input type="hidden" name="keywords" value={{keywords}}>


<nav aria-label="...">
  <ul class="pagination">
      %totalPageNum = math.ceil(len(result)/5)
      %print("total page number is",totalPageNum)

     %if page == 1 and totalPageNum!=1:
          %for pageNum in range(page,min(totalPageNum+1,page+3)):

                <li class="page-item"><a href="#">

                    <button class="page-link" name="page" type="submit" value= {{pageNum}}>{{pageNum}}</button>

                </a></li>
          %end
              <li class="page-item">
               <a href="#">

              <button class="page-link" name="page" type="submit" value= {{page+1}}>Next</button>
           </a>
            </li>

      %elif page == totalPageNum and totalPageNum!=1:
            <li class="page-item">
               <a href="#">

              <button class="page-link" name="page" type="submit" value= {{page-1}}>Previous</button>
           </a>
            </li>

           <li class="page-item"><a href="#">
               <button class="page-link" name="page" type="submit" value= {{page}}>{{page}}</button>
           </a></li>

      %elif totalPageNum ==1:
            <li class="page-item"><a href="#">
                <button class="page-link" name="page" type="submit" value= 1>1</button>
                </a></li>
      %else:
            %print("current page is", page)
          <li class="page-item">
               <a href="#">

              <button class="page-link" name="page" type="submit" value= {{page-1}}>Previous</button>
           </a>
            </li>

            %for pageNum in range(page,min(totalPageNum+1,page+3)):

                <li class="page-item"><a href="#">
                <button class="page-link" name="page" type="submit" value= {{pageNum}}>{{pageNum}}</button>
                </a></li>
             %end
              <li class="page-item">
               <a href="#">

              <button class="page-link" name="page" type="submit" value= {{page+1}}>Next</button>
           </a>
            </li>

    %end

  </ul>
</nav>
</form>
</div>

</html>


%elif view == "Word not find":
<html>
    <head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    </head>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="#">
	    <img src="https://lh4.googleusercontent.com/i-xIilRaT3-cQvD1sAej1AvoB6CYNeE-ZMjLcOb8JLJS-sXS0YH5o3Cj0yuz7xrZgqiW8ExRw70KaavbytM0=w1439-h668-rw" width="75" height="40" class="d-inline-block align-top" alt="">
	</a>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <form class="form-inline my-2 my-lg-0" action="/" method ="get">
		<input class="form-control mr-sm-2" type="text" name="keywords">
		<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
	    </form>
	</div>
    </nav>
    <p>
    <pre>
        Your search - <b>{{keywords}}</b> - did not match any documents.

        Suggestions:

        Make sure that all words are spelled correctly.
        Try different keywords.
        Try more general keywords.
    </pre>

    </p>
</html>



%elif view == "Error Search Page 404":
<html>
    <head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    </head>
    <p style="font-size:50px;"><b>
	404
    </b></p>
    <p>
	Page doesn't exist
    </p>
    <!--<form action="/" method ="get">-->
    <p> click
	<a href="http://localhost:8080">
	    here
	</a>
	to go back
    </p>
    <!--</form>-->
</html>

%elif view == "Error Search Page 500":
<html>
    <head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    </head>
        <p style="font-size:50px;"><b>
	500
    </b></p>
    <p>
    <p>
	Execution error
    </p>
    <p> click
	<a href="http://localhost:8080">
	    here
	</a>
	to go back
    </p>
</html>




%else:
    print("error")
%end




