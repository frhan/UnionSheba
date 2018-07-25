
Deploy to Heroku
------------------
master - git push heroku master
branch - git push heroku yourbranch:master
logs - heroku logs -t

Migrate
-------
heroku run rake db:migrate

TODO
-----------
* barcode - https://www.youtube.com/watch?v=0ZCvLDZQ5HM
* add created_by and updated_by
* http://siunegu.github.io/barby/wicked_pdf/rails/pdf/2015/04/22/rails-pdf-barcodes/

http://aymeric.gaurat.net/2010/how-to-develop-live-search-textbox-in-ruby-on-rails/
http://roseweixel.github.io/blog/2015/07/05/integrating-ajax-and-rails-a-simple-todo-list-app/
http://www.mccartie.com/2014/08/28/digital-ocean.html
https://github.com/bradyholt/ansible-rails
https://blog.botreetechnologies.com/how-to-change-primary-key-column-size-type-using-rails-migration-with-mysql-7a0f74c9e24d#.xw6ng0upx
https://coderwall.com/p/kqb3xq/rails-4-how-to-partials-ajax-dead-easy
https://www.youtube.com/watch?v=j1zZ4Lgzf9s
http://siunegu.github.io/barby/wicked_pdf/rails/pdf/2015/04/22/rails-pdf-barcodes/

https://github.com/superp/rails-uploader

#tax and other collection datatable

Task
-----
* validates same nid or birthid (english and bangla)

নাগরিক
--------
- নাগরিকত্ব সন্দের আবেদন
- নাগরিকত্ব সন্দের আবেদন যাচাই
- নাগরিকত্ব সনদ পত্র যাচাই

 ওয়ারিশ
 --------
- ওয়ারিশ সন্দের আবেদন
- ওয়ারিশ সন্দের আবেদন যাচাই
- ওয়ারিশ সনদ পত্র যাচাই

ট্রেড লাইসেন্স
-----------
- ট্রেড লাইসেন্স আবেদন
- ট্রেড লাইসেন্স আবেদন যাচাই
- ট্রেড লাইসেন্স যাচাই
- রেড লাইসেন্স নবায়ন

অবিবাহিত সনদ
পুনঃ বিবাহ না হওয়ার সনদ
একি  নামের প্রত্যয়ন পত্র
সনাতন ধর্ম অবলম্বী
প্রত্যয়ন পত্র
ভূমিহীন সনদ
বার্ষিক আয়ের সনদ

Task
-------
* T#2: citizen certificate
 - label from file
 - jquery form verification
 - pdf
 - date of birth add calender
 - checking data
 - delete citizen
 - citizen no should unique for all union
 - on public show - union/district/upazila- show
 
* T#3 warish certificate
 - controller
 - views
 - certificate
 - 
 
* others certificate
* add footer
* theme should not black
* paralax for home page
*

Digital ocean
--------------
http://tohyongcheng.github.io/learn/ruby%20on%20rails/digitalocean/capistrano/postgresql/2016/01/10/deploying-ror-on-digitalocean.html

https://github.com/BeanStack/deploying_on_digital_ocean

http://vladigleba.com/blog/2014/08/12/provisioning-a-rails-server-using-chef-part-2-writing-the-recipes/


Citizen Applications
--------------------
* after request send mail with tracking id
* after verifiy send mail with pdf
* 

Kill port
------

sudo lsof -i tcp:3000 
Replace 3000 with whichever port you want. Run below command to kill that process.

sudo kill -9 PID

PDF and Mail
------------

https://berislavbabic.com/send-pdf-attachments-from-rails-with-wickedpdf-and-actionmailer/

https://bootsnipp.com/snippets/featured/dynamic-sortable-tables

https://bootsnipp.com/snippets/featured/basic-register-page

File upload:
https://github.com/blueimp/jQuery-File-Upload/wiki
https://devcenter.heroku.com/articles/direct-to-s3-image-uploads-in-rails