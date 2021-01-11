#' Roughly 2000 trials of a mouse-tracking experiment
#'
#' A preprocessed data set from an experiment conducted by 
#' Kieslich et al. (2020) in which participants classified 
#' specific animals into broader categories.
#' The data set contains response times, MAD, AUC and other 
#' attributes as well as all experimental conditions.
#'
#' @references 
#' Kieslich, P.J., Schoemann, M., Grage, T., et al. (2020). 
#' Design factors in mouse-tracking: What makes a difference?. 
#' Behavior Research Methods 52, 317-341. 
#'
#' @format A data frame with 2052 rows and 16 variables.
#' Since most variables should be self-explanatory, only
#' the less obvious are explained here.
#' \describe{
#'   \item{condition}{Whether the exemplar is typical for 
#'   its response category (e.g. dog for a mammal) or 
#'   atypical for its response category (e.g. bat for a 
#'   mammal, sharing features with both mammals and birds).}
#'   \item{group}{Whether the response was triggered by
#'   clicking the response button or moving the
#'   cursor into the area of the response button.}
#'   \item{MAD}{Maximum Absolute Deviation of the pointer 
#'   to an ideal line from starting point to the target. 
#'   Positive if above the line, negative if below.}
#'   \item{AUC}{Area Under the Curve; the geometric area 
#'   between the actual trajectory and the direct path 
#'   where areas below the direct path have been subtracted}
#'   \item{xpos_flips}{Number of directional changes 
#'   along x-axis.}
#'   \item{prototype_label}{Trajectorial prototype as 
#'   described by Wulff et al. (2019).}
#' }
#' @source \url{https://osf.io/7vrkz/}
"data_MT"

#' Mental Chronometry
#'
#' @description This data set is from an online experiment 
#' investigating differences in reaction times and accuracy 
#' in solving three tasks of increasing complexity.
#'  
#' @format A data frame with 3750 rows and 32 variables. 
#' The most important variables in this data set are:
#' \describe{
#'   \item{submission_id}{A unique identifier for each participant.}
#'   \item{RT}{The reaction time for each trial.}
#'   \item{response}{Response to the presented stimulus in the 
#'   reaction or go/no-go condition.}
#'   \item{key_pressed}{The key that was pressed in the discrimination 
#'   condition (f or j).}
#'   \item{trial_type}{The condition (reaction, go/no-go, discrimination), 
#'   as well as whether it was a practice or main trial.}
#'   \item{stimulus}{The stimulus displayed on the screen; either a 
#'   blue circle or a blue square.}
#' }
#' 
#' @source \url{https://raw.githubusercontent.com/michael-franke/intro-data-analysis/master/data_sets/mental-chrono-data_raw.csv}
#' 
#' @seealso 
#' \code{data_MC_preprocessed} for a preprocessed version of this data set.
#' 
#' \code{data_MC_cleaned} for a cleaned version of this data set.
#' 
#' \href{https://michael-franke.github.io/intro-data-analysis/app-93-data-sets-mental-chronometry.html}{The web-book chapter that covers the MC data set}.
"data_MC_raw"

#' Simon Task
#'
#' @description This data set is from an online experiment 
#' in which participants classified a shape presented on the 
#' screen as a square or circle. The shape was displayed on 
#' either the left or right side of the screen.
#'
#' @format A data frame with 25560 rows and 15 variables.
#' The most important variables in this data set are:
#' \describe{
#'   \item{submission_id}{A unique identifier for each participant.}
#'   \item{RT}{The reaction time for each trial.}
#'   \item{condition}{Whether the trial was a congruent or 
#'   an incongruent trial.}
#'   \item{correctness}{Whether the answer in the current 
#'   trial was correct or incorrect.}
#'   \item{trial_type}{Whether the data is from a practice 
#'   or a main test trial.}
#' }
#' 
#' @source \url{https://raw.githubusercontent.com/michael-franke/intro-data-analysis/master/data_sets/simon-task.csv}
#' 
#' @seealso 
#' \code{data_ST} for a cleaned version of this data set. 
#' 
#' \href{https://michael-franke.github.io/intro-data-analysis/app-93-data-sets-simon-task.html}{The web-book chapter that covers the Simon Task data set}.
"data_ST_raw"

