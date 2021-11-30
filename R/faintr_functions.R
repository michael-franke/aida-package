#' Obtain information about factors in regression models
#'
#' This function takes a \code{\link[brms:brm]{brms}} model fit for a 
#' factorial design and returns all design cells along with their encoding in 
#' the regression model.
#' 
#' @param model An object of class \code{\link[brms:brmsfit-class]{brmsfit}}.
#' @return A \code{\link[tibble:tibble-package]{tibble}} containing the minimal
#' design matrix.
#' @examples
#' library(brms)
#' # linear mixed effects model 
#' # regressing voice pitch against gender and context
#' m <- brm(formula = pitch ~ gender * context + (1 | subject + sentence), 
#'         data = data_polite)
#' get_cell_definitions(m)
#' @export

get_cell_definitions <- function(model) {
    
    checkmate::assert_class(model, "brmsfit")
    
    # get fixed effects names
    fixef <- all.vars(brms::brmsterms(formula(model))$dpars$mu$fe)
    
    # concatenate design matrix and actual data
    cell_defs <- dplyr::bind_cols(
        model$data %>% dplyr::select(all_of(fixef)),
        as.data.frame(brms::standata(model)$X)
    ) %>% unique() %>% 
        tibble::rowid_to_column(var = "cell")
    
    
    return(tibble::as_tibble(cell_defs))
}


#' Extract posterior draws for one subset of factorial design cells
#'
#' This function takes as input a \code{\link[brms:brm]{brms}} model fit for a 
#' factorial design and a group specification (one subset of the design cells). It
#' returns the posterior draws for that group. If no group is specified, the returned 
#' posterior draws are grand means.
#' 
#' @param model An object of class \code{\link[brms:brmsfit-class]{brmsfit}}.
#' @param ... The group specification.
#' @return A data frame containing posterior draws for the specified group.
#' @examples
#' library(brms)
#' # linear mixed effects model 
#' # regressing voice pitch against gender and context
#' m <- brm(formula = pitch ~ gender * context + (1 | subject + sentence), 
#'         data = data_polite)
#' 
#' # extract posterior draws of female speakers in informal contexts
#' extract_draws(m, gender == "F", context == "inf")
#' extract_draws(m, gender == "F" & context == "inf")
#' 
#' # extract posterior draws of male speakers or informal contexts
#' extract_draws(m, gender == "M" | context == "inf")
#' 
#' # averaged over gender, extract posterior draws for all but polite contexts
#' extract_draws(m, context != "pol")
#' 
#' # extract the posterior draws averaged over all factors
#' extract_draws(m)
#' @export

extract_draws <- function(model, ...) {
    
    checkmate::assert_class(model, "brmsfit")
    
    ## extract draws for each design cell ----
    
    # get fixed effects names
    fixef <- all.vars(brms::brmsterms(formula(model))$dpars$mu$fe)
    
    # get minimal design matrix as tibble w/ row numbers in column
    design_matrix <- aida::get_cell_definitions(model)
    
    # extract posterior draws
    draws <- posterior::as_draws_df(as.data.frame(model))
    
    # extract coefficient names of fixed effects
    coeff_names <- as.data.frame(brms::standata(model)$X) %>% colnames() %>% 
        str_c("b_", .)
    
    # re-extract minimal design matrix as matrix 
    X <- design_matrix %>% select(!all_of(c(fixef,"cell"))) %>% as.matrix()
    
    # extract relevant draws as matrix
    Y <- as_tibble(draws) %>% select(coeff_names) %>% as.matrix()
    
    # use matrix product to get draws for each cell
    draws_for_cells <- Y %*% t(X)
    
    ## extract draws for factor level combinations ----
    
    group_spec <- dplyr::enquos(...)
    
    # get cell numbers based on specification
    cell_numbers <- design_matrix %>%
        dplyr::filter(!!!group_spec) %>%
        dplyr::select(cell) %>%
        dplyr::pull()
    
    if (length(cell_numbers) == 1) {
        out <- draws_for_cells[,cell_numbers] %>% as.data.frame()
    } else if (length(cell_numbers) > 1) {
        out <- draws_for_cells[,cell_numbers] %>% rowMeans() %>% as.data.frame()
    } else {
        stop(glue::glue("level specification {lapply(group_spec, rlang::quo_get_expr) %>% paste(., collapse = ', ')} unknown"))
    }
    
    # add group specification as column name
    if(!length(group_spec)) {
        colnames(out) <- "grand mean"
    } else {
        colnames(out) <- lapply(group_spec, rlang::quo_get_expr) %>% paste(., collapse = ", ")
    }
    
    out
    
}


