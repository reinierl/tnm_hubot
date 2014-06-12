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
    auth = process.env.HUBOT_TNM_SPACE_AUTH;
    msg.http("https://chargeportal.thenewmotion.com/space/tnm/online-statistics")
      .headers(Authorization: auth, Accept: 'application/json')
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            json = JSON.parse(body)

            text = if (json.total < 5000) then 'Something wrong, Dave?' else if (json.total > 10000) then 'Looking good, Dave.' else 'Bit low, Dave.'

            msg.send json.total + " charge points online.  " + text
          else
            msg.send "Stats not available yet :) " + res.statusCode  