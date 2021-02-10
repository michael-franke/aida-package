# aida-package
R package with helper functions for courses on _A_dvanced topics in and _I_ntro to _D_ata _A_nalysis

### Installation

Run:

```
remotes::install_github("michael-franke/aida-package")
```

### changelog

- `0.4`:
    - remove `nimble` dependency (and respective functions)
- `0.3.4`:
    - extend Bayesian sampling function to k>2
- `0.3.3`:
    - add convenience functions for posterior sampling (Gaussian inference & regression)
- `0.3.2`:
    - add more data sets
- `0.3.1`: 
    - add `bootstrapped_CI()` convenience function
- `0.3`: 
    - rename and properly document mousetracking data (more or less)
    - plug holes in function documentation
    - minor fixes to code (like syntax and imports)
- `0.2.1`: 
    - add `summarize_sample_vector()` convenience function
    - tweak plot colors
- `0.2`:  
    - **NEW** `theme_aidark()` - a dark version of `theme_aida()`  
    - added grid lines by default to `theme_aida()`; turn off via `show.grid = FALSE`  
    - clarified tooltips  
- `0.1.1`: added spacing to x-axis and axis title in `theme_aida()`  
