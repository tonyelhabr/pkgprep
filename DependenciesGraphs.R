
# Reference: https://stackoverflow.com/questions/44143110/visualizing-r-function-dependencies
# library("tidyverse")
library("DependenciesGraphs")
library("tidyselect")

# All dependencies between functions in an environment
dep1 <- envirDependencies("package:tidyselect")
plot(dep1)

# All dependencies from a function in an environment
dep2 <- funDependencies("package:tidyselect", "one_of")
plot(dep2)

library("mvbutils")
library("tidyselect")
library("dplyr")
# dep3 <- mvbutils::foodweb(where = "package:tidyselect", prune = "one_of")
# plot(dep3)
dep3 <- mvbutils::foodweb(where = "package:dplyr")
plot(dep3)

dep4 <- mvbutils::foodweb(where = "package:dplyr", prune = "enquo")
plot(dep4)
