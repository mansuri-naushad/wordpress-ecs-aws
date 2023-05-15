[
  {
    "name": "${ecs_service_container_name}",
    "image": "561879076809.dkr.ecr.eu-north-1.amazonaws.com/vaxxa-image:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "protocol": "tcp"
      }
    ],
    "secrets": [{
      "name": "WORDPRESS_DB_PASSWORD",
      "value": "admin123"
    }],
    "environment": [
      {
        "name": "WORDPRESS_DB_HOST",
        "value": "database-1.cm1f1la7e4ig.eu-west-1.rds.amazonaws.com"
      },
      {
        "name": "WORDPRESS_DB_USER",
        "value": "admin"
      },
      {
        "name": "WORDPRESS_DB_NAME",
        "value": "wp_vaxxa"
      }
    ],
    "logConfiguration": { 
      "logDriver": "awslogs",
      "options": { 
        "awslogs-group" : "${cloudwatch_log_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "wordpress"
      }
    }, 
    "mountPoints": [
      {
        "readOnly": false,
        "containerPath": "/var/www/html/wp-content/themes",
        "sourceVolume": "efs-themes"
      },
      {
        "readOnly": false,
        "containerPath": "/var/www/html/wp-content/plugins",
        "sourceVolume": "efs-plugins"
      }
    ]
  }
]
