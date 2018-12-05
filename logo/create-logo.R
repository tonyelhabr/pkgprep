
.viz_void <- ggplot2::ggplot() + ggplot2::theme_void()

create_pkg_logo <-
  function(pkg,
           ...,
           dir = file.path("..", pkg),
           dir_logo = file.path(dir, "man", "figures"),
           path_logo = file.path(dir_logo, "logo.png"),
           verbose = TRUE,
           logo_bkgrd = .viz_void) {
    
    # Unfortunately, can't use `{glue}` for messages because `pkg` comes from parent
    # frame, while other variables come from current frame (so even specifying `.envir`
    # does not resolve the issue.
    if (!dir.exists(dir)) {
      if (verbose) {
        msg <- sprintf("Cannot find local directory (at %s) for package `{%s}`.", dir, pkg)
        message(msg)
      }
      return(invisible())
    }
    
    if (!dir.exists(dir_logo)) {
      if (verbose) {
        msg <- sprintf("Creating `dir_logo` (at %s) for package `{%s}`.", path_logo, pkg)
        message(msg)
      }
      invisible(dir.create(dir_logo, recursive = TRUE))
    }
    
    hexSticker::sticker(
      subplot = logo_bkgrd,
      package = pkg,
      filename = path_logo,
      p_y = 1.0,
      p_color = "black",
      # p_family = "sans",
      p_size = 40,
      h_size = 1.5,
      h_color = "black",
      h_fill = "#bd93f9"
    )
    logo <- magick::image_read(path_logo)
    if(file.exists(path_logo)) {
      if (verbose) {

        msg <- sprintf("Overwriting `path_logo` (at %s) for package `{%s}`.", path_logo, pkg)
        message(msg)
      }
    }
    magick::image_write(magick::image_scale(logo, "120"), path = path_logo)
    invisible(logo)
  }

pkgs <- c("teproj", "tetidy", "teplot", "teio", "teauto", "teml")

purrr::walk(pkgs, create_pkg_logo)


