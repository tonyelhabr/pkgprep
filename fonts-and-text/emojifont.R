
# https://github.com/GuangchuangYu/emojifont/blob/master/vignettes/emojifont.Rmd
library("ggplot2")
library("emojifont")
library("colorspace")

library(emojifont)

search_emoji('smile')
emoji(search_emoji('smile'))

require(remoji)
set.seed(123)
x <- rnorm(10)
set.seed(321)
y <- rnorm(10)
plot(x, y, cex=0)
text(x, y, labels=emoji('cow'), cex=1.5, col='steelblue', family='OpenSansEmoji')
library(remoji)
message(emoji("cat"))
message(emoji(list_emoji(), TRUE))
message(sub_emoji("This is silly :frowning:"))
emoji_table(find_emoji("frown"))
emoji_table(find_emoji("frown", approximate=TRUE))

install_github("hadley/emo")
emo::face()
emo::ji("face")
emo::ji("poop")
