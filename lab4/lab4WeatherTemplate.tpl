<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://cdn.staticfile.org/angular.js/1.6.3/angular.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Cardo" rel="stylesheet">

<style>
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

</style>
</head>
<body>

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


<script>
var app = angular.module('myApp', []);

app.config(function($interpolateProvider) {
  $interpolateProvider.startSymbol('{[{');
  $interpolateProvider.endSymbol('}]}');
});


app.controller('weatherBlock', function($scope, $http) {
  $http({
        method: "GET",
        url: "http://api.openweathermap.org/data/2.5/forecast/daily",
        params: {"q":"toronto", "appid":"e72ca729af228beabd5d20e3b7749713","units":"metric","cnt":"8"}
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
</script>
</body>
</html>
