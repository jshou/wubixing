express = require 'express'
inspect = require('eyes').inspect
app = express()
client = require './db'

client.connect()

app.configure ->
  app.use '/style', express.static(__dirname + '/style')
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

app.get '/', (req, res) ->
  client.query 'SELECT * FROM wubiDict WHERE char = $1;', [req.query.char], (err, result) ->
    console.log ''
    console.log "getting codes from db for: #{req.query.char}"
    console.log "ERRORS: #{err}"
    console.log "RESULT: #{result}"
    codes = if err then '找不到！' else '有东西'
    res.render 'index',
      char: req.query.char
      codes: codes

app.listen process.env.PORT or 3000
