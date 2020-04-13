#' Nimble CRISP
#'
#' Note by MF: 
#' Complile and Run In Sequence or Parallel
#' following template from https://r-nimble.org/nimbleExamples/parallelizing_NIMBLE.html
#'  "\[E]nsure that all NIMBLE execution, including model building, is conducted inside the 
#'   parallelized code. This ensures that all models and algorithms are independent objects
#'   that don't interfere with each other."
#' 
#' @param model_code either a string containing the code of the model or the variable in which the code is stored
#' @param constants ALL the constants 
#' @param data the dataset to be passed to `nimble::nimbleModel()`
#' @param inits inits parameter to be passed to `nimble::nimbleModel()`
#' @param monitors user modified monitors; leave empty for default (?)
#' @param nburnin ...
#' @param thin ...
#' @param niter number of iterations
#' @param nchains number of chains
#' @param clusters number of clusters
#' 
#' @return mcmc.list
#' @export

crisp_nimble = function(model_code, constants, data, inits, monitors = c(), nburnin = 0, thin = 1,
                        niter = 100000, nchains = 4, nclusters = 4) {
    # serial execution (only creates one model object)
    if (nclusters == 1) {
        message("serial execution: useful when model compilation is (relatively) longer than sampling")
        return(aida::crs_nimble(model_code, constants, data, inits, monitors, nburnin, thin, niter, nchains))
    }
    # parallel execution (creates several model objects)
    else {
        message("parallel execution: useful when sampling is (relatively) longer than model compilation\nall further output suppressed b/c of parallelisation")
        current_cluster <- parallel::makeCluster(nclusters)
        chain_output <- parallel::parLapply(cl = current_cluster,
                                            X = seq(nclusters),
                                            fun = cripa_nimble,
                                            model_code = model_code,
                                            constants = constants,
                                            data = data,
                                            inits = inits,
                                            monitors = monitors,
                                            nburnin = 0,
                                            thin = 1,
                                            niter = niter,
                                            nchains = nchains)
        parallel::stopCluster(current_cluster)
        if (nchains > 1) {
            out <- lapply(unlist(chain_output, recursive = F), function(x) 
                coda::mcmc(x, start = nburnin + 1, end = niter, thin = thin)
                # coda::mcmc(x)
            )  
        }
        else {
            out <- lapply(chain_output, function(x) 
                coda::mcmc(x, start = nburnin + 1, end = niter, thin = thin)
                # coda::mcmc(x)
            )  
        }
        names(out) = stringr::str_c("chain", seq(out))
        return(coda::mcmc.list(out))
    }
}
