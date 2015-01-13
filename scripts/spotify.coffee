# Description:
#   hubot spotify search.
#
# Dependencies:
#   None
#
# Commands:
#   hubot spotify artist <query> - query spotify for album info
#
# Author
#   dbrooke

module.exports = (robot) ->
  robot.respond /spotify search album (.*)/i, (msg) ->
    spotify robot, msg, msg.match[1], 'album', (resp) ->
      if resp.albums.items.length > 0 && resp.albums.items[0].external_urls != null
        msg.send resp.albums.items[0].external_urls.spotify

spotify = (robot, msg, query, type, cb) ->
  q = q: query, type: type 
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