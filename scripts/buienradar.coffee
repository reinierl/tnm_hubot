# Description:
#   hubot buienradar.
#
# Dependencies:
#   None
# 
# Commands:
#   hubot buienradar - get buienradar map
# 
# Author
#   dbrooke

module.exports = (robot) ->
  robot.respond /buienradar/i, (msg) ->
    msg.send "http://gratisweerdata.buienradar.nl/buienradar.php?type=256x256"

