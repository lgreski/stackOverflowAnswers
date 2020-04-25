#
# so answer
# https://stackoverflow.com/questions/61422767/how-to-download-all-sheets-in-a-google-sheet-in-r
# reference: https://googlesheets4.tidyverse.org 


library(googlesheets4)
sheets_auth()
theSheets <- sheets_find()
theSheets

pokemonData <- sheets_read(theSheets$id[1],sheet = 1)
head(pokemonData)

pokemonTypes <- sheets_read(theSheets$id[1],sheet = 2)
head(pokemonTypes)

