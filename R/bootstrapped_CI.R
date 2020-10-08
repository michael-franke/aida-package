#' Perform bootstrapping on variable
#' 
#' Takes a numeric input, performs bootstrapping with a given number of resamples, 
#' computes 95\% Confidence Interval and returns a tibble with input mean and 
#' bootstrapped CI.
#'
#' @param data_vector observed data to sample from
#' @param n_resamples number of resamples to take
#'
#' @return A tibble containing mean of input and 95\% CI
#' @importFrom stats quantile
#' @export
bootstrapped_CI <-  function(data_vector, n_resamples = 1000) {
    resampled_means <- purrr::map_dbl(seq(n_resamples), function(i) {
        mean(sample(x = data_vector, 
                    size = length(data_vector), 
                    replace = T)
        )
    }
    
    )
    dplyr::tibble(
        'lower' = quantile(resampled_means, 0.025),
        'mean'  = mean(data_vector),
        'upper' = quantile(resampled_means, 0.975)
    ) 
}
