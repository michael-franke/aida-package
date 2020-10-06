#' Roughly 2000 trials of a mousetracking experiment.
#'
#' A dataset of 2052 trials of an eperiment conducted by
#' A and B (year) for which particuipants had to classify
#' specific animals to broader categories.
#' The dataset contains response times, MAD, AUC and
#' other attributes as well as all experimental conditions.
#' 
#' Since most variables should be self-explanatory, only
#' the less obvious are explained here.
#'
#' @format A data frame with 2052 rows and 16 variables:
#' \describe{
#'   \item{MAD}{Maximum Absolute Deviation of the pointer 
#'   to an ideal line from starting point to the target. 
#'   Positive if above the line, negative if below.}
#'   \item{AUC}{Area Under the Curve; the geometric area 
#'   between the actual trajectory and the direct path 
#'   where areas below the direct path have been subtracted}
#'   \item{xpos_flips}{Number of directional changes 
#'   along x-axis.}
#'   \item{prototype_label}{Trajectorial prototype as 
#'   described by Wulff et al, 2019.}
#' }
#' @source usually a \url{}, but I'm unsure in this case
"mousetrack_typicality"