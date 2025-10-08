weather <- read.csv("weatherAUS.csv")

library("dplyr")

weather <- subset(weather, select = c("Date", "Location", "WindGustSpeed"))
weather = weather %>%
  mutate(State = case_when(
    Location %in% c("Albury", "BadgerysCreek", "Cobar", "CoffsHarbour", "Moree", 
                    "Newcastle", "NorahHead", "NorfolkIsland", "Penrith", "Richmond", 
                    "Sydney", "SydneyAirport","WaggaWagga", "Williamtown", "Wollongong") ~ "New South Wales",
    Location %in% c("Canberra", "Tuggeranong", "MountGinini") ~ "Australian Capital Territory",
    Location %in% c("Ballarat", "Bendigo", "Sale", "MelbourneAirport", "Melbourne", "Mildura",
                    "Nhil", "Portland", "Watsonia", "Dartmoor") ~ "Victoria",
    Location %in% c("Brisbane", "Cairns", "GoldCoast", "Townsville") ~ "Queensland",
    Location %in% c("Adelaide", "MountGambier", "Nuriootpa", "Woomera") ~"South Australia",
    Location %in% c("Albany", "Witchcliffe", "PearceRAAF", "PerthAirport", "Perth", 
                    "SalmonGums", "Walpole") ~ "Western Australia",
    Location %in% c("Hobart", "Launceston") ~ "Tasmania",
    Location %in% c("AliceSprings", "Darwin", "Katherine", "Uluru") ~ "Northern Territory"
  ))



weather = weather %>%
  mutate(WindCata = case_when(
    WindGustSpeed >= 125 ~ "Destructive",
    WindGustSpeed >= 90 ~ "Damaging",
    WindGustSpeed >= 63 ~ "MinorHazard",
    WindGustSpeed < 63 ~ "Safe"
  ))
weather = na.omit(weather)


maxGustByDay = function(aus_state){
dates = c()
maxGust = c()
states = c()
State_Data = weather[weather$State == aus_state,]
for (day in c(unique(State_Data$Date))) {
  dates = append(dates, day)
  states = append(states, as.character(aus_state))
  maxGust = append(maxGust, max(c(State_Data[State_Data$Date == day,]$WindGustSpeed)))
}

return(data.frame( State = states, Date = dates, WindGustSpeed = maxGust))
}

NSW_Data = maxGustByDay("New South Wales")
VIC_Data = maxGustByDay("Victoria")
ACT_Data = maxGustByDay("Australian Capital Territory")
QLD_Data = maxGustByDay("Queensland")
WA_Data = maxGustByDay("Western Australia")
SA_Data = maxGustByDay("South Australia")
TAS_Data = maxGustByDay("Tasmania")
NT_Data = maxGustByDay("Northern Territory")

weatherGusts = rbind(NSW_Data, VIC_Data, ACT_Data, QLD_Data, WA_Data, SA_Data, TAS_Data, NT_Data)

weatherGusts = weatherGusts %>%
  mutate(WindCata = case_when(
    WindGustSpeed >= 125 ~ "Destructive",
    WindGustSpeed >= 90 ~ "Damaging",
    WindGustSpeed >= 63 ~ "MinorHazard",
    WindGustSpeed < 63 ~ "Safe"
  ))


gustyDays = table(weatherGusts$State, weatherGusts$WindGustSpeed > 62)


Gusty_days = data.frame(State = c("New South Wales","Victoria", "Australian Capital Territory", "Queensland", 
                                  "Western Australia", "South Australia", "Tasmania", "Northern Territory"), gustDays = c(gustyDays[9:16,3]))
write.csv(Gusty_days, "Gusty_Days.csv")
