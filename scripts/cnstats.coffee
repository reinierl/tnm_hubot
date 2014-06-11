# Description:
#   hubot charge network stats.
#
# Dependencies:
#   None
# 
# Commands:
#   hubot cn stats me - get cn status
# 
# Author
#   dbrooke

module.exports = (robot) ->
  robot.hear /cn stats?(?: me)?$/i, (msg) ->
    user = "tnm";
    auth = 'Basic dG5tOmpoK3pJQlBlX0E=';
    msg.http("https://chargeportal.thenewmotion.com/space/tnm/online-statistics")
      .headers(Authorization: auth, Accept: 'application/json')
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            json = JSON.parse(body)
            msg.send json.total + " charge points online"
          else
            msg.send "Stats not available yet :) " + res.statusCode  