require 'flickraw'
class FlickrImage < Liquid::Tag
 
def initialize(tag_name, markup, tokens)
super
@markup = markup
@id = markup.split(' ')[0]
@size = markup.split(' ')[1]
@kClass = markup.split(' ')[2]
end
 
def render(context)
 
FlickRaw.api_key = "e34bc5723512f0e731cd414041663f14"
FlickRaw.shared_secret = "f9b2e110cdcfbaea"
 
info = flickr.photos.getInfo(:photo_id => @id)
 
server = info['server']
farm = info['farm']
id = info['id']
secret = info['secret']
title = info['title']
description = info['description']
size = "_#{@size}" if @size
src = "http://farm#{farm}.static.flickr.com/#{server}/#{id}_#{secret}#{size}.jpg"
page_url = info['urls'][0]["_content"]
img_tag = "<img src='#{src}' class='#{@kClass}' title='#{title}'/>"
link_tag = "<a href='#{page_url}'>#{img_tag}</a>"
 
end
end
 
Liquid::Template.register_tag('flickr_image', FlickrImage) 