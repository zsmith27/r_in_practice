#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
    # Application title
    titlePanel("Zach's Thesis Data"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "rank",
                    label = "Taxonomic Rank:",
                    choices = c("Order" = "order",
                                 "Family" = "family",
                                 "Genus" = "genus",
                                 "Final ID" = "final_id")),
        uiOutput("drop_taxon")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        leafletOutput("basemap")
      ) # End mainPanel
    ) # End sidebarLayout
  ) # End fluidPage
) # End shinyUI
