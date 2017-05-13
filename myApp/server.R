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
shinyServer(function(input, output) {
        data("airquality")
        
        air <- reactive({
                m_5 <- input$mon_5
                m_6 <- input$mon_6
                m_7 <- input$mon_7
                m_8 <- input$mon_8
                m_9 <- input$mon_9
                month <- c(5, 6, 7, 8, 9)
                select <- month[c(m_5, m_6, m_7, m_8, m_9)]
                
                airquality[airquality$Month %in% select,]
        })        

          
        model <- reactive ({
                brushed_data <- brushedPoints(air(), input$brush1,
                                              xvar = "Temp", yvar = "Ozone")
                if(nrow(brushed_data) < 2){return(NULL)}
                lm(Ozone ~ Temp, brushed_data)
        })
        
        output$slopeOut <- renderText({
                if(is.null(model())){
                        "No Model Found"
                } else {
                       model()[[1]][2] 
                }
        })
        
        output$intOut <- renderText({
                if(is.null(model())){
                        "No Model Found"
                } else {
                        model()[[1]][1]
                }
        })
        
        output$distPlot <- renderPlot({
                plot(air()$Temp, air()$Ozone, xlab = "Temperature",
                     ylab = "Ozone", main = "Ozone vs Temperature", 
                     col = air()$Month, cex = 1.5, pch = 16, bty = 'n')
                if(!is.null(model())){
                        abline(model(), col="yellow", lwd=2)
                }
        })
    
})
  

