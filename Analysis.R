library(dplyr)
# Read names
names <- read.csv("ITA-Names.csv", stringsAsFactors = FALSE)

# How many unique names in a sample of x academics?
for_random <- matrix(0, 1000, nrow(names))
for (i in 1:nrow(for_random)) for_random[i,] <- cumsum(!duplicated(sample(names$Last)))

# Read the input
sectors <- read.csv("Input.csv")

# Calculate expected number of people
sectors$Expected_people <- rep(NA, nrow(sectors))
for (i in 1:nrow(sectors)){
  num_names <- sectors$Names[i]
  tmp <- apply(for_random, 1, function(x) which(x == num_names)[1])
  sectors$Expected_people[i] <- mean(tmp)
  print(sectors[i,])
}

sectors$Excess_people <- sectors$People - sectors$Expected_people

#Save output
write.csv(sectors, file = "Output.csv", row.names = FALSE)
