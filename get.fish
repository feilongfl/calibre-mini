#!/usr/bin/env fish

rm news.mobi

while true
	ebook-convert /Calibre-News.recipe news.mobi
	if test -f news.mobi
		break
	end
end

calibre-smtp --attachment news.mobi --relay smtp.126.com --port 465 --username zydzrx --password "chmbjx5" --encryption-method SSL zydzrx@126.com 614183595@kindle.cn "This mail send by calibre-mini!" -v -s "convert"

#mv ./news.mobi /News/(date +”%Y%m%d”).mobi
calibredb add --library-path=/News ./news.mobi
