%import math

% if view == "Anonymous Home Page":

    <html>
        <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <style>

            .autocomplete {
              /*the container must be positioned relative:*/
              position: relative;
              display: inline-block;
            }

            .autocomplete-items {
              position: absolute;
              border: 1px solid #d4d4d4;
              border-bottom: none;
              border-top: none;
              z-index: 99;
              /*position the autocomplete items to be the same width as the container:*/
              top: 100%;
              left: 0;
              right: 0;
            }

            .autocomplete-items div {
              padding: 10px;
              cursor: pointer;
              background-color: #fff;
              border-bottom: 1px solid #d4d4d4;
            }

            .autocomplete-items div:hover {
              /*when hovering an item:*/
              background-color: #e9e9e9;
            }

            .autocomplete-active {
              /*when navigating through the items using the arrow keys:*/
              background-color: DodgerBlue !important;
              color: #ffffff;
            }

        </style>
        </head>
            <body>
		        <div class="container">
		            <img src="https://i.imgur.com/42MakHo.jpg" style="position:absolute;width:500px;height:300px;top:60px;left:35%" alt="broken image"/>
		            <form  autocomplete="off" class ="form-horizontal" action="/" method ="get">
				        <div class = "autocomplete" style="min-width: 500px;position:absolute;top:360px;left:35%">
				            <input id="myInput" type="text" class="form-control" name="keywords">
				            <div class="form-group">
				            <div style="position:absolute;top:0;left: 100%;">
				                 <button type="submit" class="btn btn-default">Search</button>
				            </div>
				            </div>
				        </div>
					</form>

		        </div>

            <p>{{recentSHP}}</p>

    <script>

     function autocomplete(inp, arr1, arr2) {
           var currentFocus;
    /* arr1 is recent search list, arr2 is user input history and preset search results*/
     inp.addEventListener("focus",function(e)
     {
        console.log("hahahhah");
        if (arr1.length!=0)
         {
            currentFocus = -1;
              /*create a DIV element that will contain the items (values):*/
            a = document.createElement("DIV");
            a.setAttribute("id", this.id + "autocomplete-list");
            a.setAttribute("class", "autocomplete-items");
            /*append the DIV element as a child of the autocomplete container:*/
            this.parentNode.appendChild(a);


            /*for each item in the recent history*/
            for (i = 0; i < arr1.length; i++)
            {
                b = document.createElement("DIV");
                b.innerHTML= "<i style='font-size:14px; color:#888;' class='fa'>&#xf1da;&nbsp;</i>";
                b.innerHTML += arr1[i];
                b.innerHTML += "<input type='hidden' value='" + arr1[i] + "'>";
                b.addEventListener("click", function(e)
                    {
                        /*insert the value for the autocomplete text field:*/
                        inp.value = this.getElementsByTagName("input")[0].value;
                        /*close the list of autocompleted values,
                        (or any other open lists of autocompleted values:*/
                        closeAllLists();
                    });
                a.appendChild(b);
            }
         }
     });
       /*the autocomplete takes three arguments, 1 input, 1 recent searches history list, 1 user input list (assume full list)*/

       /*execute a function when someone writes in the text field:*/
       inp.addEventListener("input", function(e) {
           console.log("this is", this);
           console.log("valueis"+this.value);

           var a, b, i, val = this.value;

           /*close any already open lists of autocompleted values*/
           closeAllLists();

           if (!val) { return false;}
           currentFocus = -1;

           /*create a DIV element that will contain the items (values):*/
           a = document.createElement("DIV");
           a.setAttribute("id", this.id + "autocomplete-list");
           a.setAttribute("class", "autocomplete-items");
           /*append the DIV element as a child of the autocomplete container:*/
           this.parentNode.appendChild(a);


           /*for each item in the recent history*/
           for (i = 0; i < arr1.length; i++) {

             /*check if the item starts with the same letters as the text field value:*/
             if (arr1[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
               /*create a DIV element for each matching element:*/
               b = document.createElement("DIV");
               /*make the matching letters bold:*/
               b.innerHTML= "<i style='font-size:14px; color:#888;' class='fa'>&#xf1da;&nbsp;</i>";

               b.innerHTML+= "<strong>" + arr1[i].substr(0, val.length) + "</strong>";
               console.log("bold is"+arr1[i].substr(0, val.length));
               b.innerHTML += arr1[i].substr(val.length);
               /*insert a input field that will hold the current array item's value:*/
               b.innerHTML += "<input type='hidden' value='" + arr1[i] + "'>";
               /*execute a function when someone clicks on the item value (DIV element):*/
               b.addEventListener("click", function(e) {
                   /*insert the value for the autocomplete text field:*/
                   inp.value = this.getElementsByTagName("input")[0].value;
                   /*close the list of autocompleted values,
                   (or any other open lists of autocompleted values:*/
                   closeAllLists();
               });
               a.appendChild(b);
             }
           }

           /*for each item in the user input history list */

             for(j=0; j<arr2.length; j++){
                 if(arr2[j].substr(0, val.length).toUpperCase() == val.toUpperCase()){
                    if(arr1.indexOf(arr2[j])<=-1)
                    {
                        /*create a DIV element for each matching element:*/
                       /*make the matching letters bold:*/
                       b = document.createElement("DIV");
                       b.innerHTML= "<i style='font-size:14px; color:#888;' class='fa'>&#xf002;&nbsp;</i>";
                       b.innerHTML += "<strong>" + arr2[j].substr(0, val.length) + "</strong>";
                       b.innerHTML += arr2[j].substr(val.length);
                       /*insert a input field that will hold the current array item's value:*/
                       b.innerHTML += "<input type='hidden' value='" + arr2[j] + "'>";
                       /*execute a function when someone clicks on the item value (DIV element):*/
                       b.addEventListener("click", function(e) {
                           /*insert the value for the autocomplete text field:*/
                           inp.value = this.getElementsByTagName("input")[0].value;
                           /*close the list of autocompleted values,
                           (or any other open lists of autocompleted values:*/
                           closeAllLists();
                       });
                       a.appendChild(b);

                    }

                 }
             }

       });


       /*execute a function presses a key on the keyboard:*/
       inp.addEventListener("keydown", function(e) {
           var x = document.getElementById(this.id + "autocomplete-list");
           if (x) x = x.getElementsByTagName("div");
           if (e.keyCode == 40) {
             /*If the arrow DOWN key is pressed,
             increase the currentFocus variable:*/
             currentFocus++;
             /*and and make the current item more visible:*/
             addActive(x);
           } else if (e.keyCode == 38) { //up
             /*If the arrow UP key is pressed,
             decrease the currentFocus variable:*/
             currentFocus--;
             /*and and make the current item more visible:*/
             addActive(x);
           } else if (e.keyCode == 13) {
             /*If the ENTER key is pressed, prevent the form from being submitted,*/
             e.preventDefault();
             if (currentFocus > -1) {
               /*and simulate a click on the "active" item:*/
               if (x) x[currentFocus].click();
             }
           }
       });
       function addActive(x) {
         /*a function to classify an item as "active":*/
         if (!x) return false;
         /*start by removing the "active" class on all items:*/
         removeActive(x);
         if (currentFocus >= x.length) currentFocus = 0;
         if (currentFocus < 0) currentFocus = (x.length - 1);
         /*add class "autocomplete-active":*/
         x[currentFocus].classList.add("autocomplete-active");
       }
       function removeActive(x) {
         /*a function to remove the "active" class from all autocomplete items:*/
         for (var i = 0; i < x.length; i++) {
           x[i].classList.remove("autocomplete-active");
         }
       }
       function closeAllLists(elmnt) {
         /*close all autocomplete lists in the document,
         except the one passed as an argument:*/
         var x = document.getElementsByClassName("autocomplete-items");
         for (var i = 0; i < x.length; i++) {
           if (elmnt != x[i] && elmnt != inp) {
             x[i].parentNode.removeChild(x[i]);
           }
         }
       }
       /*execute a function when someone clicks in the document:*/
       document.addEventListener("click", function (e) {
           closeAllLists(e.target);
       });
     }

     var recentSearchHistory = {{!recentSHP}};

     var userInputList = {{!userInputList}};


     /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
     autocomplete(document.getElementById("myInput"), recentSearchHistory, userInputList);





        </script>

            </body>
        </html>









%elif view == "Anonymous Search Page":

<html>
     <head>
	 <meta charset="utf-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1">
	 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
     <script src="https://cdn.staticfile.org/angular.js/1.6.3/angular.min.js"></script>
         <link href="https://fonts.googleapis.com/css?family=Cardo" rel="stylesheet">

        <style>

            .autocomplete {
              /*the container must be positioned relative:*/
              position: relative;
              display: inline-block;
            }

            .autocomplete-items {
              position: absolute;
              border: 1px solid #d4d4d4;
              border-bottom: none;
              border-top: none;
              z-index: 99;
              /*position the autocomplete items to be the same width as the container:*/
              top: 100%;
              left: 0;
              right: 0;
            }

            .autocomplete-items div {
              padding: 10px;
              cursor: pointer;
              background-color: #fff;
              border-bottom: 1px solid #d4d4d4;
            }

            .autocomplete-items div:hover {
              /*when hovering an item:*/
              background-color: #e9e9e9;
            }

            .autocomplete-active {
              /*when navigating through the items using the arrow keys:*/
              background-color: DodgerBlue !important;
              color: #ffffff;
            }



/*------------------------------------Weather Style---------------------------------------------*/

img{
  float:left;
  width: 50px;
  height: 50px;
  margin-right: 5px;
}

#main{
  display:flex;
  align-items: center;
}

