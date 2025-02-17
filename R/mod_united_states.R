#' united_states UI Function
#'
#' @param id 
#'
#' @description United states panel. 
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList
mod_united_states_ui <- function(id){
  ns <- shiny::NS(id)
  includeCSS("inst/app/www/custom.css")
  tabPanel(
    "United States", 
    fluidRow(
      tags$h4(
        textOutput(
          outputId = ns("text")
        )
      ), 
      column(
        6, 
        h5(
          "Cumulative Cases per 100,000 in the United States", 
          align = 'center'
        ),
        plotly::plotlyOutput(
          outputId = ns("map_us_cases")
        )
      ), 
      column(
        6, 
        h5(
          "Cumulative Deaths per 100,000 in the United States", 
          align = 'center'
        ),
        plotly::plotlyOutput(
          outputId = ns("map_us_deaths")
        )
      )
    ), 
    fluidRow(
      h4("   By the numbers..."),
      column(
        3,
        h5("Cumulative Cases in the US (Raw Counts)", align = 'center'),
        wellPanel(
          style = "background: #6F6E81",
          h4(
            textOutput(
              outputId = ns("rawCases")
            ),
            align = 'center'
          )
        )
      ), 
      column(
        3,
        h5("Cumulative Cases\nPer 100,000 in the US", align = 'center'),
        wellPanel(
          style = "background: #6F6E81",
          h4(
            textOutput(
              outputId = ns("cumuCases")
            ),
            align = 'center'
          )
        )
      ),
      column(
        3,
        h5("Cumulative Deaths\n(Raw Counts) in the US", align = 'center'),
        wellPanel(
          style = "background: #6F6E81",
          h4(
            textOutput(
              outputId = ns("rawDeaths")
            ),
            align = 'center'
          )       
        )
      ), 
      column(
        3, 
        h5("Cumulative Deaths\nPer 100,000 in the US", align = 'center'),
        wellPanel(
          style = "background: #6F6E81",
          h4(
            textOutput(
              outputId = ns("cumuDeaths")
            ), 
            align = 'center'
          )   
        )
      )
    ), 
    fluidRow(
      wellPanel(
        style = "background: #aec3b0",
        h4("For accurate information on the COVID-19 pandemic, please visit the
            website of your local health department or government resource,
            such the CDC.", 
           align = "center"
        ),
       tags$a(
         href = "https://www.cdc.gov/coronavirus/2019-ncov/index.html", 
         tags$h4(tags$u("CDC.gov: COVID-19"), style = "color: blue"), 
         align = "center"
       ),
       h4(
         "Use the following link to find the nearest COVID-19
          vaccination provider.", 
         align = "center"
       ),
       tags$a(
         href = "https://www.vaccines.gov/", 
         tags$h4(tags$u("Vaccines.gov"), style = "color: blue"),
         align = "center"
       )
      )
    )
  )
}
    
#' united_states Server Functions
#'
#' @noRd 
mod_united_states_server <- function(id, app_data, tab){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    #----------Latest Data--------------------------
    output$text <- renderText({
      paste(
        "   COVID-19 outcomes in the US up from 2020-01-21 to",
        max(app_data$cumulative_states$date)
      )
    })
    #----------Maps for United States---------------
    map_data <- map_data_states(
      cumulative_states = app_data$cumulative_states, 
      method = "outcomes"
    )
    map_us_cases <- plotly::ggplotly(
      map_united_states(
        map_data$states_data,
        map_data$map_state, 
        method = "cases"
      )
    )
    output$map_us_cases <- plotly::renderPlotly(map_us_cases)
    map_us_deaths <- plotly::ggplotly(
      map_united_states(
        map_data$states_data, 
        map_data$map_state, 
        method = "deaths"
      )
    )
    output$map_us_deaths <- plotly::renderPlotly(map_us_deaths)
    #----------Total numbers for United States-------
    output$rawCases <- renderText({
      format(
        app_data$cumulative_US$cases,
        big.mark = ",", 
        scientific = FALSE
      )
    })
    output$cumuCases <- renderText({
      format(
        round(
          app_data$cumulative_US$caseRate,
          0
        ), 
        big.mark = ",",
        scientific = FALSE
      )
    })
    output$rawDeaths <- renderText({
      format(
        app_data$cumulative_US$deaths, 
        big.mark = ",", scientific = FALSE
      )
    })
    output$cumuDeaths <- renderText({
      format(
        round(
          app_data$cumulative_US$deathRate,
          0
        ),
        big.mark = ",",
        scientific = FALSE
      )
    })
  })
}
  