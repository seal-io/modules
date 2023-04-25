resource "kubernetes_deployment" "deploy_app" {
  wait_for_rollout = var.wait_for_rollout

  metadata {
    name        = var.name
    namespace   = var.namespace
    labels      = var.deployment_labels
    annotations = var.deployment_annotations
  }

  spec {
    replicas = var.replicas

    # --- Deployment/Scaling and Upgrade Policy ---
    strategy {
      type = var.strategy
      dynamic "rolling_update" {
        for_each = var.strategy == "RollingUpdate" ? [1] : []
        content {
          max_surge       = var.max_surge
          max_unavailable = var.max_unavailable
        }
      }
    }

    min_ready_seconds         = var.min_ready_seconds
    revision_history_limit    = var.revision_history_limit
    progress_deadline_seconds = var.progress_deadline
    # --- Deployment/Scaling and Upgrade Policy ---

    selector {
      match_labels = local.labels
    }

    template {
      # -- Pod/Labels & Annotation ---
      metadata {
        labels      = local.labels
        annotations = var.template_annotations
      }
      # --- Pod/Labels & Annotation ---

      spec {
        # --- Pod/Networking/Settings ---
        host_network = var.networking_mode == "HostNetwork" ? true : null
        dns_policy   = var.dns_policy
        hostname     = var.hostname
        subdomain    = var.subdomain
        # --- Pod/Networking/Settings ---

        # --- Pod/Networking/DNS ---
        dns_config {
          nameservers = var.nameservers
          searches    = var.search_domains
          dynamic "option" {
            for_each = var.resolver_options
            content {
              name  = option.value.name
              value = option.value.value
            }
          }
        }

        dynamic "host_aliases" {
          iterator = hosts
          for_each = var.host_aliases
          content {
            hostnames = hosts.value.hostnames
            ip        = hosts.value.ip
          }
        }
        # --- Pod/Networking/DNS ---

        # --- Pod/Scheduling ---
        node_name = var.node_name
        dynamic "affinity" {
          for_each = length(var.node_affinity) > 0 || length(var.pod_affinity) > 0 || length(var.pod_anti_affinity) > 0 ? ["affinity"] : []
          content {
            dynamic "node_affinity" {
              for_each = length(var.node_affinity) > 0 ? var.node_affinity : []
              content {
                dynamic "preferred_during_scheduling_ignored_during_execution" {
                  for_each = node_affinity.value["preferred_during_scheduling_ignored_during_execution"] != null ? node_affinity.value["preferred_during_scheduling_ignored_during_execution"] : []
                  content {
                    weight = preferred_during_scheduling_ignored_during_execution.value["weight"]
                    dynamic "preference" {
                      for_each = preferred_during_scheduling_ignored_during_execution.value["preference"]
                      content {
                        dynamic "match_expressions" {
                          for_each = preference.value["match_expressions"]
                          content {
                            key      = match_expressions.value["key"]
                            operator = match_expressions.value["operator"]
                            values   = match_expressions.value["values"]
                          }
                        }
                      }
                    }
                  }
                }
                dynamic "required_during_scheduling_ignored_during_execution" {
                  for_each = node_affinity.value["required_during_scheduling_ignored_during_execution"] != null ? node_affinity.value["required_during_scheduling_ignored_during_execution"] : []
                  content {
                    dynamic "node_selector_term" {
                      for_each = required_during_scheduling_ignored_during_execution.value.value["node_selector_term"]
                      content {
                        dynamic "match_expressions" {
                          for_each = node_selector_term.value["match_expressions"]
                          content {
                            key      = match_expressions.value["key"]
                            operator = match_expressions.value["operator"]
                            values   = match_expressions.value["values"]
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
            dynamic "pod_affinity" {
              for_each = length(var.pod_affinity) > 0 ? var.pod_affinity : []
              content {
                dynamic "preferred_during_scheduling_ignored_during_execution" {
                  for_each = pod_affinity.value["preferred_during_scheduling_ignored_during_execution"] != null ? pod_affinity.value["preferred_during_scheduling_ignored_during_execution"] : []
                  content {
                    weight = preferred_during_scheduling_ignored_during_execution.value["weight"]
                    dynamic "pod_affinity_term" {
                      for_each = preferred_during_scheduling_ignored_during_execution.value["pod_affinity_term"] != null ? preferred_during_scheduling_ignored_during_execution.value["pod_affinity_term"] : null
                      content {
                        namespaces   = lookup(pod_affinity_term, "namespaces", [])
                        topology_key = lookup(pod_affinity_term, "topology_key", "")
                        label_selector {
                          match_labels = lookup(pod_affinity_term.value["label_selector"], "match_labels", {})
                          dynamic "match_expressions" {
                            for_each = { for v in lookup(pod_affinity_term.value["label_selector"], "match_expressions", []) : uuid() => v }
                            content {
                              key      = match_expressions.value["key"]
                              operator = match_expressions.value["operator"]
                              values   = lookup(match_expressions.value, "values", [])
                            }
                          }
                        }
                      }
                    }
                  }
                }
                dynamic "required_during_scheduling_ignored_during_execution" {
                  for_each = pod_affinity.value["required_during_scheduling_ignored_during_execution"] != null ? pod_affinity.value["required_during_scheduling_ignored_during_execution"] : []
                  content {
                    label_selector {
                      match_labels = lookup(required_during_scheduling_ignored_during_execution.value["label_selector"], "match_labels", {})
                      dynamic "match_expressions" {
                        for_each = required_during_scheduling_ignored_during_execution.value["label_selector"]["match_expressions"]
                        content {
                          key      = match_expressions.value["key"]
                          operator = match_expressions.value["operator"]
                          values   = lookup(match_expressions.value, "values", [])
                        }
                      }
                    }
                    namespaces   = lookup(required_during_scheduling_ignored_during_execution.value, "namespaces", [])
                    topology_key = lookup(required_during_scheduling_ignored_during_execution.value, "topology_key", "")
                  }
                }
              }
            }

            dynamic "pod_anti_affinity" {
              for_each = length(var.pod_anti_affinity) > 0 ? var.pod_anti_affinity : []
              content {
                dynamic "preferred_during_scheduling_ignored_during_execution" {
                  for_each = pod_anti_affinity.value["preferred_during_scheduling_ignored_during_execution"] != null ? pod_anti_affinity.value["preferred_during_scheduling_ignored_during_execution"] : []
                  content {
                    weight = preferred_during_scheduling_ignored_during_execution.value["weight"]
                    dynamic "pod_affinity_term" {
                      for_each = preferred_during_scheduling_ignored_during_execution.value["pod_affinity_term"] != null ? preferred_during_scheduling_ignored_during_execution.value["pod_affinity_term"] : null
                      content {
                        namespaces   = lookup(pod_affinity_term, "namespaces", [])
                        topology_key = lookup(pod_affinity_term, "topology_key", "")
                        label_selector {
                          match_labels = lookup(pod_affinity_term.value["label_selector"], "match_labels", {})
                          dynamic "match_expressions" {
                            for_each = { for v in lookup(pod_affinity_term.value["label_selector"], "match_expressions", []) : uuid() => v }
                            content {
                              key      = match_expressions.value["key"]
                              operator = match_expressions.value["operator"]
                              values   = lookup(match_expressions.value, "values", [])
                            }
                          }
                        }
                      }
                    }
                  }
                }
                dynamic "required_during_scheduling_ignored_during_execution" {
                  for_each = pod_anti_affinity.value["required_during_scheduling_ignored_during_execution"] != null ? pod_anti_affinity.value["required_during_scheduling_ignored_during_execution"] : []
                  content {
                    label_selector {
                      match_labels = lookup(required_during_scheduling_ignored_during_execution.value["label_selector"], "match_labels", {})
                      dynamic "match_expressions" {
                        for_each = required_during_scheduling_ignored_during_execution.value["label_selector"]["match_expressions"]
                        content {
                          key      = match_expressions.value["key"]
                          operator = match_expressions.value["operator"]
                          values   = lookup(match_expressions.value, "values", [])
                        }
                      }
                    }
                    namespaces   = lookup(required_during_scheduling_ignored_during_execution.value, "namespaces", [])
                    topology_key = lookup(required_during_scheduling_ignored_during_execution.value, "topology_key", "")
                  }
                }
              }
            }
          }
        }

        dynamic "toleration" {
          for_each = var.toleration
          content {
            effect             = lookup(toleration.value, "effect", null)
            key                = lookup(toleration.value, "key", null)
            operator           = lookup(toleration.value, "operator", null)
            toleration_seconds = lookup(toleration.value, "toleration_seconds", null)
            value              = lookup(toleration.value, "value", null)
          }
        }
        # --- Pod/Scheduling ---

        # --- Pod/Resources ---
        priority_class_name = var.priority_class_name
        # --- Pod/Resources ---

        # --- Pod/Scaling and Upgrade Policy ---
        termination_grace_period_seconds = var.termination_grace_period_seconds
        restart_policy                   = var.restart_policy
        # --- Pod/Scaling and Upgrade Policy ---

        # --- Pod/Security Context ---
        security_context {
          fs_group = var.fs_group
        }
        service_account_name            = var.service_account_name
        automount_service_account_token = var.auto_mounted_service_account_token
        # --- Pod/Security Context ---

        dynamic "image_pull_secrets" {
          for_each = var.image_pull_secrets
          content {
            name = image_pull_secrets.value
          }
        }

        # --- Pod/Storage ---
        dynamic "volume" {
          for_each = var.volume_empty_dir
          content {
            empty_dir {
              medium     = lookup(volume.value, "medium", null)
              size_limit = lookup(volume.value, "size_limit", null)
            }
            name = volume.value.volume_name
          }
        }

        dynamic "volume" {
          for_each = var.volume_config_map
          content {
            config_map {
              default_mode = volume.value.mode
              name         = volume.value.name
              optional     = lookup(volume.value, "optional", null)
              dynamic "items" {
                for_each = lookup(volume.value, "items", [])
                content {
                  key  = items.value.key
                  path = items.value.path
                  mode = lookup(items.value, "mode", null)
                }
              }
            }
            name = volume.value.volume_name
          }
        }

        dynamic "volume" {
          for_each = var.volume_secret
          content {
            secret {
              secret_name  = volume.value.secret_name
              default_mode = lookup(volume.value, "default_mode", null)
              optional     = lookup(volume.value, "optional", null)
              dynamic "items" {
                for_each = lookup(volume.value, "items", [])
                content {
                  key  = items.value.key
                  path = items.value.path
                  mode = lookup(items.value, "mode", null)
                }
              }
            }
            name = volume.value.volume_name
          }
        }

        dynamic "volume" {
          for_each = var.volume_claim
          content {
            persistent_volume_claim {
              claim_name = lookup(volume.value, "claim_name", null)
              read_only  = lookup(volume.value, "read_only", null)
            }
            name = volume.value.volume_name
          }
        }
        # --- Pod/Storage ---

        container {
          # --- Container/General ---
          name              = var.name
          image             = var.image
          image_pull_policy = var.image_pull_policy
          args              = var.args
          command           = var.command
          working_dir       = var.working_dir
          stdin_once        = var.stdin == "Once" ? true : false
          stdin             = var.stdin == "Yes" ? true : false
          tty               = var.tty

          dynamic "env" {
            for_each = local.env
            content {
              name  = env.value.name
              value = env.value.value
            }
          }

          dynamic "port" {
            for_each = var.ports
            content {
              container_port = port.value.internal_port
              name           = substr(port.value.name, 0, 14)
              host_port      = lookup(port.value, "host_port", null)
            }
          }

          dynamic "lifecycle" {
            for_each = flatten([var.lifecycle_events])
            content {
              dynamic "pre_stop" {
                for_each = contains(keys(lifecycle.value), "pre_stop") ? [lifecycle.value.pre_stop] : []

                content {
                  dynamic "http_get" {
                    for_each = contains(keys(pre_stop.value), "http_get") ? [pre_stop.value.http_get] : []

                    content {
                      path   = http_get.value != null ? lookup(http_get.value, "path", null) : null
                      port   = http_get.value != null ? lookup(http_get.value, "port", null) : null
                      scheme = http_get.value != null ? lookup(http_get.value, "scheme", null) : null
                      host   = http_get.value != null ? lookup(http_get.value, "host", null) : null

                      dynamic "http_header" {
                        for_each = contains(keys(http_get.value), "http_header") ? http_get.value.http_header : []
                        content {
                          name  = http_header.value.name
                          value = http_header.value.value
                        }
                      }
                    }
                  }

                  dynamic "exec" {
                    for_each = contains(keys(pre_stop.value), "exec") ? [pre_stop.value.exec] : []

                    content {
                      command = exec.value.command
                    }
                  }

                  dynamic "tcp_socket" {
                    for_each = contains(keys(pre_stop.value), "tcp_socket") ? [pre_stop.value.tcp_socket] : []
                    content {
                      port = tcp_socket.value.port
                    }
                  }
                }
              }

              dynamic "post_start" {
                for_each = contains(keys(lifecycle.value), "post_start") ? [lifecycle.value.post_start] : []

                content {
                  dynamic "http_get" {
                    for_each = contains(keys(post_start.value), "http_get") ? [post_start.value.http_get] : []

                    content {
                      path   = lookup(http_get.value, "path", null)
                      port   = lookup(http_get.value, "port", null)
                      scheme = lookup(http_get.value, "scheme", null)
                      host   = lookup(http_get.value, "host", null)

                      dynamic "http_header" {
                        for_each = contains(keys(http_get.value), "http_header") ? http_get.value.http_header : []
                        content {
                          name  = http_header.value.name
                          value = http_header.value.value
                        }
                      }

                    }
                  }

                  dynamic "exec" {
                    for_each = contains(keys(post_start.value), "exec") ? [post_start.value.exec] : []

                    content {
                      command = exec.value.command
                    }
                  }

                  dynamic "tcp_socket" {
                    for_each = contains(keys(post_start.value), "tcp_socket") ? [post_start.value.tcp_socket] : []
                    content {
                      port = tcp_socket.value.port
                    }
                  }
                }
              }

            }
          }

          # --- Container/Health Check ---
          dynamic "liveness_probe" {
            for_each = flatten([var.liveness_probe])
            content {
              initial_delay_seconds = lookup(liveness_probe.value, "initial_delay_seconds", null)
              period_seconds        = lookup(liveness_probe.value, "period_seconds", null)
              timeout_seconds       = lookup(liveness_probe.value, "timeout_seconds", null)
              success_threshold     = lookup(liveness_probe.value, "success_threshold", null)
              failure_threshold     = lookup(liveness_probe.value, "failure_threshold", null)

              dynamic "http_get" {
                for_each = contains(keys(liveness_probe.value), "http_get") ? [liveness_probe.value.http_get] : []

                content {
                  path   = lookup(http_get.value, "path", null)
                  port   = lookup(http_get.value, "port", null)
                  scheme = lookup(http_get.value, "scheme", null)
                  host   = lookup(http_get.value, "host", null)

                  dynamic "http_header" {
                    for_each = contains(keys(http_get.value), "http_header") ? http_get.value.http_header : []
                    content {
                      name  = http_header.value.name
                      value = http_header.value.value
                    }
                  }

                }
              }

              dynamic "exec" {
                for_each = contains(keys(liveness_probe.value), "exec") ? [liveness_probe.value.exec] : []

                content {
                  command = exec.value.command
                }
              }

              dynamic "tcp_socket" {
                for_each = contains(keys(liveness_probe.value), "tcp_socket") ? [liveness_probe.value.tcp_socket] : []
                content {
                  port = tcp_socket.value.port
                }
              }
            }
          }

          dynamic "readiness_probe" {
            for_each = flatten([var.readiness_probe])
            content {
              initial_delay_seconds = lookup(readiness_probe.value, "initial_delay_seconds", null)
              period_seconds        = lookup(readiness_probe.value, "period_seconds", null)
              timeout_seconds       = lookup(readiness_probe.value, "timeout_seconds", null)
              success_threshold     = lookup(readiness_probe.value, "success_threshold", null)
              failure_threshold     = lookup(readiness_probe.value, "failure_threshold", null)

              dynamic "http_get" {
                for_each = contains(keys(readiness_probe.value), "http_get") ? [readiness_probe.value.http_get] : []

                content {
                  path   = lookup(http_get.value, "path", null)
                  port   = lookup(http_get.value, "port", null)
                  scheme = lookup(http_get.value, "scheme", null)
                  host   = lookup(http_get.value, "host", null)

                  dynamic "http_header" {
                    for_each = contains(keys(http_get.value), "http_header") ? http_get.value.http_header : []
                    content {
                      name  = http_header.value.name
                      value = http_header.value.value
                    }
                  }

                }
              }

              dynamic "exec" {
                for_each = contains(keys(readiness_probe.value), "exec") ? [readiness_probe.value.exec] : []

                content {
                  command = exec.value.command
                }
              }

              dynamic "tcp_socket" {
                for_each = contains(keys(readiness_probe.value), "tcp_socket") ? [readiness_probe.value.tcp_socket] : []
                content {
                  port = tcp_socket.value.port
                }
              }
            }
          }

          dynamic "startup_probe" {
            for_each = flatten([var.startup_probe])
            content {
              initial_delay_seconds = lookup(startup_probe.value, "initial_delay_seconds", null)
              period_seconds        = lookup(startup_probe.value, "period_seconds", null)
              timeout_seconds       = lookup(startup_probe.value, "timeout_seconds", null)
              success_threshold     = lookup(startup_probe.value, "success_threshold", null)
              failure_threshold     = lookup(startup_probe.value, "failure_threshold", null)

              dynamic "http_get" {
                for_each = contains(keys(startup_probe.value), "http_get") ? [startup_probe.value.http_get] : []

                content {
                  path   = lookup(http_get.value, "path", null)
                  port   = lookup(http_get.value, "port", null)
                  scheme = lookup(http_get.value, "scheme", null)
                  host   = lookup(http_get.value, "host", null)

                  dynamic "http_header" {
                    for_each = contains(keys(http_get.value), "http_header") ? http_get.value.http_header : []
                    content {
                      name  = http_header.value.name
                      value = http_header.value.value
                    }
                  }
                }
              }

              dynamic "exec" {
                for_each = contains(keys(startup_probe.value), "exec") ? [startup_probe.value.exec] : []

                content {
                  command = exec.value.command
                }
              }

              dynamic "tcp_socket" {
                for_each = contains(keys(startup_probe.value), "tcp_socket") ? [startup_probe.value.tcp_socket] : []
                content {
                  port = tcp_socket.value.port
                }
              }
            }
          }
          # --- Container/Health Check ---

          # --- Container/Resources ---
          resources {
            requests = {
              cpu    = var.request_cpu == "" ? null : var.request_cpu
              memory = var.request_memory == "" ? null : var.request_memory
            }
            limits = {
              cpu    = var.limit_cpu == "" ? null : var.limit_cpu
              memory = var.limit_memory == "" ? null : var.limit_memory
            }
          }
          # --- Container/Resources ---

          # --- Container/Security Context ---
          security_context {
            privileged                 = var.privileged
            allow_privilege_escalation = var.privileged_escalation
            read_only_root_filesystem  = var.read_only_root_filesystem
            run_as_non_root            = var.run_as_non_root
          }

          # --- Container/Security Context ---
        }
      }
    }
  }
}

locals {
  env = flatten([
    for name, value in var.env : {
      name  = tostring(name)
      value = tostring(value)
    }
  ])

  labels = var.template_labels != null ? var.template_labels : { "app" : var.name }
}
