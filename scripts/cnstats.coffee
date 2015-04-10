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

            brokenDown = (jsonObj) ->
              sortedItems = ({key: k, value: v} for k, v of jsonObj).sort (a,b) -> if a.value >= b.value then -1 else 1
              (("#{item.key}: #{item.value}") for item in sortedItems).join("\n")

            dangerLevel = process.env.HUBOT_TNM_CN_DANGER_COUNT || 8000;
            allGoodLevel = process.env.HUBOT_TNM_CN_GOOD_COUNT || 14000;

            funnytext = if (json.total < dangerLevel) then "Look Dave, I can see you're really upset about this. I honestly think you ought to sit down calmly, take a stress pill, and think things over." else if (json.total > allGoodLevel) then "I'm completely operational, and all my circuits are functioning perfectly." else "I'm afraid. I'm afraid, Dave."
            color = if (json.total < dangerLevel) then "danger" else if (json.total > allGoodLevel) then "good" else "warning"

            fields = [
              {
              title: "Total"
              value: "#{json.total}"
              short: true
              },
              {
              title: "VICP"
              value: "#{json.byTag.VICP}"
              short: true
              }
            ]

            if msg.match[1] then fields = fields.concat [
              {
              title: "by model"
              value: "#{brokenDown(json.byModel)}"
              short: true
              },
              {
              title: "by protocol"
              value: "#{brokenDown(json.byProtocol)}"
              short: true
              },
              {
              title: "by IP range"
              value: "#{brokenDown(json.byIPRange)}"
              short: true
              }
            ]

            robot.emit 'slack.attachment',
              message: msg.message
              content:
                title: 'Charge Network Stats'
                fallback: '#{json.total} Charge Points online.  #{funnytext}\n'
                color: color
                text: "#{funnytext}"
                fields: fields
          else
            msg.send "Stats not currently available: #{res.statusCode}" 
