library(shiny)
library(plotly)
library(DT)
library(colourpicker)

mobility <- read.csv("mobility_data.csv", sep = ';')  #dataset <- load("./gen/analysis/input/complete_dataset.RData"
mobility$Date <- as.Date(mobility$Date)               # this line can be deleted, date is already as.date in the data set and date is probably not necessary
mobility$Province <- as.factor(mobility$Province)   # Don't really know what this does


ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            h2("Bol/Amazon comparison"),
            selectInput(inputId = "dv", label = "Brand",
                        choices = c("Retail_Recreation", "Grocery_Pharmarcy", "Parks", "Transit_Stations", "Workplaces", "Residential"),  #change the row names "site", "title", "brand", "model", "price", "reviews", "star_rating"
                        selected = "Grocery_Pharmarcy"),
            selectInput(inputId = "provinces", "Province(s)",
                        choices = levels(mobility$Province),
                        multiple = TRUE,
                        selected = c("Utrecht", "Friesland", "Zeeland")),
            dateRangeInput(inputId = "date", "Date range",                       # Date range not necessary.
                           start = min(mobility$Date),
                           end   = max(mobility$Date)),
            downloadButton(outputId = "download_data", label = "Download"), 
        ),
        mainPanel(
            plotlyOutput(outputId = "plot"), br(),
            em("Postive and negative percentages indicate an increase and decrease from the baseline period (median value between January 3 and February 6, 2020) respectively."),
            br(), br(), br(),
            DT::dataTableOutput(outputId = "table")
        )
    )
)

server <- function(input, output) {
    filtered_data <- reactive({
        subset(mobility,
               Province %in% input$provinces &
                   Date >= input$date[1] & Date <= input$date[2])})
    
    output$plot <- renderPlotly({
        ggplotly({
            p <- ggplot(filtered_data(), aes_string(x="Date", y=input$dv, color="Province")) +
                geom_point(alpha=0.5) + theme(legend.position = "none") + 
                ylab("% change from baseline") 
            
            p
        })
    })
    
    output$table <- DT::renderDataTable({
        filtered_data()
    })
    
    output$download_data <- downloadHandler(
        filename = "download_data.csv",
        content = function(file) {
            data <- filtered_data()
            write.csv(data, file, row.names = FALSE)
        }
    )
    
}

shinyApp(ui = ui, server = server)
