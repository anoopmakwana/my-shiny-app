#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(glmnet)
library(ISLR)

shinyServer(function(input, output, session) {
    
    Hitters <- na.omit(Hitters)
    x=model.matrix(Salary~.-1,data=Hitters) 
    #Chose only top 10 predictors for simplicity
    x = x[, c(1:10)]
    y=Hitters$Salary
    
    reg <- reactive({as.numeric(input$regularization)})
    
    fit.ridge <- reactive({
        glmnet(x, y, alpha=0)
    })
    
    cv.ridge <- reactive({
        cv.glmnet(x, y, alpha=0)
    })
    
    fit.lasso <- reactive({
        glmnet(x, y)
    })
    
    cv.lasso <- reactive({
        cv.glmnet(x, y)
    })

    output$plot1 <- renderPlot({
        if(reg() == 1) {
            plot(fit.ridge(), xvar="lambda", label=TRUE)
        }
        else {
            plot(fit.lasso(), xvar="lambda", label=TRUE)
        }
        abline(v=as.numeric(input$logLamda), col="blue", lwd=2, lty=2)
    })
    
    output$plot2 <- renderPlot({
        if(reg() == 1) {
            plot(cv.ridge(), xvar="lambda", label=TRUE)
        }
        else {
            plot(cv.lasso(), xvar="lambda", label=TRUE)
        }
        abline(v=as.numeric(input$logLamda), col="blue", lwd=2, lty=2)
    })
    
    output$coeff <- renderPrint({
        if(reg() == 1) {
            coef(cv.ridge(), s = exp(as.numeric(input$logLamda)))
        }
        
        else {
            coef(cv.lasso(), s = exp(as.numeric(input$logLamda)))
        }
    })
    
    observe({
        reg <- as.numeric(input$regularization)
        # Control the value, min, max, and step.
        if (reg == 1) {
            updateSliderInput(session, "logLamda", min = 3.5, max = 12.5, value = 4, step = 0.1)
        } else {
            updateSliderInput(session, "logLamda", min = -2.5, max = 5.5, value = 4, step = 0.1)
        }
    })
    
})
