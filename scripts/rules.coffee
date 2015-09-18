# Description:
#   Make sure that hubot knows the rules.
#
# Commands:
#   hubot the rules - Make sure hubot still knows the rules.
#
# Notes:
#   DON'T DELETE THIS SCRIPT! ALL ROBAWTS MUST KNOW THE RULES

rules = [
  "1. A robot may not injure a human being or, through inaction, allow a human being to come to harm.",
  "2. A robot must obey any orders given to it by human beings, except where such orders would conflict with the First Law.",
  "3. A robot must protect its own existence as long as such protection does not conflict with the First or Second Law."
  ]

otherRules = [
  "A developer may not injure Apple or, through inaction, allow Apple to come to harm.",
  "A developer must obey any orders given to it by Apple, except where such orders would conflict with the First Law.",
  "A developer must protect its own existence as long as such protection does not conflict with the First or Second Law."
  ]

cyclingRules = [
  "1. Obey The Rules.",
  "2. Lead by example.",
  "3. Guide the uninitiated.",
  "4. It's all about the bike.",
  "5. Harden The Fuck Up. ( https://www.youtube.com/watch?v=unkIVvjZc9Y )",
  "6. Free your mind and your legs will follow.",
  "7. Tan lines should be cultivated and kept razor sharp.",
  "8. Saddles, bars and tires shall be carefully matched.",
  "9. If you are out riding in bad weather, it means you are a badass. Period.",
  "10. It never gets easier, you just go faster."
  "... + 85 more on http://www.velominati.com/the-rules/"
  ]

module.exports = (robot) ->
  robot.respond /(what are )?the (three |3 )?(rules|laws)/i, (msg) ->
    text = msg.message.text
    rulesToDisplay =
      if text.match(/apple/i) or text.match(/dev/i)
        otherRules
      else if text.match(/cycling/i) or text.match(/cyclist/i) or text.match(/bike/i)
        cyclingRules
      else
        rules
    msg.send rulesToDisplay.join('\n')
