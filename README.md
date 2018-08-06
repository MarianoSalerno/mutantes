# Mutantes

# Levantar el proyecto

Para correr el proyecto instalar ruby (con [rbenv](https://github.com/rbenv/rbenv) o [rvm](https://rvm.io/)) y despues correr los siguientes comandos en la terminal:

```
gem install bundler
bundle install --local
puma config.ru
```
Las estadisticas funcionan con [redis](https://redis.io/topics/quickstart) al cual hay que levantar aparte.

Luego de levantar todo se le puede pegar a la api utilizando curl:

#### DNA mutante
`
curl -X POST http://localhost:9292/mutant/ -d '{"dna":["ATGCGA","CAGTGC","TTATGT","AGAAGG","CCCCTA","TCACTG"]}'
`
#### DNA humano
`
curl -X POST http://localhost:9292/mutant/ -d '{"dna":["ATGCGA","CCGTGC","TTATGT","AGAAGG","CCTCTA","TCACTG"]}'
`
#### Estadisticas
`
curl -X GET http://localhost:9292/stats/
`
## Mejoras pendientes (la mayoria estan comentadas como TODOs en el del codigo proyecto)

* Usar docker-compose para levantar el proyecto en una maquina de desarrollo y docker para produccion.
* Configuracion de redis y clase humano (cantidad de secuencias para determinar si es mutante, tamanio de la secuencia, caracteres validos) por config/variables de entorno, si es que son parametros que pueden cambiar con frecuencia.
* Mover logica de estadisticas a un objeto aparte, quizas incluyendo manejo de errores. Tratar de hacerlo mas independiente de la base, si se considera que esta puede llegar a cambiar.
* En el endpoint mutant/ tirar un error mas descriptivo si viene un json invalido.
* Arreglar los tests de la api, todos los requests tiran 404. Tambien se podria mockear la llamada a mutante? para que fallen los tests solo ante un cambio en la api y no en el dominio.
* En los tests de la clase humano se pueden probar mas casos bordes y combinaciones de dimensiones y secuencias, generar el DNA de forma random o hasta incluso incluir algun framework para aplicar property based testing.

## Performance

Al no tener tiempo para hostear el proyecto y probar si se banca las fluctuacones de trafico que piden (seguro que 1M de requests por segundo no) voy a tratar de escribir como haria para mejorar la performance de la misma:

* Ruby no es el lenguaje adecuado para manejar ese nivel de trafico dado que, al haber sido pensado con otras prioridades, consume mas memoria y procesador que otros lenguajes como java o go por ejemplo. Sumado a esto MRI tiene el problema del [GIL](https://en.wikipedia.org/wiki/Global_interpreter_lock), el cual limita los beneficios que trae puma al atender cada request en paralelo con threads (que dicho sea de paso con MRI no son threads del sistema operativo sino manejados por el interprete) dado que dos threads no pueden correr codigo ruby al mismo tiempo. Esto se veria mitigado si esta aplicacion usara mas I/O que CPU pero este no es el caso, dado que solo se usa I/O para las estadisticas, por lo que la mayoria del tiempo se esta utilizando la CPU.
* Seguramente se debera escalar horizontalmente la aplicacion con lo cual habra varias instancias de la misma levantadas, para hacer esto de la forma mas eficiente posible entiendo que se puede usar autoscaling de AWS ECS que incluye un load balancer para distribuir el trafico de forma equitativa entre todas las instancias de la aplicacion y ademas levanta y baja instancias segun sea necesario para hacer frente a picos de trafico.
* Habria que hacer un analisis del trafico y verificar si se repiten las consultas suficientes como para implementar una cache (la cual deberia ser una instancia aparte de redis) y asi no tener que calcular varias veces el resultado de la misma consulta.
* En cuanto a redis segun [esta pagina](https://redis.io/topics/benchmarks) no parece que una sola instancia soporte el trafico requerido por lo cual, si se necesitan las estadisticas en tiempo real, se podria implementar un cluster con varias instancias de redis. Si no es necesario que las estadisticas se actualicen en tiempo real se puede mantener una sola instancia de redis e ir actualizandola paulatinamente, por ejemplo mediante background jobs con [sidekiq](https://github.com/mperham/sidekiq)
