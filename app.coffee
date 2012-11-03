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
  client.query
    name: 'get_codes'
    text: "SELECT * FROM wubiDict WHERE char = $1 LIMIT 1"
    values: [req.query.char]
  , (err, result) ->
    console.log ''
    console.log "getting codes from db for: #{req.query.char}"
    console.log "CHAR:   #{req.query.char}"
    console.log "ERRORS: #{err}"
    console.log "RESULT: %j", result

    if err or result.rowCount < 1
      codes = '找不到！'
    else
      codes = result.rows[0].codes
    res.render 'index',
      char: req.query.char
      codes: codes.split ' '

app.listen process.env.PORT or 3000
