
library("tidyverse")

owners <- 
  c(
    "tidyverse",
    "r-lib",
    "ropenscilabs",
    "yihui",
    "hrbrmstr",
    "jimhester"
  )
path_pkgs <- "utils-eda/data/pkgs.rds"

# path_xdf_raw <- "utils-eda/data-raw/utility-belt.rds"
path_xdf_raw <- "https://rud.is/dl/utility-belt.rds"
path_xdf_parsed <- "utils-eda/data/xdf-parsed.rds"

if(file.exists(path_pkgs)) {
  pkgs <- path_pkgs %>% read_rds()
} else {
  # Reference: https://masalmon.eu/2018/03/04/hrbrpkgs/
  pkgs_raw <-
    # "r-lib" %>% 
    tibble(owner = owners) %>% 
    mutate(repos = purrr::map(owner, ghrecipes::get_repos))
  pkgs_raw
  
  pkgs <-
    pkgs_raw %>% 
    select(repos) %>% 
    unnest(repos) %>% 
    separate(name, into = c("owner", "repo"), remove = FALSE, sep = "/")
  pkgs
  
  if(!dir.exists(dirname(path_pkgs))) {
    invisible(dir.create(dirname(path_pkgs), recursive = TRUE))
  }
  pkgs %>% write_rds(path_pkgs)
}

if(file.exists(path_xdf_parsed)) {
  xdf_parsed <- path_xdf_parsed %>% read_rds()
} else {
  # Reference: https://rud.is/b/2018/04/08/dissecting-r-package-utility-belts/
  # Don't change hrbrmstr's column names (even though `fil` should probably be `file`.
  xdf <-
    path_xdf_raw%>% 
    readr::read_rds() %>% 
    rename(file = fil)
  xdf
  
  is_assign <- function(x) {
    as.character(x) %in% c('<-', '=', '<<-', 'assign')
  }
  
  is_func <- function(x) {
    is.call(x) &&
      is_assign(x[[1]]) &&
      is.call(x[[3]]) &&
      (x[[3]][[1]] == quote(`function`))
  }
  
  get_func_names <- function(x) {
    x %>%
      keep(is_func) %>%
      map(~as.character(.x[[2]])) %>%
      flatten_chr()
  }
  
  xdf_parsed <-
    xdf %>% 
    mutate(parsed = purrr::map(file_src, ~parse(text = .x, keep.source = TRUE))) %>%
    mutate(func_names = purrr::map(parsed, get_func_names))
  xdf_parsed
  
  if(!dir.exists(dirname(path_xdf_parsed))) {
    invisible(dir.create(dirname(path_xdf_parsed), recursive = TRUE))
  }
  xdf_parsed %>% write_rds(path_xdf_parsed)
}

select_xdf_cols <-
  function(data) {
    data %>%
      select(owner, pkg, func_names)
  }

unnest_xdf_selectively <-
  function(data) {
    data %>%
      select_xdf_cols() %>% 
      unnest()
  }

# # Debugging...
# xdf_parsed %>%
#   # select(pkg, fil, func_names) %>% 
#   filter(pkg %>% str_detect("dplyr")) %>% 
#   unnest_xdf_selectively()

xdf_slim <-
  xdf_parsed %>%
  select_xdf_cols()

funcs_filt <-
  xdf_parsed %>% 
  semi_join(pkgs, by = c("pkg" = "repo")) %>% 
  unnest_xdf_selectively()
funcs_filt

funcs_filt_n <-
  funcs_filt %>% 
  count(func_names, sort = TRUE)
funcs_filt_n

funcs_filt_n %>% 
  filter(n > 3) %>% 
  inner_join(funcs_filt, by = "func_names") %>% 
  count(pkg, sort = TRUE)

funcs_filt %>% 
  filter(pkg %>% str_detect("blogdown"))
