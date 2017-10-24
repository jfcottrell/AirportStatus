var fs = require('fs')
var readline = require('readline');
var data = {stateCode:"", stateName:"", cityName: "", airportName:"", airportCode:"", lat:0, lon:0, website:""};
var dataArray = [];

var rd = readline.createInterface({
    input: fs.createReadStream('airports.csv'),
    output: process.stdout,
    console: false
});

rd.on('line', function(line) {
    var inputArray = line.split(",");
    data["stateCode"] = inputArray[0];
    data["stateName"] = inputArray[1];
    data["cityName"] = inputArray[2];
    data["airportName"] = inputArray[3];
    data["airportCode"] = inputArray[4];
    data["lat"] = inputArray[5];
    data["lon"] = inputArray[6];
    data["website"] = inputArray[7];
    console.log(data);
    fs.appendFile('airports.json', JSON.stringify(data), function(err) {
    });

    fs.appendFile('airports.json', ",", function(err) {
    });
});
