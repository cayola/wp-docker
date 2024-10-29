# WordPress Dockerized Setup

Este proyecto configura un entorno de desarrollo de WordPress utilizando `docker-compose`, integrando MySQL, phpMyAdmin y un contenedor de WordPress. Incluye un script Bash para gestionar permisos en el volumen `wp-content`.

## Tabla de Contenidos
- [Instalaci�n](#instalaci�n)
- [Servicios](#servicios)
  - [Base de Datos](#base-de-datos)
  - [phpMyAdmin](#phpmyadmin)
  - [WordPress](#wordpress)
- [Uso](#uso)
  - [Ambientes de Desarrollo y Producci�n](#ambientes-de-desarrollo-y-producci�n)
  - [Administraci�n de Permisos](#administraci�n-de-permisos)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

## Instalaci�n

1. **Requisitos Previos**: Aseg�rate de tener instalados Docker y Docker Compose en tu sistema.
2. **Clonar el Repositorio**:
   ```bash
   git clone git@github.com:cayola/wp-docker.git
   cd wp-docker
   ```
3. **Iniciar los Servicios**:
   ```bash
   docker-compose up -d
   ```

## Servicios

### Base de Datos
- **Imagen**: `mysql:8.4.2`
- **Puerto**: `3306`
- **Credenciales**: 
  - Usuario ra�z: `root`
  - Contrase�a ra�z: `root`
  - Base de Datos: `wordpress`
  - Usuario WordPress: `wordpress`
  - Contrase�a WordPress: `wordpress`
- **Persistencia**: Datos almacenados en un volumen Docker (`db_data`)

### phpMyAdmin
- **Imagen**: `phpmyadmin`
- **Puerto**: `8081`
- **Configuraci�n**:
  - Permite subida de archivos hasta `500M`
  - Permite conexi�n arbitraria a otras bases de datos (`PMA_ARBITRARY` habilitado)

### WordPress
- **Imagen**: `wordpress:6.6.2-php8.3-apache`
- **Puerto**: `8000`
- **Configuraci�n**:
  - Prefijo de tabla personalizado: `MOY75_`
  - Configuraciones adicionales deshabilitan cache y actualizaciones autom�ticas, habilitan registro de errores y despliegue local.

## Uso

### Ambientes de Desarrollo y Producci�n
Este proyecto incluye un script (`change_permits.sh`) que ajusta permisos en el volumen `wp-content`. Para ejecutarlo:

```bash
# Para desarrollo
bash change_permits.sh development

# Para producci�n
bash change_permits.sh production
```

### Administraci�n de Permisos
El script `change_permits.sh` cambia los permisos de archivos y carpetas en `wp-content`, lo cual es �til para evitar problemas de acceso en el entorno Docker.

- **Modo Desarrollo**: Ajusta permisos para el usuario `www-data` localmente.
- **Modo Producci�n**: Ajusta permisos en el contenedor WordPress a `www-data:www-data`.

## Contribuciones

Las contribuciones son bienvenidas. Por favor, sigue estos pasos:
1. Haz un fork del repositorio.
2. Crea una rama con tu cambio: `git checkout -b mi-cambio`.
3. Haz un pull request en la rama principal con una descripci�n detallada de tus cambios.

## Licencia

Este proyecto est� licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para m�s detalles.