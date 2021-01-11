#' Get posterior samples from a conjugate priors model
#' 
#' Convenience function for obtaining posterior samples 
#' from a conjugate priors model for inferring the parameters 
#' \code{mu} and \code{sigma} of a normal distribution.
#' 
#' @param data_vector vector of metric observations
#' @param nu prior on nu
#' @param var prior on the variance
#' @param mu prior on the mean
#' @param kappa prior on kappa
#' @param n_samples number of samples taken from the posterior
#' 
#' @return A tibble of associated samples.
#' @export

get_samples_single_normal_conjugate <- function(
  data_vector,
  nu        = 1,
  var       = 1,
  mu        = 0,
  kappa     = 1,
  n_samples = 1000
)
{
  n <- length(data_vector)
  aida::sample_Norm_inv_chisq(
    n_samples = n_samples,
    nu        = nu + n,
    var       = (nu * var + (n - 1) * var(data_vector) + (kappa * n)/ (kappa + n)) / (nu + n),
    mu        = kappa / (kappa + n) * mu + n / (kappa + n) * mean(data_vector),
    kappa     = kappa + n
  )
}