#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Impact of Legularization in Linear Regression using Hitter's dataset"),
  
  sidebarLayout(
    sidebarPanel(
        selectInput("regularization", label = h3("Select Regularization"), 
                    choices = list("Ridge" = 1, "Lasso" = 2), 
                    selected = 1),
        sliderInput("logLamda", "Log(Lamda)", min = 0, max = 15, value = 4),
        hr(),
        p(strong(em("Documentation:",a("Body Mass Index Classification in Adults",href="READMe.html")))),
        p(strong(em("Github repository:",a("Developing Data Products - Peer Assessment Project; Shiny App",href="https://github.com/CrazyFarang/DevelopingDataProducts"))))
    ),
    
    mainPanel(
       h4("Shrinking of coefficient"),
       fluidRow(splitLayout(cellWidths = c("65%", "35%"), plotOutput("plot1"), verbatimTextOutput("coeff"))),
       h4("Mean Squared Error Vs Lambda"),
       fluidRow(splitLayout(cellWidths = c("65%", "35%"), plotOutput("plot2")))
    )
  )
))