#otherInfo{
  float: right;
  height: 50px;
  margin-right: 10px;
  color:#B2BCBF;;
}

span,text,h1,p{
  font-family: 'Cardo', serif;
}

#box{
  margin-right: 30%;
}
h1,p{
  color:#B2BCBF;
  margin-left:15px;
}
#futureWeather{
  display:flex;
  float:left;
  margin-right: 15px;
  margin-left: 15px;
}


/*------------------------------------End Of Weather Style---------------------------------------------*/


        </style>

    </head>


    <nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="#">
	    <img src="https://i.imgur.com/42MakHo.jpg" width="70" height="40" class="d-inline-block align-top" alt="">
	</a>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <!--<form class="form-inline my-2 my-lg-0" action="/" method ="get">-->
		<!--<input class="form-control mr-sm-2" type="text" name="keywords">-->
		<!--<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>-->
	    <!--</form>-->

        <form  autocomplete="off" class ="form-inline my-2 my-lg-0" action="/" method ="get">
				        <div class = "autocomplete">
				            <input id="myInput" type="text" class="form-control mr-sm-2"  name="keywords">

                            <button type="submit" class="btn btn-outline-success my-2 my-sm-0" >Search</button>

				        </div>
        </form>
	</div>
    </nav>
    %if city is not None:

