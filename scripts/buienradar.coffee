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
    msg.send "http://www.buienradar.nl/images.aspx?jaar=-3&soort=sp-loop"

