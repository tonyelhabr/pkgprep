
# Reference: https://colinfay.me/build-api-wrapper-package-r/.
# library(devtools)
# library(devtools)
# library(desc)

# Remove default DESC
unlink("DESCRIPTION")
# Create and clean desc
desc <- desc::description$new("!new")

# Set your package name
desc$set("Package", "espnapi2")

#Set your name
desc$set("Authors@R", "person('Tony', 'ElHabr', email = 'anthonyelhabr@gmail.com', role = c('cre', 'aut'))")

# Remove some author fields
desc$del("Maintainer")

# Set the version
desc$set_version("0.0.0.9000")

# The title of your package
desc$set(Title = "A package")
# The description of your package
desc$set(Description = "A long description that I just made up for this package.")
# The urls
desc$set("URL", "http://this")
desc$set("BugReports", "http://that")
# Save everyting
desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, and lifecycle badge
usethis::use_mit_license(name = "Tony ElHabr")
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge("Experimental")
usethis::use_news_md()

# Get the dependencies
usethis::use_package("httr")

# Clean your description
usethis::use_tidy_description()
