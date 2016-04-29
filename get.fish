#!/usr/bin/env fish

rm news.mobi
ebook-convert Calibre-News.recipe news.mobi
#mv ./news.mobi /News/(date +”%Y%m%d”).mobi

