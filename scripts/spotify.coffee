# Description:
#   hubot spotify search.
#
# Dependencies:
#   None
#
# Commands:
#   hubot spotify search <query> - query spotify for album info
#
# Author
#   dbrooke

module.exports = (robot) ->
  robot.respond /spotify( me)? (.*)/i, (msg) ->
    spotify robot, msg, msg.match[2], 'album', (resp) ->
      if resp.albums.items.length > 0 && resp.albums.items[0].external_urls != null
        msg.send resp.albums.items[0].external_urls.spotify

spotify = (robot, msg, query, type, cb) ->
  q = q: query, type: type 
  robot.logger.debug q
  msg.http("https://api.spotify.com/v1/search")
    .query(q)
    .get() (err, res, body) ->
      if err
        msg.send "Encountered an error :( #{err}"
        return
      else if res.statusCode == 200 
        cb JSON.parse(body)
      else
        msg.send "Error: " + JSON.parse(body).message  