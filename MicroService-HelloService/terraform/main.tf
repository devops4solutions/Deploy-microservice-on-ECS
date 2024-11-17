module "ecs-fargate-service" {
  source              = "../../modules/ecs-fargate-service"
  vpc_id              = var.vpc_id
  application         = var.application
  region              = var.region
  ecs_cluster         = "${var.environment}-cluster"
  lb_name             = "${var.environment}-alb"
  environment         = var.environment
  container_version   = var.container_version
  log_group_name      = "dev/hello-service"
  ecr_repository_name = "veridiant/springboot-app"
  port                = 80
  health_check_path   = "/hello"
  cloudmap_namespace  = "corp"
  cpu                 = "512"
  memory              = "1024"
  path_pattern        = "hello"
}