#' King of France
#'  
#' @description This data set is from an online experiment 
#' in which participants made truth-value judgements of 
#' sentences with a false presupposition. 
#' 
#' @format A data frame with 2813 rows and 16 variables.
#' The most important variables in this data set are:
#' \describe{
#'   \item{submission_id}{A unique identifier for each participant.}
#'   \item{trial_type}{Whether the trial was of the category 
#'   filler, main, practice or special, where the latter encodes 
#'   the “background checks”.}
#'   \item{item_version}{The condition to which the test sentence 
#'   belongs (only given for trials of type main and special).}
#'   \item{response}{The answer (“TRUE” or “FALSE”) in each trial.}
#'   \item{vignette}{The current item’s vignette number (applies 
#'   only to trials of type main and special).}
#' }
#' 
#' @source \url{https://raw.githubusercontent.com/michael-franke/intro-data-analysis/master/data_sets/king-of-france_data_raw.csv}
#' 
#' @seealso 
#' \code{data_KoF_preprocessed} for a preprocessed version of this data set.
#' 
#' \code{data_KoF_cleaned} for a cleaned version of this data set.
#' 
#' \href{https://michael-franke.github.io/intro-data-analysis/app-93-data-sets-king-of-france.html}{The web-book chapter that covers the KoF data set}.
"data_KoF_raw"

#' Bio-Logic Jazz-Metal
#'  
#' @description This data set is from a very short and 
#' non-serious online experiment that asked for just three 
#' binary decisions from each participant, namely their 
#' spontaneous preference for one of two presented options 
#' (biology vs. logic, jazz vs. metal, and mountains vs. beach). 
#'
#' @format A data frame with 306 rows and 19 variables.
#' The most important variables in this data set are:
#' \describe{
#'   \item{submission_id}{A unique identifier for each participant.}
#'   \item{option 1}{What the choice options were.}
#'   \item{option 2}{What the choice options were.}
#'   \item{response}{Which of the two options was chosen.}
#' }
#' 
#' @source \url{https://raw.githubusercontent.com/michael-franke/intro-data-analysis/master/data_sets/bio-logic-jazz-metal-data-raw.csv}
#' 
#' @seealso 
#' \code{data_BLJM} for a preprocessed version of this 
#' data set.
#' 
#' \href{https://michael-franke.github.io/intro-data-analysis/app-93-data-sets-BLJM.html}{The web-book chapter that covers the BLJM data set}.
"data_BLJM_raw"

#' Avocado prices
#'  
#' @description This data set was downloaded from 
#' \href{https://www.kaggle.com/}{Kaggle}. It includes 
#' information about the prices of (Hass) avocados and 
#' the amount sold (of different kinds) at different 
#' points in time.
#' 
#' @format A data frame with 18249 rows and 14 variables.
#' The most important variables in this data set are:
#' \describe{
#'   \item{Date}{Date of the observation.}
#'   \item{AveragePrice}{Average price of a single avocado.}
#'   \item{Total Volume}{Total number of avocados sold.}
#'   \item{type}{Whether the price/amount is for conventional 
#'   or organic avocados.}
#'   \item{4046}{Total number of small avocados sold (PLU 4046).}
#'   \item{4225}{Total number of medium avocados sold (PLU 4225).}
#'   \item{4770}{Total number of large avocados sold (PLU 4770).}
#' }
#' 
#' @source \url{https://www.kaggle.com/neuromusic/avocado-prices}
#' 
#' @seealso 
#' \code{data_avocado} for a preprocessed version of this data set.
#'  
#' \href{https://michael-franke.github.io/intro-data-analysis/app-93-data-sets-avocado.html}{The web-book chapter that covers the Avocado data set}.
"data_avocado_raw"

