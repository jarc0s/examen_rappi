# Examen Rappi - JUAN PABLO ARCOS

Es necesario instalar los pods, por lo que se requiere se ejecute el comando:

`pod install --repo-update`
 
En el listado de las peliculas al seleccionar una pelicula cuentan con acción de 3d touch.

### Capas de la aplicación

- Persistencia : Capa encargada de gestionar los datos de la aplicación, ya sea obteniendolos por medio de un consumo de un web service (cliente), realizando un mapeo de los datos a modelos (objetos) que la aplicación pueda utilizar, almacenando la información de manera local en la aplicación.
- Vistas : Capa encargada de interactuar y presentar la información al usuario de manera grafica, por medio de xib o storyboards
- Negocio : Capa encargada de ejecutar las reglas de negocio, como por ejemplo presentando el listado de peliculas deseado, buscando la pelicula deseada.

### Responsabilida de cada clase creada

- Persistencia
	- ServiceManager : Clase encargada de comunicarse con el api rest de The Movi Database, por medio de Alamofire.
	- ApiRouterMovies : Clase encargada de realizar el armado de la url y body dedicado a los metodos de *movie*
	- ApiUtil : Clase que crea el request, headers y body.
	- DataSourceManager : Clase encargada de realizar el almacenado y consulta de la información.
	- MoviesListModel : Objeto DAO que sirve para el mapeo del json response de los servicios.
	- ResultMovieModel : Objeto DAO que sirve para el mapeo del json response de los servicios.
	- VideosModel : Objeto DAO que sirve para el mapeo del json response de los servicios.
	- ResultTvModel : Objeto DAO que sirve para el mapeo del json response de los servicios.
- Vistas
	- Main.storyboard : Interface que sirve para el diseño de la user experience, y sirve de apoyo visual para el flujo de la aplicación.
- Negocio
	- ViewController : Clase encargada de comunicar las acciones de la capa vista con la capa de persistencia en el home de la aplicación.
	- MoviesTvsShowTableViewController, MoviesTvsShowCollectionViewController : Clase encargada de comunicar las acciones de la capa vista con la capa de persistencia en la pantalla que presenta el listado de las peliculas/series.
	- MovieDetailViewController : Clase encargada de comunicar las acciones de la capa vista con la capa de persistencia en la pantalla que presenta el detalle de la pelicula/serie seleccionada.
	- SplashViewController : Clase encargada de comunicar las acciones de la capa vista con la capa de persistencia en la pantalla que presenta la animación de Splash.
	- SettingasViewController : Clase encargada de comunicar las preferencias del usuario.

### Preguntas

- ¿En qué consiste el principio de responsabilidad única? 
	- Consiste en establecer que cada clase, modulo y funciones deben de cumplir con una parte de la funcionalidad , y esta debe de estar encapsulada.
- ¿Cuál es su propósito?
	- Tener una arquitectura mas limpia, y mejorar la estructura de los proyectos.
- ¿Qué características tiene, según su opinión, un “buen” código o código limpio?
	- Debe ser codigo facil de entender, de dar mantenimiento y de hacer robusto para futuras mejoras y/o cambios, separar el desarrollo de la aplicación por capas y clases.
	
