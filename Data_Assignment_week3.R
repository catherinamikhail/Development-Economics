# Use the 'survey' package. Install it if necessary
check <- require('survey')
if(!check) {
  install.packages('survey')
  library(survey)
}
rm(check)

# Use the 'readstata13' package to read Stata's data files. Install it if necessary
check <- require('readstata13')
if(!check) {
  install.packages('readstata13')
  library(readstata13)
}
rm(check)

# Read in data
# statafile <- 'u:/interim files/Tanzania 2012.dta'
statafile1 <- '~/Documents/GitHub/Development-Economics/Tanzania_2012.dta'
tzdata2012 <- read.dta13(statafile1, nonint.factors = TRUE)

# Remove any missing data
keep_cases <- !with(tzdata2012,
                    is.na(cons) | is.na(STRATUM) | is.na(CLUSTER) | is.na(hhsize) | is.na(hhweight)
)
tzdata2012 <- tzdata2012[keep_cases, ]
rm(keep_cases)

# Define new variables
tzdata2012$popwt <- with(tzdata2012, hhsize * hhweight)

# Set survey design parameters
tzdesign1 <- svydesign(
  id = ~CLUSTER,
  strata = ~STRATUM,
  weights = ~popwt,
  data = tzdata2012
)




# Use the 'survey' package. Install it if necessary
check <- require('survey')
if(!check) {
  install.packages('survey')
  library(survey)
}
rm(check)

# Use the 'readstata13' package to read Stata's data files. Install it if necessary
check <- require('readstata13')
if(!check) {
  install.packages('readstata13')
  library(readstata13)
}
rm(check)

# Read in data
# statafile <- 'u:/interim files/Tanzania 2012.dta'
statafile2 <- '~/Documents/GitHub/Development-Economics/Tanzania_2018.dta'
tzdata2018 <- read.dta13(statafile2, nonint.factors = TRUE)

# Remove any missing data
keep_cases <- !with(tzdata2018,
                    is.na(cons) | is.na(STRATUM) | is.na(CLUSTER) | is.na(hhsize) | is.na(hhweight)
)
tzdata2018 <- tzdata2018[keep_cases, ]
rm(keep_cases)

# Define new variables
tzdata2018$popwt <- with(tzdata2018, hhsize * hhweight)

# Set survey design parameters
tzdesign2 <- svydesign(
  id = ~CLUSTER,
  strata = ~STRATUM,
  weights = ~popwt,
  data = tzdata2018,
  nest = TRUE
)

