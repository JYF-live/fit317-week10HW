setwd("C:/Users/RadiumPCs/Desktop/Uni")
vgsales <- read.csv("vgsales.csv")
vgsar <- read.csv("vgsar.csv")
library(dplyr)
vgsales <- vgsales %>%
  mutate(Type = case_when(
    Platform %in% c("Wii", "NES","X360", "PS3",  "PS2",  "SNES","PS4",  "N64",  "PS",   "XB",  "2600", "XOne",
                     "GC",   "WiiU", "GEN",  "DC",  "SAT",  "SCD", "TG16", "3DO" ) ~ "Home",
    Platform %in% c("GB",  "DS", "GBA",  "3DS", "PSP", "PSV", "WS",   "NG", "GG") ~ "Handheld",
    Platform %in% c("PC", "TG16", "PCFX") ~ "Other",
    TRUE ~ NA
  ))

vgsales <- vgsales %>%
  mutate(Genre = case_when(
    Genre %in% c("Simulation", "Platform", "Misc") ~ "Misc",
    Genre %in% c("Racing", "Sports") ~ "Sports",
    Genre %in% c("Fighting", "Adventure", "Shooter", "Action") ~ "Action",
    Genre %in% c("Strategy", "Puzzle") ~ "Puzzle",
    Genre %in% c("Role-Playing") ~ "Role-Playing"
    
  ))

platform_list <- c(unique(vgsales$Platform))
genre_list <- c(unique(vgsales$Genre))
count_misc = c()
count_sports = c()
count_act = c()
count_puz = c()
count_rp = c()
for (i in 1:length(platform_list)) {
  count_misc <- append(count_misc, nrow(vgsales[vgsales$Genre == "Misc" & vgsales$Platform == platform_list[i],]))
  count_sports <- append(count_sports, nrow(vgsales[vgsales$Genre == "Sports" & vgsales$Platform == platform_list[i],]))
  count_act <- append(count_act, nrow(vgsales[vgsales$Genre == "Action" & vgsales$Platform == platform_list[i],]))
  count_puz <- append(count_puz, nrow(vgsales[vgsales$Genre == "Puzzle" & vgsales$Platform == platform_list[i],]))
  count_rp <- append(count_rp, nrow(vgsales[vgsales$Genre == "Role-Playing" & vgsales$Platform == platform_list[i],]))
}

vgsar$Count.Misc = count_misc
vgsar$Count.Sports = count_sports
vgsar$Count.Action = count_act
vgsar$Count.Puzzle = count_puz
vgsar$Count.RP = count_rp
