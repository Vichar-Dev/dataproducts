library(shiny)
library(plotly)
library(dplyr)

shinyServer(function(input, output) {
    
    population <- read.csv("pop_India.csv",stringsAsFactors = FALSE)
    
    population$Male.Population<-gsub(",","",population$Male.Population)
    population$Male.Population<-as.numeric(as.character(population$Male.Population))
    population$Female.Population<-gsub(",","",population$Female.Population)
    population$Female.Population<-as.numeric(as.character(population$Female.Population))
    
    maleIndex <- reactive({
        malePos <- input$malePos
        match(nth(population$Male.Population[order(-population$Male.Population)],malePos),population$Male.Population)
    })
    
    femaleIndex <- reactive({
        femalePos <- input$femalePos
        match(nth(population$Female.Population[order(-population$Female.Population)],femalePos),population$Female.Population)
    })
    
    output$plot1 <- renderPlotly({
        red <-'rgba(122,5,18,0.8)'
        maleColor <- 'rgba(204,204,204,1)'
        femaleColor <- 'rgba(224,204,214,1)'
        
        colorMale <- rep(maleColor,21)
        colorFemale <- rep(femaleColor,21)
        
        colorMale[maleIndex()] <- red
        colorFemale[femaleIndex()] <- red
        
        plot_ly(population, x = ~Age, y = ~Male...., type = 'bar', name = 'Males Percentage',marker = list(color =colorMale)) %>%
            add_trace(y = ~Female...., name = 'Females Percentage', marker = list(color =colorFemale)) %>%
            layout(yaxis = list(title = 'Sex Ratio'), barmode = 'group') %>%
            layout(xaxis = list(type = "category"))
    })
    
    output$maleVal <- renderText({
        population$Male.Population[maleIndex()]
        })
    output$femaleVal <- renderText({
        population$Female.Population[femaleIndex()]
        })
})