
extrafont::loadfonts(device = "win", quiet = TRUE)
# https://github.com/mkearney/hex-stickers/blob/master/code.R
## load ggplot2
library(ggplot2)

## function to make basic hex sticker
make_hexsticker <- function(pkg, pkg_size, pkg_color, pkg_y = -.33, bg,
                            border, icon, family,
                            url, icon_color, icon_size,
                            url_color = "transparent",
                            fa = "Font Awesome 5 Brands",
                            icon_y = .25, icon_x = 0) {
  x <- c(0, 0.865, 0.865, 0, -0.865, -0.865, 0)
  y <- c(1, 0.5, -0.5, -1, -0.5, 0.5, 1)
  h <- data.frame(x, y)
  xx <- .825
  x <- c(0, xx, xx, 0, -xx, -xx, 0)
  yy <- 0.475
  y <- c(.95, yy, -yy, -.95, -yy, yy, .95)
  h2 <- data.frame(x, y)

  ggplot(h, aes(x, y)) +
    geom_polygon(fill = border, size = 0) +
    geom_polygon(data = h2, fill = bg, size = 0) +
    geom_text(
      data = data.frame(x = icon_x, y = icon_y),
      aes(label = icon), family = fa,
      color = icon_color, size = icon_size
    ) +
    theme_void() +
    annotate("text", 0, pkg_y,
      label = pkg, family = family,
      size = pkg_size, color = pkg_color
    ) +
    annotate("text", .225, -.76,
      label = url, family = family,
      size = 8, angle = 30, color = url_color
    )
}

## function to make shaded two-sided hex sticker
make_hexsticker2 <- function(pkg, pkg_size, pkg_y = -.33, bg1, bg2, border1,
                             border2, icon, family,
                             url, icon_color, icon_size, pkg_color,
                             url_color = "transparent",
                             fa = "Font Awesome 5 Brands", icon_y = .25) {
  x1 <- c(0, 0.865, 0.865, 0, 0)
  x2 <- c(0, -0.865, -0.865, 0, 0)
  y1 <- c(1, 0.5, -0.5, -1, 1)
  y2 <- c(-1, -0.5, 0.5, 1, -1)
  h1a <- data.frame(x = x1, y = y1)
  h1b <- data.frame(x = x2, y = y2)
  xx <- .825
  x1 <- c(0, xx, xx, 0, 0)
  x2 <- c(0, -xx, -xx, 0, 0)
  yy <- 0.475
  y1 <- c(.95, yy, -yy, -.95, .95)
  y2 <- c(-.95, -yy, yy, .95, -.95)
  h2a <- data.frame(x = x1, y = y1)
  h2b <- data.frame(x = x2, y = y2)
  ggplot(h1a, aes(x, y)) +
    geom_polygon(fill = border1, size = 0) +
    geom_polygon(data = h1b, fill = border2, size = 0) +
    geom_polygon(data = h2a, fill = bg1, size = 0) +
    geom_polygon(data = h2b, fill = bg2, size = 0) +
    geom_text(
      data = data.frame(x = .475, y = icon_y),
      aes(label = icon), family = fa,
      color = icon_color, size = icon_size, angle = -8
    ) +
    geom_text(
      data = data.frame(x = -.475, y = icon_y),
      aes(label = icon), family = fa,
      color = icon_color, size = icon_size, angle = 8
    ) +
    theme_void() +
    annotate("text", -.25, pkg_y,
      label = pkg, family = family,
      size = pkg_size, color = pkg_color
    ) +
    annotate("text", .45, -.66,
      label = url, family = family,
      size = 5, angle = 30, color = url_color
    )
}

# dir.create("PNG")
## ----------------------------------------------------------------------------##
##                                   rtweet                                   ##
## ----------------------------------------------------------------------------##
options(encoding = "UTF-8")
p <- make_hexsticker(
  pkg = "rtweet", bg = "#ffffff", border = "#002255", icon = "<U+F39A>",
  icon_color = "#003366cc", family = "Avenir Heavy", icon_size = 80, pkg_size = 32,
  url = "rtweet.info", pkg_color = "#003366",
  url_color = "#003366", fa = "Font Awesome 5 Brands"
)
p

p + ggsave("PNG/rtweet.png",
  width = (1.73 / 2) * 8,
  height = 8, units = "in", bg = "transparent"
)

## ----------------------------------------------------------------------------##
##                                textfeatures                                ##
## ----------------------------------------------------------------------------##


p <- make_hexsticker(
  pkg = "textfeatures", bg = "#3366ff", border = "#002299",
  icon = "<U+F5AE>", icon_color = "#ffffff", icon_size = 60,
  pkg_size = 26, pkg_y = -.32, family = "Avenir Heavy",
  url = "", pkg_color = "#ffffff",
  fa = "Font Awesome 5 Free Solid"
)

p + ggsave("PNG/textfeatures.png",
  width = (1.73 / 2) * 8, height = 8,
  units = "in", bg = "transparent"
)
p

## ----------------------------------------------------------------------------##
##                                  pkgverse                                  ##
## ----------------------------------------------------------------------------##


p <- make_hexsticker(
  pkg = "pkgverse", bg = "#d16cb8", border = "#220022", icon = "<U+F0E8>",
  icon_color = "#220022", family = "Avenir Heavy", icon_size = 60,
  pkg_size = 28, pkg_y = -.28, icon_y = .275,
  url = "", pkg_color = "#ffffff",
  fa = "Font Awesome 5 Free Solid"
)

p + ggsave("PNG/pkgverse.png",
  width = (1.73 / 2) * 8, height = 8, units = "in",
  bg = "transparent"
)
p
