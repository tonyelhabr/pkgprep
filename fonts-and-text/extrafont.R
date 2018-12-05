
library("extrafont")
font_import()
loadfonts()
# font_import(pattern = "fa-", prompt = FALSE)
font_import(pattern = "fontawesome-webfont.ttf", prompt = FALSE)
fonts()[grep("Awesome", fonts())]

library("tidyverse")
f <- fonts()
f %>% str_subset("Awe")
f_df <- fonttable() %>% as_tibble()
f_df %>%  filter(FullName %>% str_detect("Awe"))
f_df %>% filter(is.na(package))