#' Annual average world temperature
#'  
#' @description This data set was downloaded from 
#' \href{http://berkeleyearth.org/}{Berkeley Earth} on 
#' October 6th, 2020. Specifically, it contains the time 
#' series data for “land only” using the annual summary 
#' of monthly average temperature. We have added to the 
#' data set used here the absolute average temperature. 
#' (Berkeley Earth only lists the “annual anomaly”, i.e., 
#' the deviation from a grand mean.)
#'
#' @format A data frame with 269 rows and 4 variables.
#' \describe{
#'   \item{year}{Year of the observation (1750-2019).}
#'   \item{anomaly}{Deviation from the grand mean of 
#'   1750-1980, which equals 8.61 degrees Celcius.}
#'   \item{uncertainty}{Measure of uncertainty associated 
#'   with the reported anomaly.}
#'   \item{avg_temp}{The annual average world surface 
#'   temperature.}
#' }
#' 
#' @source \url{https://raw.githubusercontent.com/michael-franke/intro-data-analysis/master/data_sets/average-world-temperature.csv}
#' 
#' @seealso 
#' \href{http://berkeleyearth.org/data-new/}{The origin and composition of this data set}.
#' 
#' \href{https://michael-franke.github.io/intro-data-analysis/app-93-data-sets-temperature.html}{The web-book chapter that covers the World Temperature data set}.
"data_WorldTemp"

#' Murder data - fictitious
#'  
#' @description The murder data set contains information 
#' about the relative number of murders in American cities. 
#' It also contains further socio-economic information, such 
#' as a city’s unemployment rate, and the percentage of 
#' inhabitants with a low income. This data set should only 
#' be used for illustration. No further real-world conclusions 
#' should be drawn from the data, as it is entirely fictitious.
#' 
#' @format A data frame with 20 rows and 4 variables. Each row 
#' in this data set shows data from a city. The variables are:
#' \describe{
#'   \item{murder_rate}{Annual murder rate per million inhabitants.}
#'   \item{low_income}{Percentage of inhabitants with a low income 
#'   (however that is defined).}
#'   \item{unemployment}{Percentage of unemployed inhabitants.}
#'   \item{population}{Number of inhabitants of a city.}
#' }
#' 
#' @source \url{https://raw.githubusercontent.com/michael-franke/intro-data-analysis/master/data_sets/murder_rates.csv}
#' 
#' @seealso \href{https://michael-franke.github.io/intro-data-analysis/app-93-data-sets-murder-data.html}{The web-book chapter that covers the Murder data set}.
"data_murder"

#' Politeness data
#'  
#' @description This data set is a preprocessed and shortened
#' version of the data provided by Winter and Grawunder (2012). 
#' The data set includes voice pitch of male and female Korean 
#' speakers in both polite and informal linguistic contexts.
#' 
#' @references 
#' Winter, B., Grawunder, S. (2012). 
#' The phonetic profile of Korean formality. 
#' Journal of Phonetics, 40, 808-815.
#' 
#' @format A data frame with 83 rows and 5 variables:
#' \describe{
#'   \item{subject}{A unique identifier for each participant.}
#'   \item{gender}{An indicator of each participants gender 
#'   (only binary).}
#'   \item{sentence}{An indicator of the sentence spoken by 
#'   the participant.}
#'   \item{context}{The main manipulation of whether the context 
#'   was a “polite” or “informal” setting.}
#'   \item{pitch}{The measured voice pitch (presumably: average 
#'   over the sentence spoken).}
#' }
#' 
#' @source \url{https://raw.githubusercontent.com/michael-franke/intro-data-analysis/master/data_sets/politeness_data.csv}
"data_polite"