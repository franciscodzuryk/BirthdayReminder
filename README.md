# BirthdayReminder

## Intoducción
Unit Testing es el proceso mediante el cual las partes más pequeñas de una aplicación, llamadas unidades, son validadas de forma individual e independiente para corroborar que su comportamiento sea consistente.

Son muchas las ventajas las que se obtienen cuando se implementan test unitarios en una aplicación, y es por ello que esta buena práctica está cada vez siendo más adoptada en los nuevos desarrollos. Acontinuación enumeramos las más valiosas:

* Reduce el número bugs en las aplicaciones.
* Ahorra de tiempo de desarrollo.
* Hace mas fácil el cambio y refactor de código.
* Mejora la calidad y diseño de código de las aplicaciones.
* Inspira confianza en tu propio código.
* Ayuda afrontar los problemas de antemano.

Pues bien, si eres desarrollador y estás interesado en aprender nuevas habilidades de programación para tus futuros proyectos, definitivamente esta es una de las más importantes, si no es la más importante.

En este post vamos a explicar como implementar test unitarios usando como ejemplo una aplicación que previamente hemos realizado. También explicaremos en detalle las principales características que deben tener los test y algunas técnicas.


## Manos a la obra

Antes escribir nuestro primer test debemos tener claro algunos concepto y/o características de los test unitarios:

*Velocidad:* Este es un factor fundamental, ya que los test se ejecutan frecuentemente durante el desarrollo. Inclusive se pueden lograr correr los test  muchas veces en una hora y en un mismo minuto. Por eso es vital que sean rápidos y de scopes reducidos. No existe un estándar que defina el tiempo que deben tomar los test en correr, aunque algunos autores recomiendan que no sean mayor a 10 segundos. También cabe resaltar que mientras trabajas en una parte del código de tu aplicación ya sea haciendo un refactor o agregando una nueva feature no es necesario que corras todos los test, solo aquellos que están relacionados con el código que estás desarrollando.

*Definir las unidades:* Es común pensar que los test unitarios se aplican a entidades de bajo nivel, es decir a clases en programación orientada a objetos y funciones para programación funcional. Pero en realidad esto no necesariamente tiene que ser así, la definición de cuáles van hacer la unidades más pequeñas de una aplicación está sujeta a cada equipo o desarrollador, teniendo en cuenta  cual va a ser la cobertura de los test (los explicaremos más adelante). En nuestro caso las unidades serán las clases.

*Colaboración:* Ciertas unidades testeables dependen de otras para poder funcionar. Imaginemos que tenemos una clase llamada Factura, la cual vamos a testear el método que calcula el total de una factura. Este método consume la clase productos y a la vez ejecuta el método calcular precios del mismo. Como se ve, calcular total depende de calcular precio. Es aquí donde surgen 2 nuevos conceptos, test sociables y test solitarios. Los sociables son aquellos donde sus dependencias no se aíslan, mientras que los solitarios por lo contrario son aislados completamente. En nuestro ejemplo usaremos test solitarios.
