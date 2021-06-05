const express = require('express')
const {spawn} = require('child_process');
const app = express()
const port = 3000

var fs = require('fs');
var csvWriter = require('csv-write-stream');
const path = require('path');
const { resolve4 } = require('dns');

app.use((req, res, next) => {
	res.setHeader("Access-Control-Allow-Origin","*");
	res.setHeader(
		"Access-Controll-Allow-Headers",
		"Origin, X-Requested-With, Content-Type, Accept,Authorization"
	);
	res.setHeader("Access-Control-Allow-Methods", "GET,POST");
	next();
});

app.get('/a', (req, res) => {
 
    var largeDataSet = [];
    // spawn new child process to call the python script
    console.log(req.query.id);
    const python = spawn('python', ['maja.py', req.query.id]);

    // collect data from script
    python.stdout.on('data', function (data) {
        largeDataSet.push(data);
    });

    // in close event we are sure that stream is from child process is closed
    python.on('close', (code) => {
        console.log("Da li nesto ispisujem");
        console.log(largeDataSet.join(""))
        res.json(largeDataSet.join(""))
    });
 
});

app.get('/dodajKupovinu', (req, res) =>{
    var broj = 0;
    if (!fs.existsSync('inf.csv'))
        writer = csvWriter({ headers: ["id", "idKorisnika", "idKategorije", "idProizvoda", "ocena", "idProdavca"]});
    else
        writer = csvWriter({sendHeaders: false});
    
    writer.pipe(fs.createWriteStream('inf.csv', {flags: 'a'}));
    writer.write({
        id : ++broj,
        idKorisnika : req.query.idKorisnika,
        idKategorije : req.query.idKategorije,
        idProizvoda : req.query.idProizvoda,
        ocena : req.query.ocena,
        idProdavca : req.query.idProdavca,  
    });
    writer.end();
});

app.get('/dodajProizvod', (req, res) =>{

    if (!fs.existsSync('proipro.csv'))
        writer = csvWriter({ headers: ["idProdavca", "idProizvoda"]});
    else
        writer = csvWriter({sendHeaders: false});

    writer.pipe(fs.createWriteStream('proipro.csv', {flags: 'a'}));
    writer.write({
        idProdavca : req.query.idProdavca,
        idProizvoda : req.query.idProizvoda, 
    });
    writer.end();
});

app.get('/inf.csv', function(req, res){
    const file = `${__dirname}/inf.csv`;
    res.sendFile(file);
 });

app.get('/proipro.csv', function(req, res){
    const file = `${__dirname}/proipro.csv`;
    res.sendFile(file);
 });



app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`);
});