#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  sub.rec <- eventReactive(input$rank, {
    sub.df <- prep.df %>% 
      filter(rank == input$rank) %>% 
      group_by_at(vars(-percent)) %>% 
      summarize(percent = sum(percent)) %>% 
      ungroup() %>% 
      complete(taxon,
               nesting(unique_id, lake, station_id,
                       sample_number, lat, long, date, rank),
               fill = list(percent = 0))
  })
  
  output$drop_taxon <- renderUI({
    
    taxon.vec <- unique(sub.rec()$taxon)
    taxon.vec <- taxon.vec[!is.na(taxon.vec) | !taxon.vec == ""]
    
    selectInput("taxon", "Taxon:",
                choices = taxon.vec)
  })
  
  output$basemap <- renderLeaflet({
    leaflet(options = leafletOptions(maxBoundsViscosity = 1)) %>%
      addTiles(options = tileOptions(minZoom = 8, maxZoom = 18)) %>%
      setMaxBounds(lng1 = -77.00, lat1 = 42.5, lng2 = -75, lat2 = 43.5) %>%
      setView(lng = -76.0696, lat = 42.9741, zoom = 10)
  }) # End output$base_map
  
taxon.rec <- eventReactive(input$drop_taxon,{
  req(sub.rec())
  
  sub.df <- sub.rec()
  sub.df <- sub.df[sub.df$taxon %in% input$drop_taxon, ]
})
  
observeEvent(input$rank, {
   # req(taxon.rec())
   
   sub.df <- sub.rec()
   
   leafletProxy("basemap",
                data = sub.df) %>%
     clearMarkerClusters() %>%
     clearMarkers() %>%
     leaflet::addCircleMarkers(lng = sub.df$long, lat = sub.df$lat#,
                               # stroke = FALSE,
                               # color = "#3C8DBC",
                               # fillOpacity = 0.75,
                               # radius = 5,
                               # # clusterOptions = markerClusterOptions(),
                               # # label = ~as.character(seq_no),
                               # popup =  paste("<strong>Lake:</strong>", sub.df$lake, "<br/>",
                               #                "<strong>Unique ID:</strong>", sub.df$unique_id, "<br/>",
                               #                "<strong>Station ID:</strong>", sub.df$station_id, "<br/>",
                               #                "<strong>Sample Number:</strong>", sub.df$sample_number, "<br/>",
                               #                "<strong>Date:</strong>", sub.df$date, "<br/>"
                               # )
     )
 })
  
})
