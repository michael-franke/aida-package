#' Get posterior samples from a non-informative priors regression model
#' 
#' Convenience function for obtaining posterior samples from a 
#' non-informative priors linear regression model for inferring 
#' the parameters \code{intercept}, \code{slope} and \code{sigma}.
#'
#' @param X design matrix
#' @param y dependent variable
#' @param n_samples number of samples taken from the posterior
#' 
#' @return A tibble of sample triplets.
#' @export

get_samples_regression_noninformative <- function(
  X, # design matrix
  y, # dependent variable
  n_samples = 1000
)
{
  n <- length(y)
  k <- ncol(X)
  
  # calculating the formula from Gelman et al
  # NB 'solve' computes the inverse of a matrix
  beta_hat <- solve(t(X) %*% X) %*% t(X) %*% y
  V_beta   <- solve(t(X) %*% X)
  
  # 'sample co-variance matrix'
  s_squared <- 1 / (n - k) * t(y - (X %*% beta_hat)) %*% (y - (X %*% beta_hat))
  
  # sample from posterior of variance
  samples_sigma_squared <- extraDistr::rinvchisq(
    n   = n_samples, 
    nu  = n - k, 
    tau = s_squared
  )
  
  # sample full joint posterior triples
  samples_posterior <- map_df(
    seq(n_samples), 
    function(i) {
      s <-  mvtnorm::rmvnorm(1, beta_hat, V_beta * samples_sigma_squared[i]) 
      tibble(
        intercept = s[1],
        slope     = s[2],
        sigma     = samples_sigma_squared[i] %>% sqrt()
      )
    }
  )  
  return(samples_posterior)
}