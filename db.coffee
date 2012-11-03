pg = require 'pg'
connUrl = process.env.DATABASE_URL or 'postgres://jshou:password@localhost/wubi'
client = new pg.Client(connUrl)

module.exports = client
