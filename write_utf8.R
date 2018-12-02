
write_utf8 <- function(text, f = tempfile()) {
  
  # ensure text is UTF-8
  utf8 <- enc2utf8(text)
  
  # create connection with UTF-8 encoding
  con <- file(f, open = "w+", encoding = "UTF-8")
  writeLines(utf8, con = con)
  close(con)
  
  # read back from the file just to confirm
  # everything looks as expected
  readLines(f, encoding = "UTF-8")
  
}

write_utf8("brûlée")
write_utf8("鬼")

Encoding('a')

utf8 <- "\u00fb"  # 'û'
latin1 <- iconv(utf8, to = "latin1")
paste(latin1, "(latin1):", pryr::bits(latin1))
paste(utf8,   "(UTF-8) :", pryr::bits(utf8))
