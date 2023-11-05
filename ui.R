#!/usr/bin/env R

fluidPage(
  titlePanel("Erforsche das Mikroklima im Jenaer Wald!"),
  p(paste(
    "Ist es im Sommer auf dem Berg wirklich kühler?",
    "Klicke auf einen Marker auf der Karte und erforsche das Mikroklima in Jena!",
    sep = "\n"
  )),
  leafletOutput("map"),
  textOutput("current_station_text"),
  p(" "),
  p(paste(
    "Die Temperatur schwankt im Tagesverlauf.",
    "Hier wird der Unterschied zwischen der höchsten und der niedrigsten Temperatur angezeigt.",
    "Typische Werte auf einem Berg über 320m befinden sich im grünen Bereich und für Orte im Tal im roten Bereich.",
    "Die dunkle Kurve zeigt die Werte der ausgewählten Stelle an.",
    sep = "\n"
  )),
  plotOutput("temp_span_plt"),
  p("Messwerte können ziemlich chaotisch sein. Deswegen werden hier erst einmal nur Durchschnittswerte angezeigt. Möchtest du trotzdem alle Werte sehen?"),
  checkboxInput("show_all_points", label = "Alle Messungen anzeigen"),
  p(" "),
  div(class = "footer", "Die Daten wurden vom Institut für Ökologie und Evolution der Friedrich-Schiller-Universität Jena erhoben.")
)