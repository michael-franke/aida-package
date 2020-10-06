#' Nimble CRS
#'
#' convenience function for building and compiling nimble models 
#' Note by MF: "Compile and Run"
#' 
#' @param model_code either a string containing the code of the model or the variable in which the code is stored
#' @param constants ALL the constants 
#' @param data the dataset to be passed to `nimble::nimbleModel()`
#' @param inits inits parameter to be passed to `nimble::nimbleModel()`
#' @param monitors user modified monitors; leave empty if 
#' @param nburnin ...
#' @param thin ...
#' @param niter number of iterations
#' @param nchains number of chains
#' 
#' @return mcmc.list
#' @export

crs_nimble <- function(model_code, constants, data, inits, monitors = c(), nburnin = 0, thin = 1, niter = 100000, nchains = 4) {
    message("building and compiling model ...")
    # create model from input
    model <- suppressMessages(
        nimble::nimbleModel(
            model_code, 
            constants = constants, 
            data = data, 
            inits = inits
        )
    )
    # obtain samples
    if (length(monitors) == 0) {
        # no monitors set
        samples <- (
            nimble::nimbleMCMC(
                model = model,
                niter = niter, 
                nburnin = 0,
                thin = 1,
                nchains = nchains,
                samplesAsCodaMCMC = F
            )
        )
    } else {
        # user specified monitors
        samples <- (
            nimble::nimbleMCMC(
                model = model,
                monitors = monitors,
                niter = niter, 
                nburnin = 0,
                thin = 1,
                nchains = nchains,
                samplesAsCodaMCMC = F
            )
        )
    }
    # massage output as proper coda object
    out <- lapply(samples, function(x) 
        coda::mcmc(x, start = nburnin + 1, end = niter, thin = thin)
    )  
    names(out) = stringr::str_c("chain", seq(out))
    return(coda::mcmc.list(out))
}