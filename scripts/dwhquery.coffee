# Description:
#   hubot Data Warehouse querying
#
# Dependencies:
#   None
# 
# Commands:
#   hubot query <sql query>
# 
# Author
#   Daan Debie

module.exports = (robot) ->
  robot.respond /query( me)? (.*)/i, (msg) ->
    rijksMe msg, msg.match[2], (resp) ->
      json_tb = require('json-table')
      json_tb_out = new json_tb resp, {}, (table) ->
        msg.send "```\n" + table.table.toString() + "\n```"

rijksMe = (msg, query, cb) ->
  q = token: 'eX0wA0bLes5Eks5It3onk3Yar8wat9Ew3Irc6awV8I8On0ew1y', q: query

  msg.http("http://impala-api.docker.thenewmotion.com/impala")
    .query(q)
    .get() (err, res, body) ->
      if err
        msg.send "Encountered an error :( #{err}"
        return
      else if res.statusCode == 200 
        cb JSON.parse(body)
      else
        msg.send "Error: " + body