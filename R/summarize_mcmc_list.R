#' Summarize mcmc.list objects
#' 
#' @param samples mcmc.list to summarize
#' 
#' @return tibble
#' @export

summarize_mcmc_list <- function(samples) {
    if (class(samples) == "mcmc.list") {
        ggmcmc::ggs(samples) %>% 
            dplyr::group_by(Parameter) %>%
            dplyr::summarise(
                '|95%' = HDInterval::hdi(value)[1],
                mean = mean(value),
                '95|%' = HDInterval::hdi(value)[2]
            )
    } else {
        stop("Function 'summarize_mcmc' requires an 'mcmc.list'-type object as input.")
    }
}