README
======

Para correr la aplicación se necesita levantar dos instancias de Rails sobre el mismo proyecto. La primera instancia que debe levantarse corresponderá al WebService2.
Nota: Puede evitar correr el WebService2 localmente e ir directamente al paso WebService1 usando el servicio que corre en Heroku.
Se asume que tiene instalado postgresql y bundler en su máquina.

WebService2
===========

Para ello, clone el repositorio e ingrese al directorio del proyecto:
git clone git@github.com:itolosa/desafio-acid.git && cd desafio-acid

Luego instale las dependencias usando bundler:
bundle install

Antes de iniciar, se necesitan configurar algunas variables de entorno. Para ello se utiliza la gema figaro, por lo tanto, se debe configurar el archivo config/application.yml como se muestra mas abajo. Cambie <SENDGRID_USER> por su usuario en sengrid y <SENDGRID_PASS> por su contraseña.

user_mailer: <SENDGRID_USER>
pass_mailer: <SENDGRID_PASS>

production:
  # usar sendgrid para pushear mails
  user_mailer: <SENDGRID_USER>
  pass_mailer: <SENDGRID_PASS>
  secret_key_base: 4147da8627bec8d9359cd970751af5276628a1bcc9b7c44a4382cb8d33e312b79f85b56054203cb13ceda0b9798de2e70c52c8df6176831c278c9a6ee03ef1dc

Luego se debe configurar la base de datos del proyecto. Es importante que tenga instalado y corriendo la base de datos postgresql y que ésta sea compatible con la configuración dispuesta en config/database.yml. Luego corra estos comandos:
rake db:create db:migrate db:seed

Finalmente se debe levantar el servidor de rails para el webservice2:
bundle exec rails server webrick -p 3000 -P tmp/pids/server2.pid

Esto especifica que el servidor webrick corra en el puerto 3000, con un archivo que guarda el id del proceso en una ruta distinta a la que viene por defecto. Esto evitara conflictos.

WebService1
===========

Para levantar el webservice1, se debe configurar la aplicación en lib/web_service_client.rb cambiando la url del webservice2 por la url del servidor local de rails que ya esta corriendo en su máquina.

class WebServiceClient
  def self.post(email, image)
    # configura la conexion hacia el WebService2
    conn = Faraday.new(url: 'http://localhost:3000') do |faraday|
    ...

La url que trae el proyecto por defecto, corresponde a la url del servicio corriendo en Heroku. Es posible usar esta url si así se desea.
Luego se debe levantar el servidor rails, para ello corra el siguiente comando:
bundle exec rails server webrick -p 8080
Esto especifica que el servidor webrick corra en el puerto 8080.
La aplicación esta lista para su uso en la direccion http://localhost:8080/

Test
====

Se usaron test automatizados con el framework minitest que incluye Rails por defecto. Los tests se pueden correr con el siguiente comando:
rake test

Notas
=====

Se utilizó la gema sucker_punch como engine de ActiveJob para procesar los mails, debido principalmente a problemas con Heroku en el plan gratuito.
Se levantan dos instancias del proyecto debido a que rails corre sobre 1 solo thread y la única manera de permitir concurrencia es cambiando configuraciones internas, lo que hacen que puedan existir race conditions. Se evitó hacer esto ultimo debido a su gran inseguridad e inestabilidad.
Tenga en cuenta que el mensaje de email le puede llegar a la sección de spam de su cliente.
Se utilizó javascript para codificar la imagen en base64.