#' Compare two subsets of factorial design cells
#'
#' Convenience function for addressing directional hypotheses in factorial 
#' designs. It takes a \code{\link[brms:brm]{brms}} model fit, two group
#' specifications (two subsets of design cells), and the alpha-level of the 
#' comparison. It outputs the posterior mean of the 'higher' minus the 'lower' 
#' group, its 1-\code{alpha} percent credible interval, as well as the posterior 
#' probability and odds that the mean estimate of the 'higher' group is higher 
#' than that of the 'lower' group. A comparison of one group against the grand mean 
#' can be obtained by leaving out one of the two group specifications in the function 
#' call.
#' 
#' @param model An object of class \code{\link[brms:brmsfit-class]{brmsfit}}.
#' @param higher 'Higher' group specification.
#' @param lower 'Lower' group specification.
#' @param alpha A single value (0, 1) as the alpha-level of the group 
#' comparison (defaults to 0.05).
#' @return A list with summary statistics of the group comparison.
#' @examples
#' library(brms)
#' # linear mixed effects model 
#' # regressing voice pitch against gender and context
#' m <- brm(formula = pitch ~ gender * context + (1 | subject + sentence), 
#'         data = data_polite)
#' 
#' # compare female speakers in informal contexts against male speakers in polite contexts
#' compare_groups(
#'  model  = m, 
#'  higher = gender == "F" & context == "inf",
#'  lower  = gender == "M" & context == "pol"
#' )
#' 
#' # compare informal contexts against polite contexts, averaged over gender
#' compare_groups(
#'  model  = m, 
#'  higher = context == "inf",
#'  lower  = context == "pol"
#' )
#' 
#' # compare female speakers against the grand mean
#' compare_groups(
#'  model  = m, 
#'  higher = gender == "F"
#' )
#' 
#' @export

compare_groups <- function(model, higher, lower, alpha = 0.05) {
    
    checkmate::assert_class(model, "brmsfit")
    
    if(length(alpha) != 1 || alpha <= 0 || alpha >= 1) {
        stop("alpha must be a single value between 0 and 1")
    }
    
    higher <- dplyr::enquo(higher)
    lower  <- dplyr::enquo(lower)
    
    # get draws for 'higher' group specification 
    if(rlang::quo_is_missing(higher) == 1) {
        post_samples_higher <- aida::extract_draws(model = model)
    } else {
        post_samples_higher <- aida::extract_draws(model = model, !!higher)
    }
    
    # get draws for 'lower' group specification 
    if(rlang::quo_is_missing(lower) == 1) {
        post_samples_lower <- aida::extract_draws(model = model)
    } else {
        post_samples_lower <- aida::extract_draws(model = model, !!lower)
    }
    
    outlist <- list(
        alpha        = alpha,
        higher       = colnames(post_samples_higher),
        lower        = colnames(post_samples_lower),
        mean_diff    = mean((post_samples_higher - post_samples_lower)[,1]),
        l_ci         = as.vector(HDInterval::hdi(post_samples_higher - post_samples_lower, credMass = 1-alpha)[1]),
        u_ci         = as.vector(HDInterval::hdi(post_samples_higher - post_samples_lower, credMass = 1-alpha)[2]),
        probability  = mean(post_samples_higher > post_samples_lower),
        star         = if(mean(post_samples_higher > post_samples_lower) > 1 - alpha){"*"},
        odds         = mean(post_samples_higher > post_samples_lower)/(1 - mean(post_samples_higher > post_samples_lower))
    )
    class(outlist) = "faintCompare"
    return(outlist)
}


#' Print group comparison object
#' 
#' @param obj An object containing the summary statistics of a group comparison.
#' @return A string.
#' @export

print.faintCompare <- function(obj) {
    cat("Outcome of comparing groups:\n")
    cat(" * higher: ", obj$higher, "\n")
    cat(" * lower:  ", obj$lower, "\n")
    cat("Mean 'higher - lower': ", signif(obj$mean_diff, 4), "\n")
    cat(glue::glue("{(1-obj$alpha)*100}% CI:"), "[", signif(obj$l_ci, 4), ";", signif(obj$u_ci, 4), "]\n")
    cat("P('higher - lower' > 0): ", signif(obj$probability, 4), obj$star, "\n")
    cat("Posterior odds: ", signif(obj$odds, 4), "\n")
}

