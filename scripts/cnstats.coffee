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
  robot.hear /cn\s+stats?(\s+bomb)?(?:\s+me)?$/i, (msg) ->
    auth = process.env.HUBOT_TNM_SPACE_AUTH;
    msg.http("https://chargeportal.thenewmotion.com/space/tnm/online-statistics")
      .headers(Authorization: auth, Accept: 'application/json')
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            json = JSON.parse(body)

            datatext = message(json, msg.match[1]?)

            funnytext = if (json.total < 5000) then 'Something wrong, Dave?' else if (json.total > 11000) then 'Looking good, Dave.' else 'Bit low, Dave.'

            msg.send datatext + funnytext
          else
            msg.send "Stats not available yet :) " + res.statusCode

message = (json, terrorism) ->
  if (terrorism)
    brokenDown = (title, jsonObj) ->
      sortedItems = ({key: k, value: v} for k, v of jsonObj).sort (a,b) -> if a.value >= b.value then -1 else 1
      itemLines = (("    #{item.key}: #{item.value}") for item in sortedItems).join("\n")
      "#{title}\n#{itemLines}\n"

    "total: " + json.total + "\n" +
      "VICP: " + json.byTag.VICP + "\n" +
      brokenDown("by model:", json.byModel) +
      brokenDown("by protocol:", json.byProtocol) +
      brokenDown("by IP range:", json.byIPRange)
  else json.total + " charge points online.  "
