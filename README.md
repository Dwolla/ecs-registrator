# Registrator on ECS

This Docker image adapts the [GliderLabs Registrator](https://github.com/gliderlabs/registrator) utility so it can be easily run as an ECS task.

## Sample ECS Task Definition

    {
      "family": "registrator",
      "containerDefinitions": [
        {
          "essential": true,
          "mountPoints": [
            {
              "containerPath": "/rootfs",
              "sourceVolume": "root",
              "readOnly": true
            },
            {
              "containerPath": "/var/run",
              "sourceVolume": "var_run",
              "readOnly": false
            },
            {
              "containerPath": "/sys",
              "sourceVolume": "sys",
              "readOnly": true
            },
            {
              "containerPath": "/var/lib/docker",
              "sourceVolume": "var_lib_docker",
              "readOnly": true
            },
            {
              "containerPath": "/tmp/docker.sock",
              "sourceVolume": "docker_socket",
              "readOnly": true
            }
          ],
          "memory": 80,
          "name": "registrator",
          "cpu": 10,
          "image": "dwolla/ecs-registrator:latest"
        }
      ],
      "volumes": [
        {
          "host": {
            "sourcePath": "/"
          },
          "name": "root"
        },
        {
          "host": {
            "sourcePath": "/var/run"
          },
          "name": "var_run"
        },
        {
          "host": {
            "sourcePath": "/sys"
          },
          "name": "sys"
        },
        {
          "host": {
            "sourcePath": "/var/lib/docker/"
          },
          "name": "var_lib_docker"
        },
        {
          "host": {
            "sourcePath": "/var/run/docker.sock"
          },
          "name": "docker_socket"
        }
      ]
    }
