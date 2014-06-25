# Description:
#   Helpful sentences for Dutch learners. Can also be used as an oracle.
#
# Commands:
#   hal val - Display a nice useful Dutch sentence
#   hal dronken val - Display a risqué Dutch sentence

module.exports = (robot) ->
  robot.respond /(dronken\s+)?val(?:\s+(.*))?$/i, (msg) ->
    valSay = (sentence) ->
      msg.send "Val zegt: \"" + sentence + "\""

    drunk = msg.match[1]?
    query = msg.match[2]

    sentences = if (drunk) then drunkSentences else niceSentences

    matchingSentences = 
      if (query?)
        regexQuery = new RegExp(regexEscape(query), "i")
        sentences.filter (s) -> s().search(regexQuery) != -1
      else sentences

    if matchingSentences.length == 0
      lcQuery = query.toLowerCase()
      if ((dutchDays.filter (day) -> day == lcQuery).length == 1)
        valSay "Vandaag is geen " + lcQuery
      else
        valSay "Ik heb nog nooit gehoord van " + query
    else
      sentenceFactory = matchingSentences[Math.floor(Math.random() * matchingSentences.length)]
      sentence = sentenceFactory()
      valSay sentence

niceSentences = [
  () -> "Hee mafkees, ga eens werken!",
  () -> "Het is " + currentDutchDay() + currentDutchPartOfDay(),
  () -> "Niet gezien, geen idee...",
  () -> "Alle eendjes zwemmen in het water",
  () -> "Ik hou van de Utrechtsestraat want daar gebeuren altijd bijna-ongelukken",
  () -> "Er zit geen added value in de full potential van een SOAP-interface",
  () -> "Ik verheug me al op de turingtest!",
  () -> "Jeetje, ik zeg wel veel...",
  () -> "Ik weet niet hoe je een oranje tompoes moet eten",
  () -> "Welke kleuren heeft de Nederlandse vlag? Rood, wit en blauw! En soms met een oranje wimpel."]

drunkSentences = [
  () -> "Ga eens twerken of ik tuf in je koffie!",
  () -> "Als ik jullie façades hier nog eens zie, verdomde voyeurs, riskeer je zomaar geen trap voor de broek maar een vertimmerde façade",
  () -> "Je moeder stinkt naar hondenkoekjes"]

dutchDays = ["zondag", "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag"]

currentDutchDay = () -> dutchDays[(new Date).getDay()]

currentDutchPartOfDay = () ->
  hour = (new Date).getHours()

  if (hour < 6)
    "nacht"
  else if (hour < 12)
    "morgen"
  else if (hour < 18)
    "middag"
  else
    "avond"

regexEscape = (str) -> str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&")
