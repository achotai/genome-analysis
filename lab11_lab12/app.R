#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(lubridate)
library(maps)
library(mapdata)
library(wesanderson)
library(rsconnect)

### Preparing the times series data

time_series_confirmed_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")) %>%
  rename(Province_State = "Province/State", Country_Region = "Country/Region")  %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long),
               names_to = "Date", values_to = "Confirmed") 
US_time_series_confirmed_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv")) %>%
  select(-c(UID, iso2, iso3, code3, FIPS)) %>% 
  rename(Long = "Long_") %>%
  pivot_longer(-c(Admin2, Province_State, Country_Region, Lat, Long, Combined_Key),
               names_to = "Date", values_to = "Confirmed") 
# Let's get the times series data for deaths
time_series_deaths_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")) %>%
  rename(Province_State = "Province/State", Country_Region = "Country/Region")  %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long),
               names_to = "Date", values_to = "Deaths")
time_series_recovered_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")) %>%
  rename(Province_State = "Province/State", Country_Region = "Country/Region") %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long),
               names_to = "Date", values_to = "Recovered")
US_time_series_deaths_long <- read_csv(url("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv")) %>%
  select(-c(UID, iso2, iso3, code3, FIPS)) %>% 
  rename(Long = "Long_") %>%
  pivot_longer(-c(Admin2, Province_State, Country_Region, Lat, Long, Combined_Key),
               names_to = "Date", values_to = "Deaths")
# Create Keys 
time_series_confirmed_long <- time_series_confirmed_long %>% 
  unite(Key, Province_State, Country_Region, Date, sep = ".", remove = FALSE)
time_series_deaths_long <- time_series_deaths_long %>% 
  unite(Key, Province_State, Country_Region, Date, sep = ".") %>% 
  select(Key, Deaths)
time_series_recovered_long <- time_series_recovered_long %>% 
  unite(Key, Province_State, Country_Region, Date, sep = ".") %>% 
  select(Key, Recovered)
US_time_series_confirmed_long <- US_time_series_confirmed_long %>% 
  unite(Key, Combined_Key, Date, sep = ".", remove = FALSE)
US_time_series_deaths_long <- US_time_series_deaths_long %>% 
  unite(Key, Combined_Key, Date, sep = ".") %>% 
  select(Key, Deaths)
# Join tables
time_series_long_joined <- full_join(time_series_confirmed_long,
                                     time_series_deaths_long, by = c("Key"))
time_series_long_joined <- full_join(time_series_long_joined,
                                     time_series_recovered_long, by = c("Key")) %>% 
  select(-Key)
US_time_series_long_joined <- full_join(US_time_series_confirmed_long,
                                        US_time_series_deaths_long, by = c("Key")) %>% 
  select(-Key)
# Reformat the data
time_series_long_joined$Date <- mdy(time_series_long_joined$Date)
US_time_series_long_joined$Date <- mdy(US_time_series_long_joined$Date)
# Create Report table with counts
time_series_long_joined_counts <- time_series_long_joined %>% 
  pivot_longer(-c(Province_State, Country_Region, Lat, Long, Date),
               names_to = "Report_Type", values_to = "Counts")

# rename the data
global_time_series <- time_series_long_joined
US_time_series <- US_time_series_long_joined
# Get first and last date for graph ***There are NA in the date field to consider
first_date = min(global_time_series$Date, na.rm = TRUE)
last_date = max(global_time_series$Date, na.rm = TRUE)
first_date = min(US_time_series$Date, na.rm = TRUE)
last_date = max(US_time_series$Date, na.rm = TRUE)

# Define reporting types
Report_Type = c("Confirmed", "Deaths", "Recovered")

# Create list of countries
Countries = c("US","China", "Italy", "Spain", "India")

# Define UI for application 
ui <- fluidPage(
  
  # Application title
  # Exercise 1
  titlePanel("Lab 11 Exercises"),
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
                  choices = Report_Type, 
                  selected = "Confirmed"),
      # Date range
      sliderInput("dates1", label = "Report Date", min = first_date, max = last_date, value=c(first_date,last_date))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot1")
    )
  ),
  tags$hr(),
  
  # Exercise 2
  
  sidebarLayout(
    sidebarPanel(
      # Select Reporting type
      selectInput("select_type", 
                  label = "Report Type", 
                  choices = Report_Type, 
                  selected = "Confirmed"),
      # Date range
      dateRangeInput("dates2", label = "Date range", start = first_date)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot2")
    )
  ),
  tags$hr(),
  
  # Exercise 3
  
  sidebarLayout(
    sidebarPanel(
      # Select Country
      selectInput("select_country", 
                  label = "Country", 
                  choices = Countries),
      # Select Reporting type
      selectInput("select_type", 
                  label = "Report Type", 
                  choices = Report_Type, 
                  selected = "Confirmed"),
      # Date range
      dateRangeInput("dates3", label = "Date range", start = first_date)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot3")
    )
  ),
  tags$hr(),
  
  # Exercise 4
  
  sidebarLayout(
    sidebarPanel(
      # Select Reporting type
      selectInput("select_type", 
                  label = "Report Type", 
                  choices = Report_Type, selected = "Confirmed"),
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
  
  output$Plot1 <- renderPlot({
    # Graph specific code
    pick_country <- global_time_series %>% 
      group_by(Country_Region,Date) %>% 
      summarise_at(c("Confirmed", "Deaths", "Recovered"), sum) %>% 
      # Here is where we select the country
      filter (Country_Region == input$select_country)
    
    # Note that aes_strings was used to accept y input and needed to quote other variables
    ggplot(pick_country, aes_string(x = "Date",  y = input$select_type, color = "Country_Region")) + 
      geom_point() +
      geom_line() +
      # Here is where the dates are used to set limits for x-axis
      xlim(input$dates1) +
      ggtitle("Lab 11 Exercise 1:", input$select_type)
  })
  
  output$Plot2 <- renderPlot({
    # Graph specific code
    pick_country <- global_time_series %>% 
      group_by(Country_Region,Date) %>% 
      summarise_at(c("Confirmed", "Deaths", "Recovered"), sum) %>% 
      #Select Countries
      filter(Country_Region %in% c("US","India", "Italy", "Spain", "China"))
    
    # Note that aes_strings was used to accept y input and needed to quote other variables
    ggplot(pick_country, aes_string(x = "Date",  y = input$select_type, color = "Country_Region")) + 
      geom_point() +
      geom_line() +
      # Here is where the dates are used to set limits for x-axis
      xlim(input$dates2) +
      ggtitle("Lab 11 Exercise 2:", input$select_type)
  })
  
  output$Plot3 <- renderPlot({
    # Graph specific code
    pick_country <- global_time_series %>% 
      group_by(Country_Region,Date) %>% 
      summarise_at(c("Confirmed", "Deaths", "Recovered"), sum) %>% 
      # Here is where we select the country
      filter (Country_Region == input$select_country)
    
    # Note that aes_strings was used to accept y input and needed to quote other variables
    ggplot(pick_country, aes_string(x = "Date",  y = input$select_type, color = "Country_Region")) + 
      geom_point() +
      geom_line() +
      # Here is where the dates are used to set limits for x-axis
      xlim(input$dates3) +
      ggtitle("Lab 11 Exercise 3:", input$select_type)
  })
  
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
      ggtitle("Lab 11 Exercise 4:", input$select_type)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)    

