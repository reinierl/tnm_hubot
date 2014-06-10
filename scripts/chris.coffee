# Description:
#   Chris sneeze
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot sneeze like chris
#
# Author:
#   dbrooke

module.exports = (robot) ->
  robot.respond /sneeze like Chris/i, (msg) ->
    msg
      .http("http://asciime.heroku.com/generate_ascii")
      .query(s: "Achooooo!")
      .get() (err, res, body) ->
        msg.send body
