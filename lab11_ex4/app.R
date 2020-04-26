#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Exercise 4
# Running the libraries
library(shiny)
library(tidyverse)
library(lubridate)
library(maps)
library(mapdata)
library(wesanderson)
library(rsconnect)

### Preparing the times series data

US_time_series_confirmed_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv")) %>%
  select(-c(UID, iso2, iso3, code3, FIPS)) %>% 
  rename(Long = "Long_") %>%
  pivot_longer(-c(Admin2, Province_State, Country_Region, Lat, Long, Combined_Key),
               names_to = "Date", values_to = "Confirmed") 

# Let's get the times series data for deaths
US_time_series_deaths_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv")) %>%
  select(-c(UID, iso2, iso3, code3, FIPS)) %>% 
  rename(Long = "Long_") %>%
  pivot_longer(-c(Admin2, Province_State, Country_Region, Lat, Long, Combined_Key),
               names_to = "Date", values_to = "Deaths")
# Create Keys 
US_time_series_confirmed_long <- US_time_series_confirmed_long %>% 
  unite(Key, Combined_Key, Date, sep = ".", remove = FALSE)
US_time_series_deaths_long <- US_time_series_deaths_long %>% 
  unite(Key, Combined_Key, Date, sep = ".") %>% 
  select(Key, Deaths)

# Join tables
US_time_series_long_joined <- full_join(US_time_series_confirmed_long,
                                        US_time_series_deaths_long, by = c("Key")) %>% 
  select(-Key)

# Reformat the data
US_time_series_long_joined$Date <- mdy(US_time_series_long_joined$Date)

# Rename
US_time_series <- US_time_series_long_joined

# Get first and last date for graph ***There are NA in the date field to consider
first_date = min(US_time_series$Date, na.rm = TRUE)
last_date = max(US_time_series$Date, na.rm = TRUE)

# Defining reporting types
Report_Type4 = c("Confirmed", "Deaths")

# Define UI for application 
ui <- fluidPage(
  
  # Application title
  titlePanel("US Time Series Data by State"),
  p("Data for this application are from the Johns Hopkins Center for Systems Science and Engineering",
    tags$a("GitHub Repository", href="https://github.com/CSSEGISandData")
  ),
  tags$br(),
  tags$hr(),  # Adds line to page
  
  sidebarLayout(
    sidebarPanel(
      # Select Reporting type
      selectInput("select_type", 
                  label = "Report Type", 
                  choices = Report_Type4, selected = "Confirmed"),
      # Select Date 
      sliderInput("slider_date", label = "Report Date", min = first_date, 
                  max = last_date, value = first_date, step = 7)
    ),
    
    # Show a plots
    mainPanel(
      plotOutput("Plot4")
    )
  )
)

# Define server logic required to make the plot
server <- function(input, output) {
  
  output$Plot4 <- renderPlot({
    # develop data set to graph
    pick_date <- US_time_series %>% 
      # Fix mapping to map_data of US != USA  
      mutate(Country_Region = recode(Country_Region, US = "USA")) %>% 
      # *** This is where the slider input with the date goes
      filter(Date == input$slider_date) %>% 
      group_by(Province_State) %>% 
      summarise_at(c("Confirmed", "Deaths"), sum)%>%
      mutate(Province_State = tolower(Province_State))
    
    
    # load the world map data
    US <- map_data("state")
    
    # We need to join the us map data with our daily report to make one data frame/tibble
    county_join <- left_join(US, pick_date, by = c("region"="Province_State"))
    
    
    
    # plot world map
    ggplot(data = US, mapping = aes(x = long, y = lat, group = group)) + 
      coord_fixed(1.5) + 
      # Add data layer
      borders("state", colour = "black") +
      geom_polygon(data = county_join, aes_string(fill = input$select_type), color = "black") +
      scale_fill_gradientn(colours = 
                             wes_palette("Zissou1", 100, type = "continuous"),
                           trans = "log10") +
      ggtitle("JHU COVID-19 data for the US:", input$select_type)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
