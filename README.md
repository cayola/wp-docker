# WordPress Dockerized Setup

Este proyecto configura un entorno de desarrollo de WordPress utilizando `docker-compose`, integrando MySQL, phpMyAdmin y un contenedor de WordPress. Incluye un script Bash para gestionar permisos en el volumen `wp-content`.

## Tabla de Contenidos
- [Instalación](#instalación)
- [Servicios](#servicios)
  - [Base de Datos](#base-de-datos)
  - [phpMyAdmin](#phpmyadmin)
  - [WordPress](#wordpress)
- [Uso](#uso)
  - [Ambientes de Desarrollo y Producción](#ambientes-de-desarrollo-y-producción)
  - [Administración de Permisos](#administración-de-permisos)
- [Contribuciones](#contribuciones)
- [Licencia](#licencia)

## Instalación

1. **Requisitos Previos**: Asegúrate de tener instalados Docker y Docker Compose en tu sistema.
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
  - Usuario raíz: `root`
  - Contraseña raíz: `root`
  - Base de Datos: `wordpress`
  - Usuario WordPress: `wordpress`
  - Contraseña WordPress: `wordpress`
- **Persistencia**: Datos almacenados en un volumen Docker (`db_data`)

### phpMyAdmin
- **Imagen**: `phpmyadmin`
- **Puerto**: `8081`
- **Configuración**:
  - Permite subida de archivos hasta `500M`
  - Permite conexión arbitraria a otras bases de datos (`PMA_ARBITRARY` habilitado)

### WordPress
- **Imagen**: `wordpress:6.6.2-php8.3-apache`
- **Puerto**: `8000`
- **Configuración**:
  - Prefijo de tabla personalizado: `MOY75_`
  - Configuraciones adicionales deshabilitan cache y actualizaciones automáticas, habilitan registro de errores y despliegue local.

## Uso

### Ambientes de Desarrollo y Producción
Este proyecto incluye un script (`change_permits.sh`) que ajusta permisos en el volumen `wp-content`. Para ejecutarlo:

```bash
# Para desarrollo
bash change_permits.sh development

# Para producción
bash change_permits.sh production
```

### Administración de Permisos
El script `change_permits.sh` cambia los permisos de archivos y carpetas en `wp-content`, lo cual es útil para evitar problemas de acceso en el entorno Docker.

- **Modo Desarrollo**: Ajusta permisos para el usuario `www-data` localmente.
- **Modo Producción**: Ajusta permisos en el contenedor WordPress a `www-data:www-data`.

## Contribuciones

Las contribuciones son bienvenidas. Por favor, sigue estos pasos:
1. Haz un fork del repositorio.
2. Crea una rama con tu cambio: `git checkout -b mi-cambio`.
3. Haz un pull request en la rama principal con una descripción detallada de tus cambios.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.