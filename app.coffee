express = require 'express'
app = express()

pg = require 'pg'
connUrl = process.env.DATABASE_URL or 'postgres://jshou@localhost/wubi'
client = new pg.Client(connUrl)

app.configure ->
  app.use '/style', express.static(__dirname + '/style')
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

app.get '/', (req, res) ->
  console.log 'home'
  client.query 'SELECT * FROM wubiDict WHERE char = $1', [req.query.char], (err, result) ->
    codes = if err then '找不到！' else result[0].codes
    client.close()
    res.render 'index',
      char: req.query.char
      codes: codes

app.listen process.env.PORT or 3000
