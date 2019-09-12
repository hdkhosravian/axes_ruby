# README
I'm trying to create a machine learning NLP project with Python, Ruby on Rails and React.
I created this project with `AXES` name, and you can access to complete of the project with this address: [Axes World](http://www.axes.world) ( I'm working on it, and if you haven't access to this url, please check it with this IP: 188.40.195.27, if this Ip doesn't work too please let me know: hd.khosravian@gmail.com )
<br />
I'm using react on rails for this project, but because of some copyrights I had to remove the UI from this repositories, I didn't remove the base of architect of React that I used in this project so you can use it if you want. You can check it here: `client/bundle/...`.

# Copyright
You can use this project if you want, but you must mention my name in your project.

# configuring

### Docker configurations:

#### make a copy from `docker-compose.sample.yml` and `docker.sample.env` then remove `sample` from your copies. Make changes on your docker files.
Use this command to run docker:

- docker-compose build
- docker-compose up

use can use `docker-compose up -d` to run the project in the background.

### also you can run the project in your system manually

#### make a copy from `database.sample.yml` and `storage.sample.yml` then remove `sample` from the name. Make changes on your files. Install gems with `bundle install`, then run ` rails credentials:edit` to generate you rails secret keys. Create and migrate the database with `rake db:create` and `rake db:migrate`.

then you can run server with:
### foreman start -f Procfile.dev
### foreman start -f Procfile.dev-server

# Python Repository
https://github.com/hdkhosravian/axes_python
