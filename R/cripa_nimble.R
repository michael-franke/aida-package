#' Nimble CRIPA
#'
#' Note by MF: "Complile and Run individually for parallel assembly"
#' 
#' @param seed set seed (maybe; I have to look into it)
#' @param model_code either a string containing the code of the model or the variable in which the code is stored
#' @param constants ALL the constants 
#' @param data the dataset to be passed to `nimble::nimbleModel()`
#' @param inits inits parameter to be passed to `nimble::nimbleModel()`
#' @param monitors user modified monitors; leave empty for default (?)
#' @param nburnin ...
#' @param thin ...
#' @param niter number of iterations
#' @param nchains number of chains
#' 
#' @import nimble
#' @return list
#' @export

cripa_nimble <- function(seed, model_code, constants, data, inits, monitors, nburnin = 0, thin = 1, niter = 100000, nchains = 4) {
    message("building and compiling model ...")
    # create model from input
    model <- suppressMessages(nimble::nimbleModel(
        model_code, 
        constants = constants, 
        data = data, 
        inits = inits
    ))
    # obtain samples
    if (length(monitors) == 0) {
        print("huhu")
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
    return(samples)
}
