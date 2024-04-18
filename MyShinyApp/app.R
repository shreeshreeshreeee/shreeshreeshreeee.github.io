library(shiny) 
library(ggplot2)

ui <- fluidPage(
  titlePanel("Climate Data"),
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Select Country:",
                  choices = c("India", "China", "USA"),
                  selected = "India")
    ),
    mainPanel(
      plotOutput("linePlot")
    )
  )
)


server <- function(input, output) {
  selected_country_data <- reactive({
    switch(input$country,
           "India" = topthreedata$ind_temp,
           "China" = topthreedata$china_temp,
           "USA" = topthreedata$usa_temp)
  })
  
  output$linePlot <- renderPlot({
    selected_data <- data.frame(Date = topthreedata$dt, 
                                Temperature = selected_country_data())
    
    ggplot(data = selected_data, aes(x = Date, y = Temperature, group = 1)) +
      geom_line(color = "blue") +
      labs(x = "Year", y = "Temperature", title = paste("Average Temperature in", input$country))
  })
}

shinyApp(ui, server)

