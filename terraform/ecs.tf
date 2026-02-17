resource "aws_ecs_cluster" "main" {
  name = "strapi-cluster"
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu    = "512"
  memory = "1024"

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = "${aws_ecr_repository.strapi_repo.repository_url}:latest"

      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "NODE_ENV", value = "production" },
        { name = "APP_KEYS", value = "appKey1,appKey2,appKey3,appKey4" },
        { name = "API_TOKEN_SALT", value = "randomSalt123" },
        { name = "ADMIN_JWT_SECRET", value = "superSecretAdmin" },
        { name = "JWT_SECRET", value = "superSecretJwt" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/strapi"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }

      essential = true
    }
  ])
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public[*].id
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }
}

