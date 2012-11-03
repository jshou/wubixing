desc 'This is the default task.'
task 'default', (params) ->
  console.log 'This is the default task.'

desc 'import data'
task 'import', (params) ->
  client = require './db'
  client.connect()
  wubiDict = require './wubiDict'
  client.query 'create table wubidict(char varchar(32), codes varchar(128))', ->
    biginsert = ''
    for char, codes of wubiDict
      biginsert += ", ('#{char}', '#{codes.join(' ')}')"
    client.query "INSERT INTO wubidict (char, codes) VALUES " + biginsert.substring(2), (err, result) ->
      if err
        console.log char
        console.log codes.join(' ')
        console.log err
      else
        client.end()

desc 'drop table'
task 'drop', (params) ->
  client = require './db'
  client.connect()
  client.query 'drop table wubidict', ->
    client.end()
