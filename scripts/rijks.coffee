# Description:
#   hubot rijksmuseum query script.
#
# Dependencies:
#   None
# 
# Commands:
#   hubot rijks image me - query rijksmuseum for image
#   hubot rijks info me - query rijksmuseum for info
#   hubot rijks me - query rijksmuseum for info + image
# 
# Author
#   dbrooke

module.exports = (robot) ->
  robot.respond /rijks image( me)? (.*)/i, (msg) ->
    rijksMe msg, msg.match[2], (resp) ->
      if resp.artObjects.length > 0 && resp.artObjects[0].webImage != null
        msg.send resp.artObjects[0].webImage.url

  robot.respond /rijks info( me)? (.*)/i, (msg) ->
  	rijksMe msg, msg.match[2], (resp) ->
      if resp.artObjects.length > 0
        msg.send resp.artObjects[0].longTitle

  robot.respond /rijks( me)? (.*)/i, (msg) ->
  	rijksMe msg, msg.match[2], (resp) ->
      if resp.artObjects.length > 0
        result = resp.artObjects[0].longTitle
        if resp.artObjects[0].webImage != null
          result = result + "\n" + resp.artObjects[0].webImage.url 
      	msg.send result

rijksMe = (msg, query, cb) ->
  q = key: process.env.HUBOT_RIJKS_KEY, format: 'json', q: query.replace /;$/g, ""

  msg.http("https://www.rijksmuseum.nl/api/en/collection")
    .query(q)
    .get() (err, res, body) ->
      if err
        msg.send "Encountered an error :( #{err}"
        return
      else if res.statusCode == 200 
        cb JSON.parse(body)
      else
        msg.send "Error: " + JSON.parse(body).message  