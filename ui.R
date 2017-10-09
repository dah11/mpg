#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

shinyUI(
  pageWithSidebar(
    headerPanel("Miles per gallon prediction"),
    
    sidebarPanel(
      radioButtons(inputId="car_am", label="Transmission Type", 
                   choices=c("Automatic", "Manual")),
      numericInput('car_wt', 'Weight (lbs)', 1500, min = 0, step = 100),
      numericInput('car_hp', 'Horsepower', 200, min = 0, step = 5),
      radioButtons(inputId="x_axis", label="Chart X-Axis", 
                   choices=c("Horsepower", "Transmission", "Weight (lbs)"))
    ),
    mainPanel(
      h4('Documentation - How to use'),
      p('To begin using please select/input a value for each of the three variables transmission type, weight, and horsepower. 
        With each change the application will generate a new predicted mile per gallon rate.'),
      p('The chart is customizable, and the user can select which variable to be placed on the x-axis. The chart allows the 
        user to see invidual reactivity of miles per gallon to each variable.'),
      br(),
      h4('Expected miles per gallon'),
      verbatimTextOutput("prediction"),
      plotlyOutput("plot")
    )
  )
)