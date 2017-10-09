get_predict <- function(in_am, in_wt, in_hp) {

  model <- lm(formula = mpg ~ factor(am) + wt + hp, data = mtcars)
  
  if (in_am == "Automatic") {
    trans_num = 0
  }
  else {
    trans_num = 1
  }  
  p_mpg <- data.frame(predict(model, data.frame(am=trans_num,wt=(in_wt/1000),hp=in_hp)))[1,1]
  
  return(paste(round(p_mpg,2),'miles per gallon'))
}


get_chart <- function(x_axis) {
  if (x_axis == 'Horsepower') {
    p <- plot_ly(mtcars, x = ~hp) %>%
      add_markers(y = ~mpg, name="mpg") %>%
      add_lines(y = ~fitted(loess(mpg ~ hp)),
                line = list(color = 'rgba(7, 164, 181, 1)'),
                name = "Loess Smoother") %>%
      layout(xaxis = list(title = 'Horsepower'),
             yaxis = list(title = 'Miles per gallon'))
  }
  else if (x_axis == 'Weight (lbs)') {
    p <- plot_ly(mtcars, x = ~wt) %>%
      add_markers(y = ~mpg, name="mpg") %>%
      add_lines(y = ~fitted(loess(mpg ~ wt)),
                line = list(color = 'rgba(7, 164, 181, 1)'),
                name = "Loess Smoother") %>%
      layout(xaxis = list(title = 'Weight (lbs)'),
             yaxis = list(title = 'Miles per gallon'))
  }
  else {
    mtcars <- mutate(mtcars, trans = ifelse(am == 0, "Automatic", "Manual"))    
    p <- plot_ly(mtcars, x = ~trans, y = ~mpg, type= "bar") %>%
      layout(xaxis = list(title = 'Transmission Type'),
             yaxis = list(title = 'Miles per gallon'))
  }
  
  return(p)
}

shinyServer(
  function(input, output) {

    output$prediction <- renderPrint({get_predict(input$car_am, input$car_wt, input$car_hp)})
    
    output$plot <- renderPlotly({
      get_chart(input$x_axis)
    })
    
  }
)