#' Get posterior samples from a non-informative priors model
#' 
#' Convenience function for obtaining posterior samples from 
#' a non-informative priors model for inferring the parameters 
#' \code{mu} and \code{sigma} of a normal distribution.
#' 
#' @param data_vector vector of metric observations
#' @param n_samples number of samples taken from the posterior
#' 
#' @return A tibble of associated samples.
#' @export

get_samples_single_noninformative <- function(data_vector, n_samples = 1000) {
  # determine sample variance
  s_squared <- var(data_vector)
  # posterior samples of the variance
  var_samples <- extraDistr::rinvchisq(
    n   = n_samples,
    nu  = length(data_vector)-1,
    tau = s_squared
  )
  # posterior samples of the mean given the sampled variance
  mu_samples <- purrr::map_dbl(
    var_samples,
    function(var) rnorm(
      n    = 1,
      mean = mean(data_vector),
      sd   = sqrt(var/length(data_vector))
    )
  )
  # return pairs of values
  tibble(
    mu    = mu_samples,
    sigma = sqrt(var_samples)
  )
}