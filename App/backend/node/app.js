var express = require('express');
var multer = require('multer');
var fs = require('fs');
const ipfsAPI = require('ipfs-api')


var upload = multer({dest: 'uploads/'});
var app = express()

var ipfs = ipfsAPI({host: 'ipfs.infura.io', port: '5001', protocol: 'https'});

app.post('/upload', upload.single("picture"), function (req, res, next) {
    //QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn
    console.log("Received file " + req.file.originalname);
    var data = new Buffer(fs.readFileSync(req.file.path));
    ipfs.add(data, function(err, file){
        if(err){
            console.log(err);
        }
        console.log(file);
        //console.log(file[0].hash);
        return res.send(file[0].hash);         
    });
});


let port = process.env.PORT || 5000;
app.listen(port, function() {
    return console.log("Started file upload server on port " + port);
});