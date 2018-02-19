library(shiny)
library(plotly)

shinyUI(fluidPage(
    titlePanel("Select positions"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("malePos", "Select Male Population position",
                        1, 21, value = 3),
            sliderInput("femalePos", "Select Female Population position",
                        1, 21, value = 6)
        ),
        mainPanel(
            h3("Population by age group and sex ratio"),
            plotlyOutput("plot1"),
            h2("Male Population for selected position from top"),
            textOutput("maleVal"),
            h2("Female Population for selected position from top"),
            textOutput("femaleVal")
        )
    )
))