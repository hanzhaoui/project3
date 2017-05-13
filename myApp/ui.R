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
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Ozone vs. Temperature (Airquality DataSet)"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
            h3("Select Month(s)"),
            checkboxInput("mon_5", "May/5", TRUE),
            checkboxInput("mon_6", "June/6", TRUE),
            checkboxInput("mon_7", "July/7", TRUE),
            checkboxInput("mon_8", "Aug./8", TRUE),
            checkboxInput("mon_9", "Sept./9", TRUE),
            h3("Slope"),
            textOutput("slopeOut"),
            h3("Intercept"),
            textOutput("intOut")
            ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot", brush = brushOpts(id = "brush1")),
       h3("Notes:"),
       h5("This app generates the linear fit of the Ozone vs .Temperature datapoints from the airquality data set."),
       h5("You can:"),
       h5("1)Desigante the months of interest on the side panel;"),
       h5("2)Select the points of interest on the plot.")
    )
  )
))
