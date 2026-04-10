output "alb_url" {
  description = "URL del balanceador de carga — apuntale JMeter aqui"
  value       = "http://${aws_lb.app.dns_name}"
}

output "rds_host" {
  description = "Host de la base de datos PostgreSQL"
  value       = aws_db_instance.postgres.address
}

output "redis_host" {
  description = "Host de Redis"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "jmeter_ip" {
  description = "IP publica de la instancia JMeter"
  value       = aws_instance.jmeter.public_ip
}
