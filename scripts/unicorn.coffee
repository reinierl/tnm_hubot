# Description:
#   Unicornify
#
# Dependencies:
#   md5
# 
# Commands:
#   hubot unicorn me <email> - Create unicorn avatar for email
# 
# Author
#   dbrooke

md5 = require('md5')

module.exports = (robot) ->
  robot.respond /unicorn( me)? (.*)/i, (msg) ->
    msg.send "http://unicornify.appspot.com/avatar/" + md5(msg.match[2])