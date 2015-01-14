# Description:
#   hubot spotify search.
#
# Dependencies:
#   None
#
# Commands:
#   hubot spotify album (me) <query> - query spotify for album
#   hubot spotify artist (me) <query> - query spotify for artist
#   hubot spotify track (me) <query> - query spotify for track
#
# Author
#   dbrooke

module.exports = (robot) ->
  robot.respond /spotify album( me)? (.*)/i, (msg) ->
    spotify robot, msg, msg.match[2], 'album', (resp) ->
      if resp.albums.items.length > 0 && resp.albums.items[0].external_urls != null
        msg.send resp.albums.items[0].external_urls.spotify
  
  robot.respond /spotify artist( me)? (.*)/i, (msg) ->
    spotify robot, msg, msg.match[2], 'artist', (resp) ->
      if resp.artists.items.length > 0 && resp.artists.items[0].external_urls != null
        msg.send resp.artists.items[0].external_urls.spotify      
  
  robot.respond /spotify track( me)? (.*)/i, (msg) ->
    spotify robot, msg, msg.match[2], 'track', (resp) ->
      if resp.tracks.items.length > 0 && resp.tracks.items[0].external_urls != null
        msg.send resp.tracks.items[0].external_urls.spotify              

spotify = (robot, msg, query, type, cb) ->
  q = q: query, type: type, limit: 1 
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