output "tenant_id" {
  description = <<-EOF
    The tenant ID used for this subscription.

EOF

  value = var.arm_tenant_id
}
