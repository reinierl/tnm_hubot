# Description:
#   hubot charge network status.
#
# Dependencies:
#   None
# 
# Commands:
#   hubot cnstatus - get cn status
# 
# Author
#   dbrooke

module.exports = (robot) ->
  robot.hear /cnstatus/i, (msg) ->
    user = "tnm";
    auth = 'Basic dG5tOmxaRzZUbElSZmNNMg==';
    msg.http("https://chargeportal.thenewmotion.com/space/tnm/online-statistics")
      .headers(Authorization: auth, Accept: 'application/json')
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            json = JSON.parse(body)
            msg.send json.total + " charge points online"