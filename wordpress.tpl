[
  {
    "name": "${ecs_service_container_name}",
    "image": "807410046616.dkr.ecr.eu-west-1.amazonaws.com/api@sha256:f16104b3e032cf2022e3c66bc026bcbdbefd1379d2059e9baa2f9caddd40825f",
    "portMappings": [
      {
        "containerPort": 80,
        "protocol": "tcp"
      }
    ],
    "secrets": [{
      "name": "WORDPRESS_DB_PASSWORD",
      "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account_id}:secret:${secret_name}:WORDPRESS_DB_PASSWORD::"
    }],
    "environment": [
      {
        "name": "WORDPRESS_DB_HOST",
        "value": "${wordpress_db_host}"
      },
      {
        "name": "WORDPRESS_DB_USER",
        "value": "${wordpress_db_user}"
      },
      {
        "name": "WORDPRESS_DB_NAME",
        "value": "${wordpress_db_name}"
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
