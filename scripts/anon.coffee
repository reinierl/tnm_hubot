# Description:
#   hubot anon.
#
# Dependencies:
#   None
# 
# Commands:
#   hubot anon <room> <message> - get buienradar map
# 
# Author
#   dbrooke

module.exports = (robot) ->
  robot.respond /anon (.*?) (.*)/i, (msg) ->
    robot.messageRoom(msg.match[1], msg.match[2]);

