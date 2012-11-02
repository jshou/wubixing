express = require 'express'
app = express()

app.configure ->
  app.use '/style', express.static(__dirname + '/style')
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'

app.get '/', (req, res) ->
  res.render 'index',
    char: req.query.char
    codes: 'a b c'

app.listen process.env.PORT or 3000
