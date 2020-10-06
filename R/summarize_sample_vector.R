#' Summarize single vector of samples 
#' 
#' ...and their lower/upper 95\% Credible Interval & mean
#' 
#' @param samples numeric vector of samples
#' @param name the name of the summarized parameter
#' 
#' @return tibble
#' @export
summarize_sample_vector <- function(samples, name = '') {
    tibble(
        Parameter = name,
        '|95%' = HDInterval::hdi(samples)[1],
        mean  = mean(samples),
        '95%|' = HDInterval::hdi(samples)[2]
    )
}