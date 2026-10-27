library(shiny)

# Fit the model once, when the app starts
data(mtcars)
fit <- lm(mpg ~ wt + hp + am, data = mtcars)

shinyServer(function(input, output) {

  # Reactive: build a one-row data frame from the user's inputs and predict
  pred <- reactive({
    newcar <- data.frame(wt = input$wt,
                         hp = input$hp,
                         am = as.numeric(input$am))
    predict(fit, newdata = newcar, interval = "prediction", level = 0.95)
  })

  output$predText <- renderText({
    sprintf("Predicted fuel economy: %.1f MPG", pred()[1, "fit"])
  })

  output$ciText <- renderText({
    if (!input$showCI) return("")
    sprintf("95%% prediction interval: %.1f to %.1f MPG",
            pred()[1, "lwr"], pred()[1, "upr"])
  })

  output$mpgPlot <- renderPlot({
    wt_grid <- seq(1.5, 5.5, by = 0.05)
    line_auto   <- predict(fit, data.frame(wt = wt_grid, hp = input$hp, am = 0))
    line_manual <- predict(fit, data.frame(wt = wt_grid, hp = input$hp, am = 1))

    plot(mtcars$wt, mtcars$mpg, pch = 19, col = "grey30",
         xlab = "Weight (1000 lbs)", ylab = "Miles per gallon",
         xlim = c(1.5, 5.5), ylim = c(0, 40),
         main = sprintf("MPG vs weight at %d hp", input$hp))
    lines(wt_grid, line_auto,   col = "steelblue",  lwd = 2)
    lines(wt_grid, line_manual, col = "darkorange", lwd = 2, lty = 2)

    if (input$showCI) {
      arrows(input$wt, pred()[1, "lwr"], input$wt, pred()[1, "upr"],
             angle = 90, code = 3, length = 0.08, col = "red", lwd = 2)
    }
    points(input$wt, pred()[1, "fit"], pch = 19, cex = 2.2, col = "red")

    legend("topright", bty = "n",
           legend = c("Automatic fit", "Manual fit", "Your car"),
           col = c("steelblue", "darkorange", "red"),
           lty = c(1, 2, NA), pch = c(NA, NA, 19), lwd = 2)
  })

  output$modelSummary <- renderPrint({
    summary(fit)
  })
})
