library(shiny)

shinyUI(fluidPage(

  titlePanel("Fuel Economy Predictor (MPG)"),

  sidebarLayout(
    sidebarPanel(
      h4("Describe your car"),
      sliderInput("wt", "Weight (in 1000 lbs):",
                  min = 1.5, max = 5.5, value = 3.2, step = 0.1),
      sliderInput("hp", "Gross horsepower:",
                  min = 50, max = 340, value = 140, step = 5),
      radioButtons("am", "Transmission:",
                   choices = c("Automatic" = 0, "Manual" = 1),
                   selected = 0, inline = TRUE),
      checkboxInput("showCI", "Show 95% prediction interval", value = TRUE),
      hr(),
      helpText("Move the sliders and pick a transmission type.",
               "The prediction updates instantly. See the 'How to use' tab for details.")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Prediction",
                 br(),
                 h3(textOutput("predText")),
                 textOutput("ciText"),
                 br(),
                 plotOutput("mpgPlot", height = "380px"),
                 p(em("Black points: the 32 cars in the mtcars data. ",
                      "Red point: your car. Lines: model fit for each transmission type, ",
                      "holding horsepower at your chosen value."))
        ),

        tabPanel("How to use",
                 br(),
                 h4("What this app does"),
                 p("It estimates the fuel economy (miles per US gallon) of a car from three",
                   "simple characteristics: its weight, its horsepower and its transmission type."),
                 h4("Getting started"),
                 tags$ol(
                   tags$li("Use the ", strong("Weight"), " slider to set the car's weight in thousands of",
                           " pounds (e.g. 3.2 = 3,200 lbs)."),
                   tags$li("Use the ", strong("Horsepower"), " slider to set engine power."),
                   tags$li("Choose ", strong("Automatic"), " or ", strong("Manual"), " transmission."),
                   tags$li("Tick or untick the checkbox to show or hide the 95% prediction interval."),
                   tags$li("Read the predicted MPG at the top of the ", strong("Prediction"),
                           " tab. The chart shows where your car sits among the cars in the data.")
                 ),
                 h4("How the prediction is calculated"),
                 p("On the server, the app fits a linear regression on R's built-in ",
                   code("mtcars"), " dataset:"),
                 pre("mpg ~ wt + hp + am"),
                 p("and calls ", code("predict()"), " with your inputs. The prediction interval",
                   " is the range in which about 95% of individual cars with these specs are expected to fall."),
                 h4("Limitations"),
                 p("The data describe 32 cars from 1973-74, so treat results as illustrative.",
                   " Values far outside the slider ranges would be extrapolation and are not allowed.")
        ),

        tabPanel("Model summary",
                 br(),
                 verbatimTextOutput("modelSummary")
        )
      )
    )
  )
))