<div id ="weather" style ="border-style:groove; width: 70%;overflow: hidden;" ng-app="myApp" ng-controller="weatherBlock">

    <div id="locationDD">
      <h1>
      	 {[{cityName}]}, {[{country}]}
      </h1>
      <p>
        {[{dayList[0]}]}<br>
        {[{description}]}
      </p>
    </div>
    <div id="main">
      <div id="box">
      	<img src={[{"http://openweathermap.org/img/w/"+icon+".png"}]}><span style="font-size:30px;">{[{temp}]}</span>
      		<text ng-style="customStyle.styleC" ng-click="convert('C')">°C</text>
      	/
      	<text ng-style="customStyle.styleF" ng-click="convert('F')">°F</text>
      </div>
      <div id="otherInfo">
        <span>Humidity: {[{humidity}]}%</span><br>
        <span>Wind: {[{speed}]}m/s</span>
      </div>
    </div><br>

    <div id = "futureWeather" style="display:block;" ng-repeat="x in [1,2,3,4,5,6,7]">
        <div>
          {[{dayList[x]}]}
        </div>
        <div>
          <img src={[{"http://openweathermap.org/img/w/"+futureList[x].weather[0].icon+".png"}]}>
        </div>
        <div>
          {[{minTemp[x]}]}, {[{maxTemp[x]}]}
        </div>
    </div>

