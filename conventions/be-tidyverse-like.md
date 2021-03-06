
Note to self: This was copy-pasted from my notes in my `{tetidy}` package.
These should be updated so that they are not specific to that package
(although they should still include some examples, possibly referring
to functions from the package).

## Things To Do/Consider To Be More "`{tidyverse}`-like"

### In General

- [x] Change all references of `col`s to `var`s and `data` to `.data`?
    - Update: Choosing NOT to do these in order to maintain personal "style".
    - Note that at <https://github.com/tidyverse/principles/issues/1>,
    it is stated that "`col_names` is the tidyverse answer to `header = TRUE"` and
    "`col_types` is the tidyverse answer to `colClasses`" (although these seem
    to be directly referring to `{readr}`'s conventions, and no explicity mention
    of "`col` vs. `var`" is made.
- [x] Should change all `_at` functions to be use `manip_at()` internal function,
as shown in `mutate_at()` and `summarise_at()` implementations in `{dplyr}`.
(See <https://github.com/tidyverse/dplyr/blob/2e6ca1676ece390b7a3e0a76b52c6bbf1464a180/R/colwise-mutate.R>.)
    - Update: Choosing NOT to do this, primarily to mainting the personal
    historical convetion of using `_at`-suffixed functions as the core implementation,
    and creating NSE wrappers without such a suffix. (e.g. See the `summarise_stats()`
    function implementation in this package). Although this is not "in line" with
    how `_at`-suffixed functions "should" work in the `{tidyverse}`, it is
    convenient for me personally. Also, note that a "robust" fix would require 
    some non-trivial re-factoring and may not be worth the errort/time for such 
    a "peronsal" package as this.
- [x] Be opinionated about the prefixing of argument names with `.`. In general,
implement the take-aways from the discussion at
 https://community.rstudio.com/t/function-argument-naming-conventions-x-vs-x/7764/15
(discussion on `{tidyverse}` package function argument naming conventions).
(As explained in the 
[`{forcats}` 0.3.0  release notes](https://www.tidyverse.org/articles/2018/02/forcats-0-3-0/),
"Consistent with other tidyverse packages, all functions that take ... 
now use tidy dots. This means that you can use !!! to splice in a list of values."
Also, per Hadley's response at <https://github.com/tidyverse/style/issues/75>
"It is not a general principle. It's something that only apply to FP tools like 
purrr, because you don't want to confuse the arguments to map() with the 
arguments to .f".)
    - Update: Not doing this, primary for the reason mentioned above regarding
    "`col` vs. `var`" and "`data` vs. `.data`". Additionally not using prefixes
    simplifies things from a developer's perspective. And, since the functions
    in this package are not intended to be as "dynamic" as the core `{dplyr}` functions,
    one can argue that it is ok to go against the accepted
    conventions of argument naming.
- [x] Per <https://github.com/tidyverse/principles/issues/1>, make `@return` keywords "uniform".
    "Use a standard `@return` blurb to document a returned tibble, i.e. don't just say "a data frame".
    A good start, for now: `@return A [tibble][tibble::tibble-package]`.

### With Specific Functions

- `pull_distinctly()`
    - [x] Use `data` and `var` to match `dplyr::pull()` argument names exactly.
        - Update: No, see general explanation above.
    
- `arrange_distinctly()`
    - [x] Use `data` and `...` to match `dplyr::distinct()` argument names exactly.
        - Update: No, see general explanation above.

- `rank_unique(x)`
    - [x] Use `-xtfrm(x)` instead of `dplyr::row_number()` (which are equivalent)?
        - Update: No, since `{dplyr}` is being used so much anyways...

- `rank_arrange()`
    - [x] Consider using `key` and `value` or `into` argument names (like `tidyr::gather()` and `tidyr::spread()`)
    (instead of `var` and `var_out`.
    - [x] Keep `data` argument name because it matches `dplyr::mutate`'s `data`.
    - [x] Consider "splicing" dots to pass to mutate (instead of "hard-coding" function used with `mutate()`.
    - [ ] Consider how `_at` form can better be combined with the non-suffixed form.
    - [x] Deprecate in favor of `add_*()`-type function? (The `add_` prefix to a 
    function can be used to indicate to the user that a new column is being created.)
        - Update: See `add_rnk_col()`.
    - [ ] Add better validation for columns existing in `data`?
    
- `count_arrange()`
    - [ ] Consider how `_at` form can better be combined with the non-suffixed form.
    - [ ] Add better validation for columns existing in `data`?

- `summarise_stats()`

- `join_fuzzily()`

- `summarise_join_stats()`

- `reorder_one_of_at()`, `reorder_one_of_at()`
    - [x] If a major re-haul were to be done to implement `{dplyr}`-like handling 
    of `_at` functions (which is unlikely, then these would need to be updated.
- `separete_cols()`, `unlist_tidily()`
    - [ ] Add tests (perhaps specifically tailored to converting `yaml` to some
    other format (e.g. `{argparser}`-acceptable format).

### "Lesser"-Known Example Packages
- [`{srvyr}`](https://github.com/gergness/srvyr/)