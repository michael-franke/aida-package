#' Get samples from the ‘normal inverse-chi^2' prior
#' 
#' Convenience function for sampling from the prior 
#' distribution over \code{mu} and \code{sigma}.
#' 
#' @param n_samples number of samples taken from the prior
#' @param nu prior on nu
#' @param var prior on the variance
#' @param mu prior on the mean
#' @param kappa prior on kappa
#' 
#' @return A tibble of associated samples.
#' @export

sample_Norm_inv_chisq <- function(
    n_samples = 10000,
    nu        = 1,
    var       = 1,
    mu        = 0,
    kappa     = 1
)
{
    var_samples <- extraDistr::rinvchisq(
        n   = n_samples,
        nu  = nu,
        tau = var
    )
    mu_samples <- purrr::map_dbl(
        var_samples,
        function(s) rnorm(
            n    = 1,
            mean = mu,
            sd   = sqrt(s/kappa)
        )
    )
    tibble(
        sigma = sqrt(var_samples),
        mu    = mu_samples
    )
}