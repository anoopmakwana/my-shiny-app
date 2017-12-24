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
        h4("Instructions:"),
        p("This is a Shiny application that demonstrates the impact of regularization in linear regression. User can change the regularization from the drop down menu to either Ridge or Lasso Regression. Lamda value for each regularization can also be adjusted from the slider input. Based on the selected regression, and lambda value, values of coefficient for each predictor along with RMSE is also shown. "),
        p("During Regularization, the penalties are put on the RSS of the coefficients and it is controlled by lambda. Thus, if lambda is big, we want sum of squares of the coefficients to be small, ie shrinking the coefficients towards zero"),
        p("The plot of cv shows the cross-validated MSE mean squared error as a function of log(lambda). At the start, when lambda is big, coefficients are restricted to be very small, MSE is big. Later and towards the end, when lambda is very small and coefficients are big, MSE becomes small and stays flat"),
        p(strong(em("Github repository:",a("My Shiny App",href="https://github.com/anoopmakwana/my-shiny-app"))))
    ),
    
    mainPanel(
       h4("Shrinking of coefficient"),
       fluidRow(splitLayout(cellWidths = c("65%", "30%"), plotOutput("plot1"), verbatimTextOutput("coeff"))),
       h4("Mean Squared Error Vs Lambda"),
       fluidRow(splitLayout(cellWidths = c("65%", "30%"), plotOutput("plot2")))
    )
  )
))