</div>
%end
<body>




<script>

     function autocomplete(inp, arr1, arr2) {
           var currentFocus;
    /* arr1 is recent search list, arr2 is user input history and preset search results*/
     inp.addEventListener("focus",function(e)
     {
        console.log("hahahhah");
        if (arr1.length!=0)
         {
            currentFocus = -1;
              /*create a DIV element that will contain the items (values):*/
            a = document.createElement("DIV");
            a.setAttribute("id", this.id + "autocomplete-list");
            a.setAttribute("class", "autocomplete-items");
            /*append the DIV element as a child of the autocomplete container:*/
            this.parentNode.appendChild(a);


            /*for each item in the recent history*/
            for (i = 0; i < arr1.length; i++)
            {
                b = document.createElement("DIV");
                b.innerHTML= "<i style='font-size:14px; color:#888;' class='fa'>&#xf1da;&nbsp;</i>";
                b.innerHTML += arr1[i];
                b.innerHTML += "<input type='hidden' value='" + arr1[i] + "'>";
                b.addEventListener("click", function(e)
                    {
                        /*insert the value for the autocomplete text field:*/
                        inp.value = this.getElementsByTagName("input")[0].value;
                        /*close the list of autocompleted values,
                        (or any other open lists of autocompleted values:*/
                        closeAllLists();
                    });
                a.appendChild(b);
            }
         }
     });
       /*the autocomplete takes three arguments, 1 input, 1 recent searches history list, 1 user input list (assume full list)*/

       /*execute a function when someone writes in the text field:*/
       inp.addEventListener("input", function(e) {
           console.log("this is", this);
           console.log("valueis"+this.value);

           var a, b, i, val = this.value;

           /*close any already open lists of autocompleted values*/
           closeAllLists();

           if (!val) { return false;}
           currentFocus = -1;

           /*create a DIV element that will contain the items (values):*/
           a = document.createElement("DIV");
           a.setAttribute("id", this.id + "autocomplete-list");
           a.setAttribute("class", "autocomplete-items");
           /*append the DIV element as a child of the autocomplete container:*/
           this.parentNode.appendChild(a);


           /*for each item in the recent history*/
           for (i = 0; i < arr1.length; i++) {

             /*check if the item starts with the same letters as the text field value:*/
             if (arr1[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
               /*create a DIV element for each matching element:*/
               b = document.createElement("DIV");
               /*make the matching letters bold:*/
               b.innerHTML= "<i style='font-size:14px; color:#888;' class='fa'>&#xf1da;&nbsp;</i>";

               b.innerHTML+= "<strong>" + arr1[i].substr(0, val.length) + "</strong>";
               console.log("bold is"+arr1[i].substr(0, val.length));
               b.innerHTML += arr1[i].substr(val.length);
               /*insert a input field that will hold the current array item's value:*/
               b.innerHTML += "<input type='hidden' value='" + arr1[i] + "'>";
               /*execute a function when someone clicks on the item value (DIV element):*/
               b.addEventListener("click", function(e) {
                   /*insert the value for the autocomplete text field:*/
                   inp.value = this.getElementsByTagName("input")[0].value;
                   /*close the list of autocompleted values,
                   (or any other open lists of autocompleted values:*/
                   closeAllLists();
               });
               a.appendChild(b);
             }
           }

           /*for each item in the user input history list */

             for(j=0; j<arr2.length; j++){
                 if(arr2[j].substr(0, val.length).toUpperCase() == val.toUpperCase()){
                    if(arr1.indexOf(arr2[j])<=-1)
                    {
                        /*create a DIV element for each matching element:*/
                       /*make the matching letters bold:*/
                       b = document.createElement("DIV");
                       b.innerHTML= "<i style='font-size:14px; color:#888;' class='fa'>&#xf002;&nbsp;</i>";
                       b.innerHTML += "<strong>" + arr2[j].substr(0, val.length) + "</strong>";
                       b.innerHTML += arr2[j].substr(val.length);
                       /*insert a input field that will hold the current array item's value:*/
                       b.innerHTML += "<input type='hidden' value='" + arr2[j] + "'>";
                       /*execute a function when someone clicks on the item value (DIV element):*/
                       b.addEventListener("click", function(e) {
                           /*insert the value for the autocomplete text field:*/
                           inp.value = this.getElementsByTagName("input")[0].value;
                           /*close the list of autocompleted values,
                           (or any other open lists of autocompleted values:*/
                           closeAllLists();
                       });
                       a.appendChild(b);

                    }

                 }
             }

       });


       /*execute a function presses a key on the keyboard:*/
       inp.addEventListener("keydown", function(e) {
           var x = document.getElementById(this.id + "autocomplete-list");
           if (x) x = x.getElementsByTagName("div");
           if (e.keyCode == 40) {
             /*If the arrow DOWN key is pressed,
             increase the currentFocus variable:*/
             currentFocus++;
             /*and and make the current item more visible:*/
             addActive(x);
           } else if (e.keyCode == 38) { //up
             /*If the arrow UP key is pressed,
             decrease the currentFocus variable:*/
             currentFocus--;
             /*and and make the current item more visible:*/
             addActive(x);
           } else if (e.keyCode == 13) {
             /*If the ENTER key is pressed, prevent the form from being submitted,*/
             e.preventDefault();
             if (currentFocus > -1) {
               /*and simulate a click on the "active" item:*/
               if (x) x[currentFocus].click();
             }
           }
       });
       function addActive(x) {
         /*a function to classify an item as "active":*/
         if (!x) return false;
         /*start by removing the "active" class on all items:*/
         removeActive(x);
         if (currentFocus >= x.length) currentFocus = 0;
         if (currentFocus < 0) currentFocus = (x.length - 1);
         /*add class "autocomplete-active":*/
         x[currentFocus].classList.add("autocomplete-active");
       }
       function removeActive(x) {
         /*a function to remove the "active" class from all autocomplete items:*/
         for (var i = 0; i < x.length; i++) {
           x[i].classList.remove("autocomplete-active");
         }
       }
       function closeAllLists(elmnt) {
         /*close all autocomplete lists in the document,
         except the one passed as an argument:*/
         var x = document.getElementsByClassName("autocomplete-items");
         for (var i = 0; i < x.length; i++) {
           if (elmnt != x[i] && elmnt != inp) {
             x[i].parentNode.removeChild(x[i]);
           }
         }
       }
       /*execute a function when someone clicks in the document:*/
       document.addEventListener("click", function (e) {
           closeAllLists(e.target);
       });
     }

     var recentSearchHistory = {{!recentSHP}};

     var userInputList = {{!userInputList}};


     /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
     autocomplete(document.getElementById("myInput"), recentSearchHistory, userInputList);






/*------------------------------------------Weather Javacript Start----------------------------------------*/
var app = angular.module('myApp', []);

/* symbol conflict problem*/
app.config(function($interpolateProvider) {
  $interpolateProvider.startSymbol('{[{');
  $interpolateProvider.endSymbol('}]}');
});


app.controller('weatherBlock', function($scope, $http) {
  $http({
        method: "GET",
        url: "http://api.openweathermap.org/data/2.5/forecast/daily",
        params: {"q":"{{!city}}", "appid":"e72ca729af228beabd5d20e3b7749713","units":"metric","cnt":"8"}
    })
  .then(function (response) {

  	var weekday = new Array(7);
    weekday[0] = "Sunday";
    weekday[1] = "Monday";
    weekday[2] = "Tuesday";
    weekday[3] = "Wednesday";
    weekday[4] = "Thursday";
    weekday[5] = "Friday";
    weekday[6] = "Saturday";

  	//Day, Date, Time
  	var utcSeconds = response.data.list[0].dt;
  	var date= new Date(0);
  	date.setUTCSeconds(utcSeconds);
  	$scope.day = weekday[date.getDay()];
    $scope.weekday = weekday;
  	$scope.cityName = response.data.city.name;
  	$scope.country = response.data.city.country;

    $scope.speed = response.data.list[0].speed;
  	$scope.mainTemp=response.data.list[0].temp.day;
  	$scope.temp=response.data.list[0].temp.day;
    $scope.humidity = response.data.list[0].humidity;
  	var weather = response.data.list[0].weather[0];
  	$scope.description=weather.description;
  	$scope.icon = weather.icon;
 	  $scope.customStyle = {};
    $scope.customStyle.styleC = {"color":"blue"};
    $scope.futureList = response.data.list;
    console.log(response.data);

    var dayList = [];
    $scope.maxTemp=[];
    $scope.minTemp=[];
    $scope.mainMaxTemp = [];
    $scope.mainMinTemp = [];
    var i = 0;
    for(i=0;i<$scope.futureList.length;i++)
    {
      var utcSeconds = $scope.futureList[i].dt;
      var date = new Date(0);
      date.setUTCSeconds(utcSeconds);
      dayList.push(weekday[date.getDay()]);
      $scope.minTemp.push(response.data.list[i].temp.min);
      $scope.mainMinTemp.push(response.data.list[i].temp.min);
      $scope.maxTemp.push(response.data.list[i].temp.max);
      $scope.mainMaxTemp.push(response.data.list[i].temp.max);
    }
    $scope.dayList = dayList;
 // display min, max temp, day, icon for future 7 days
  });


  $scope.convert = function(unit){
  		if (unit=='C'){
        var i = 0;
        for (i=0;i<$scope.futureList.length;i++){
  				$scope.temp = $scope.mainTemp;
          $scope.minTemp[i] = $scope.mainMinTemp[i];
          $scope.maxTemp[i] = $scope.mainMaxTemp[i];
  				$scope.customStyle.styleC = {"color":"blue"};
  				$scope.customStyle.styleF = {"color":"black"};
        }
  		}
  		else{
        var i = 0;
        for (i=0;i<$scope.futureList.length;i++){
    			$scope.temp=window.Math.round($scope.mainTemp*9/5+32);
          $scope.minTemp[i]=window.Math.round($scope.mainMinTemp[i]*9/5+32);
          $scope.maxTemp[i]=window.Math.round($scope.mainMaxTemp[i]*9/5+32);

    			$scope.customStyle.styleF = {"color":"blue"};
    			$scope.customStyle.styleC = {"color":"black"};
        }
  		}

  	}

});
/*------------------------------------------End Of Weather Javacript Start----------------------------------------*/
</script>





</body>
    %for x in range((page-1)*5, min(len(result),page*5)):

            %if len(result[x])==0:
                %continue
            %else:
                 <form action="/" method ="get">
                    <a href={{result[x][0][0]}} class="list-group-item list-group-item-action">
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

	%totalPageNum =int(len(result)/5)
	%if totalPageNum*5 != len(result):
		%totalPageNum = int(len(result)/5)+1
    %end

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
	    <img src="https://i.imgur.com/42MakHo.jpg" width="75" height="40" class="d-inline-block align-top" alt="">
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



