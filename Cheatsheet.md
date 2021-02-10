# Cheatsheet for building & updating the package

## tl;dr

1. copy&paste a function including the preceding `roxygen` comments (`#'`)
2. ~~hack the planet~~ modify as needed
    - if any, add not-yet imported packages to `DESCRIPTION`
3. run `devtools::document()`
4. build package by hitting `ctrl`/`cmd` + `shift` + `B`

## Adding functions

* use `R/crs_nimble.R` as a template to modify  
* lines beginning with `#'` are used for documentation via the `roxygen2` package:  
    + **`@export` is critical!** It tells `roxygen2` to add the function to `NAMESPACE` and makes it accessable to users; even though I list it here first, it comes last in the `roxygen` chunk.  
    + `@param` is for descriptions of a functions arguments -> **every** argument should be listed here!  
    + `@import` is, perhaps unsurprisingly so, for importing functions from other (non-`base-R`) packages:  
        - it is good practice to import functions as sparingly as possible; rather call them explicitly (see next point)  
        - every function used in the actual code **needs** to be given **explicitly** (e.g. `dplyr::filter(...)`)  
        - `@imported`ed functions don't need to be called explicitly, even though it's still advisable to do so in order to avoid conflicts (e.g. `package:stats::filter` and `package:dplyr::filter`)  
    + `@returns` contains a description of what the function returns, but is not strictly necessary  
    + same goes for `@examples`: it may contain what it says, but not necessarily  
    + again, `@references` is not necessary, but if you have any, this would be the place to include them  
* save functions as `some_name.R` in the `R/` folder
    + scripts can contain more than one function and documentation
    + the current approach of "one script per function" works well for a small set of distinct functions
    + should the package grow, it might at some point be advisable to group functions by application areas (e.g. `plot_themes.R`, `summary_functions.R`, etc.)
* when using imported functions, add the respective package to the `Imports:` section of the `DESCRIPTION` file
* after creating new scripts/functions/descriptions, run `devtools::document()` and afterwards build the package (`ctrl`/`cmd` + `shift` + `B`) - Done!


## Adding data

1. in an interactive session, read-in data as usual
    - to rename data already present in the package, read it with the desired name and delete the file with the old name in `data/`
2. run `usethis::use_data(name_of_data)` (e.g. `usethis::use_data(mousetrack_typicality)`)
    - this will put the data as an `.rda` file - surprisingly again - into `data/` and make it available by the name of the data-object
    - ideally (but not necessarily), some description of the data is provided in `R/data.R`; the one already present should suffice as an example on how that looks
    - when renaming data, remember to change the name provided in `R/data.R` as well
3. run `devtools::document()` and afterwards build the package (`ctrl`/`cmd` + `shift` + `B`)
