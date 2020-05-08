#' Summarize single vector of samples (lower/upper 95% Credible Interval & mean)
#' 
#' @param samples numeric vector of samples
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