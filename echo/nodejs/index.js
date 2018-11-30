var express = require('express');
var app = express();

app.get(/.*/, function (req, res) {
  res.send('Request for ' + req.path);
});

app.listen(8080, function () {
  console.log('Example app listening on port 8080!');
});
