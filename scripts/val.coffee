# Description:
#   Helpful sentences for Dutch learners
#
# Commands:
#   hal val - Display a nice useful Dutch sentence
#   hal dronken val - Display a risqué Dutch sentence

module.exports = (robot) ->
  robot.hear /(dronken\s+)?val\s*$/i, (msg) ->
    drunk = msg.match[1]?

    sentences = if (drunk) then drunkSentences else niceSentences

    sentenceFactory = sentences[Math.floor(Math.random() * sentences.length)]
    sentence = sentenceFactory()
    msg.send "Valery zegt: \"" + sentence + "\""

niceSentences = [
  () -> "Hee mafkees, ga eens werken!",
  () -> "Het is vandaag " + currentDutchDay()]

drunkSentences = [
  () -> "Ga eens twerken of ik tuf in je koffie!",
  () -> "Als ik jullie façades hier nog eens zie, verdomde voyeurs, riskeer je zomaar geen trap voor de broek maar een vertimmerde façade"]

dutchDays = ["zondag", "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag"]

currentDutchDay = () -> dutchDays[(new Date).getDay()]
    
