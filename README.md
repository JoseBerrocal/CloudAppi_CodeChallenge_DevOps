# CloudAppi CodeChallenge DevOps

## Vision General

Se desea en este proyecto crear un NodeJs web API, asi como la infraestrucura pertinente para desplegar la aplicacion. Adicionalmente el proyecto cuenta con test para comprobar el funcionamiendo de la web API desplegada

Este proyecto incluye las siguiente tecnologias:
- CloudFormation
- Jenkins
- Despliegue Rolling
- Docker
- Kubernetes
- Swagger

## Tareas del Proyecto

El objetivo es habilitar un API REST usando [kubernetes](https://kubernetes.io/), que es un sistema open-source para la automatización del manejor de aplicaciones en contenedores. Este proyecto se hizo lo siguiente:
* Se creo un node NodeJs usando swagger teniendo como base el siguiente [link](https://s3-eu-west-1.amazonaws.com/mmi-codechallenge/swagger-users-v1.json)
* Se configuro Kubernetes, Docker
* Se creo un contendor del API haciendo uso del Dockerfile
* Se uso cloudformation para configurar la infraestructura VPC, crear el cluster kubernetes y los nodes kubernetes
* Desplegar el container usando Kubernetes y acceder a la API por web
* Se crearon pruebas Postman para comprobar las funcionalidades basicas y tambien pruebas Jmeter para comprobar el performance del API antes estres

---

## Instalación del Ambiente

Es necesario tener configurado el servidor jenkins, con los plugins que permitiran el uso de cloudformation, kubenetes y docker. Adicionalmente se debe instalar localmente Postman y Jmeter.

---

### Completar el despliege

Para desplegar el API se debe ejecutar la rama **master**

Cuando la rama **master** se ejecuta las siguiente etapas del Jenkinsfile se ejecutan:
- Probando Jenkins
- Desplegar Infraestructura
- Construir Imagen Docker
- Subir la Imagen Docker
- Remover la Imagen Docker
- Desplegar la web API


### Pruebas respecto al API

Para hacer las pruebas postman

```bash
npm install newman
newman run testing/postman_testing/Test_Collection_postman.json -e testing/postman_testing/Env_Test_Collection_postman.json --reporters cli,json --reporter-json-export testing/postman_testing/Result/junitReport.json
```

Para hacer las pruebas de estres Jmeter

```bash
cd testing/jmeter_testing
sh script_stress_test.sh
```
Los resultado se podran visualizar usando la aplicación jmeter ó ingresando a la version web de los resultado en la carpeta "testing/jmeter_testing/Reportes_HTML"

