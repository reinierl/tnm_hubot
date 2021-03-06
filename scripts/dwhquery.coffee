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
    queryMe msg, msg.match[2], (resp) ->
      json_tb = require('json-table')
      json_tb_out = new json_tb resp, { style: head: [], border: []}, (table) ->
        msg.send "```\n" + table.table.toString() + "\n```"

queryMe = (msg, query, cb) ->
  q = token: process.env.IMPALA_API_TOKEN, q: query.replace /;$/g, ""

  msg.http("http://impala-api.thenewmotion.org/impala")
    .header('Accept', 'application/json')
    .query(q)
    .get() (err, res, body) ->
      if err
        msg.send "Encountered an error :( #{err}"
        return
      else if res.statusCode == 200 
        cb JSON.parse(body)
      else
        msg.send "Error: " + body