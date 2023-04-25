# @label "Deployment Name"
# @group "Basic"
variable "name" {
  type        = string
  description = "Name of the deployment"
}

# @label "Namespace"
# @group "Basic"
variable "namespace" {
  type        = string
  description = "Namespace in which to create the deployment"
  default     = "default"
}

# @label "Replicas"
# @group "Basic"
variable "replicas" {
  type        = number
  description = "Count of pods"
  default     = 1
}

# @label "Wait For Rollout"
# @group "Basic"
variable "wait_for_rollout" {
  type        = bool
  description = "Wait for the deployment to successfully roll out."
  default     = true
}

# @label "Container Name"
# @group "Container/General"
variable "container_name" {
  type        = string
  description = "Name of the container"
}

# @label "Image"
# @group "Container/General/Image"
variable "image" {
  type        = string
  description = "Docker image name"
}

# @label "Image Pull Policy"
# @group "Container/General/Image"
# @options ["Always","IfNotPresent","Never"]
variable "image_pull_policy" {
  type        = string
  default     = "IfNotPresent"
  description = "Always. Always pull the image. ; IfNotPresent. Only pull the image if it does not already exist on the node. ; Never. Never pull the image."
}

# @label "Image Pull Secret"
# @group "Container/General/Image"
variable "image_pull_secrets" {
  description = "Specify list of pull secrets"
  type        = list(string)
  default     = []
}

# @label "Ports"
# @group "Container/General/Ports"
variable "ports" {
  type = list(object({
    name          = string
    internal_port = number
    host_port     = optional(string)
  }))
  description = "List of ports to expose from the container"
  default     = []
}

# @label "Command"
# @group "Container/General/Command"
variable "command" {
  type        = list(string)
  description = "Entrypoint array. Not executed within a shell"
  default     = []
}

# @label "Arguments"
# @group "Container/General/Command"
variable "args" {
  type        = list(string)
  description = "Arguments to the entrypoint"
  default     = []
}

# @label "Working Dir"
# @group "Container/General/Command"
variable "working_dir" {
  description = "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image."
  type        = string
  default     = null
}

# @label "Stdin"
# @group "Container/General/Command"
# @options ["No","Once","Yes"]
variable "stdin" {
  description = "Stdin for container"
  type        = string
  default     = "No"
}

# @label "TTY"
# @group "Container/General/Command"
variable "tty" {
  description = "Whether this container should allocate a TTY for itself"
  type        = bool
  default     = true
}

# @label "Environment Variables"
# @group "Container/General"
variable "env" {
  type        = map(string)
  description = "Name and value pairs to set in the container's environment"
  default     = {}
}

# @label "Lifecycle Hooks"
# @group "Container/General"
variable "lifecycle_events" {
  type = list(object({
    pre_stop = optional(object({
      initial_delay_seconds = optional(string)
      period_seconds        = optional(string)
      timeout_seconds       = optional(string)
      success_threshold     = optional(string)
      failure_threshold     = optional(string)
      http_get = optional(object({
        path   = string
        port   = string
        scheme = string
        host   = string
        http_header = list(object({
          name  = string
          value = string
        }))
      }))
      exec = optional(object({
        command = list(string)
      }))
      tcp_socket = optional(object({
        port = number
      }))
    }))
    post_start = optional(object({
      initial_delay_seconds = optional(string)
      period_seconds        = optional(string)
      timeout_seconds       = optional(string)
      success_threshold     = optional(string)
      failure_threshold     = optional(string)
      http_get = optional(object({
        path   = string
        port   = string
        scheme = string
        host   = string
        http_header = list(object({
          name  = string
          value = string
        }))
      }))
      exec = optional(object({
        command = list(string)
      }))
      tcp_socket = optional(object({
        port = number
      }))
    }))
  }))
  description = "Actions that the management system should take in response to container lifecycle events, include postStart and preStop"
  default     = []
}

# @label "Readiness Checks"
# @group "Container/Health Check"
variable "readiness_probe" {
  type = list(object({
    initial_delay_seconds = string
    period_seconds        = string
    timeout_seconds       = string
    success_threshold     = string
    failure_threshold     = string
    http_get = object({
      path   = string
      port   = string
      scheme = string
      host   = string
      http_header = list(object({
        name  = string
        value = string
      }))
    })
    exec = object({
      command = list(string)
    })
    tcp_socket = object({
      port = number
    })
  }))
  description = "Container will be removed from service endpoints if the probe fails."
  default     = []
}

# @label "Liveness Checks"
# @group "Container/Health Check"
variable "liveness_probe" {
  type = list(object({
    initial_delay_seconds = optional(string)
    period_seconds        = optional(string)
    timeout_seconds       = optional(string)
    success_threshold     = optional(string)
    failure_threshold     = optional(string)
    http_get = optional(object({
      path   = string
      port   = string
      scheme = string
      host   = string
      http_header = optional(list(object({
        name  = string
        value = string
      })))
    }))
    exec = optional(object({
      command = list(string)
    }))
    tcp_socket = optional(object({
      port = number
    }))
  }))
  description = "Container will be restarted if the probe fails."
  default     = []
}

# @label "Startup Checks"
# @group "Container/Health Check"
variable "startup_probe" {
  type = list(object({
    initial_delay_seconds = string
    period_seconds        = string
    timeout_seconds       = string
    success_threshold     = string
    failure_threshold     = string
    http_get = object({
      path   = string
      port   = string
      scheme = string
      host   = string
      http_header = list(object({
        name  = string
        value = string
      }))
    })
    exec = object({
      command = list(string)
    })
    tcp_socket = object({
      port = number
    })
  }))
  description = "Container will wait util this check succeeds before attempting other health checks."
  default     = []
}

# @label "CPU Request"
# @group "Container/Resources"
variable "request_cpu" {
  type        = string
  description = "CPU request. e.g. 0.5, 1, 2"
  default     = "0.1"
}

# @label "Memory Request"
# @group "Container/Resources"
variable "request_memory" {
  type        = string
  description = "Memory request. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = "128Mi"
}

# @label "CPU Limit"
# @group "Container/Resources"
variable "limit_cpu" {
  type        = string
  description = "CPU limit. e.g. 0.5, 1, 2"
  default     = ""
}

# @label "Memory Limit"
# @group "Container/Resources"
variable "limit_memory" {
  type        = string
  description = "Memory limit. e.g. 128Mi, 512Mi, 1Gi, 2Gi, 4Gi"
  default     = ""
}

# @label "Privileged"
# @group "Container/Security Context"
variable "privileged" {
  type        = bool
  description = "Whether this container has full access to the host"
  default     = false
}

# @label "Privileged Escalation"
# @group "Container/Security Context"
variable "privileged_escalation" {
  type        = bool
  description = "Whether this container can gain more privileges than its parent process"
  default     = true
}

# @label "Run as Non-Root"
# @group "Container/Security Context"
variable "run_as_non_root" {
  type        = bool
  description = "Whether this container must run as a non-root user"
  default     = false
}

# @label "Read-Only Root Filesystem"
# @group "Container/Security Context"
variable "read_only_root_filesystem" {
  type        = bool
  description = "Whether this container has a read-only root filesystem"
  default     = false
}

# @label "Run as User"
# @group "Container/Security Context"
variable "run_as_user" {
  type        = string
  description = "The UID to run the entrypoint of the container process"
  default     = null
}

# @label "Add Capabilities"
# @group "Container/Security Context"
variable "add_capabilities" {
  type        = list(string)
  description = "A list of added capabilities"
  default     = null
}

# @label "Drop Capabilities"
# @group "Container/Security Context"
variable "drop_capabilities" {
  type        = list(string)
  description = "A list of removed capabilities"
  default     = null
}

# @label "Pod Labels"
# @group "Pod/Labels & Annotation"
variable "template_labels" {
  description = "Labels for pod (template)"
  type        = map(string)
  default     = null
}

# @label "Pod Annotations"
# @group "Pod/Labels & Annotation"
variable "template_annotations" {
  description = "Annotations for pod (template)"
  type        = map(string)
  default     = null
}

# @label "Network Mode"
# @group "Pod/Networking/Settings"
# @options ["Normal","HostNetwork"]
variable "networking_mode" {
  description = "Whether host networking requested for this pod"
  type        = string
  default     = "Normal"
}

# @label "DNS Policy"
# @group "Pod/Networking/Settings"
# @options ["Default","ClusterFirst","ClusterFirstWithHostNet","None"]
variable "dns_policy" {
  description = "DNS policy for containers within the pod"
  type        = string
  default     = "ClusterFirst"
}

# @label "Hostname"
# @group "Pod/Networking/Settings"
variable "hostname" {
  description = "Specifies the hostname of the Pod If not specified, the pod's hostname will be set to a system-defined value"
  type        = string
  default     = null
}

# @label "Subdomain"
# @group "Pod/Networking/Settings"
variable "subdomain" {
  description = " If specified, the fully qualified Pod hostname will be '…svc.'"
  type        = string
  default     = null
}

# @label "Nameservers"
# @group "Pod/Networking/DNS"
variable "nameservers" {
  description = "A list of DNS name server IP addresses specified as strings"
  type        = list(string)
  default     = null
}

# @label "Search Domains"
# @group "Pod/Networking/DNS"
variable "search_domains" {
  description = "A list of DNS search domains for host-name lookup specified as strings"
  type        = list(string)
  default     = null
}

# @label "Resolver Options"
# @group "Pod/Networking/DNS"
variable "resolver_options" {
  description = "A list of DNS resolver options specified as blocks with name/value pairs"
  type        = list(map(string))
  default     = []
}

# @label "Host Aliases"
# @group "Pod/Networking/DNS"
variable "host_aliases" {
  description = "List of hosts and IPs that will be injected into the pod's hosts file if specified"
  type = list(object({
    hostnames = list(string)
    ip        = string
  }))
  default = []
}

# @label "Scheduling"
# @group "Pod/Scheduling"
# @options ["Run pods on any available node","Run pods on specific node","Run pods on node(s) marching scheduling rules"]
variable "node_scheduling" {
  description = "Node scheduling"
  type        = string
  default     = "Run pods on any available node"
}

# @label "Node Name"
# @group "Pod/Scheduling"
# @show_if "node_scheduling='Run pods on specific node'"
variable "node_name" {
  description = "NodeName is a request to schedule this pod onto a specific node"
  type        = string
  default     = null
}

# @label "Node Selector"
# @group "Pod/Scheduling"
# @show_if "node_scheduling='Run pods on node(s) marching scheduling rules'"
variable "node_affinity" {
  type = list(object(
    {
      preferred_during_scheduling_ignored_during_execution = optional(list(object(
        {
          preference = list(object(
            {
              match_expressions = list(object(
                {
                  key      = string
                  operator = string
                  values   = set(string)
                }
              ))
            }
          ))
          weight = number
        }
      )))
      required_during_scheduling_ignored_during_execution = optional(list(object(
        {
          node_selector_term = list(object(
            {
              match_expressions = list(object(
                {
                  key      = string
                  operator = string
                  values   = set(string)
                }
              ))
            }
          ))
        }
      )))
    }
  ))

  default = []
}

# @label "Pod Affinity"
# @group "Pod/Pod Scheduling"
variable "pod_affinity" {
  type = list(object(
    {
      preferred_during_scheduling_ignored_during_execution = optional(list(object(
        {
          pod_affinity_term = list(object(
            {
              label_selector = list(object(
                {
                  match_expressions = list(object(
                    {
                      key      = string
                      operator = string
                      values   = set(string)
                    }
                  ))
                  match_labels = map(string)
                }
              ))
              namespaces   = set(string)
              topology_key = string
            }
          ))
          weight = number
        }
      )))
      required_during_scheduling_ignored_during_execution = optional(list(object(
        {
          label_selector = object(
            {
              match_expressions = list(object(
                {
                  key      = string
                  operator = string
                  values   = set(string)
                }
              ))
              match_labels = map(string)
            }
          )
          namespaces   = set(string)
          topology_key = string
        }
      )))
    }
  ))
  default = []
}

# @label "Pod Anti Affinity"
# @group "Pod/Pod Scheduling"
variable "pod_anti_affinity" {
  type = list(object(
    {
      preferred_during_scheduling_ignored_during_execution = optional(list(object(
        {
          pod_affinity_term = list(object(
            {
              label_selector = list(object(
                {
                  match_expressions = list(object(
                    {
                      key      = string
                      operator = string
                      values   = set(string)
                    }
                  ))
                  match_labels = map(string)
                }
              ))
              namespaces   = set(string)
              topology_key = string
            }
          ))
          weight = number
        }
      )))
      required_during_scheduling_ignored_during_execution = optional(list(object(
        {
          label_selector = object(
            {
              match_expressions = list(object(
                {
                  key      = string
                  operator = string
                  values   = set(string)
                }
              ))
              match_labels = map(string)
            }
          )
          namespaces   = set(string)
          topology_key = string
        }
      )))
    }
  ))
  default = []
}

# @label "Tolerations"
# @group "Pod/Resources"
variable "toleration" {
  type = list(object({
    effect             = optional(string)
    key                = optional(string)
    operator           = optional(string)
    toleration_seconds = optional(string)
    value              = optional(string)
  }))
  description = "Pod node tolerations"
  default     = []
}

# @label "Priority"
# @group "Pod/Resources"
variable "priority_class_name" {
  description = "If specified, indicates the pod's priority"
  type        = string
  default     = null
}

# @label "Termination Grace Period"
# @group "Pod/Scaling and Upgrade Policy"
variable "termination_grace_period_seconds" {
  description = "Duration in seconds the pod needs to terminate gracefully"
  type        = number
  default     = null
}

# @label "Restart Policy"
# @group "Pod/Scaling and Upgrade Policy"
# @options ["Always","OnFailure","Never"]
variable "restart_policy" {
  type        = string
  description = "Restart policy for all containers within the pod. One of Always, OnFailure, Never"
  default     = "Always"
}

# @label "Filesystem Group"
# @group "Pod/Security Context"
variable "fs_group" {
  description = "A special supplemental group that applies to all containers in a pod"
  type        = number
  default     = null
}

# @label "Service Account Name"
# @group "Pod/Security Context"
variable "service_account_name" {
  type        = string
  description = "Is the name of the ServiceAccount to use to run this pod"
  default     = null
}

# @label "Auto Mounted Service Account Token"
# @group "Pod/Security Context"
variable "auto_mounted_service_account_token" {
  type        = bool
  description = "Indicates whether a service account token should be automatically mounted"
  default     = null
}

# @label "Volume Mount"
# @group "Pod/Storage"
variable "volume_mount" {
  type = list(object({
    volume_name = string
    mount_path  = string
    sub_path    = optional(string)
    read_only   = optional(string)
  }))
  description = "Mount path from pods to volume"
  default     = []
}

# @label "Volume Configmap"
# @group "Pod/Storage"
variable "volume_config_map" {
  type = list(object({
    volume_name = string
    name        = string
    mode        = optional(string)
    optional    = optional(string)
    items = optional(list(object({
      key  = string
      path = string
      mode = optional(string)
    })), [])
  }))
  description = "The data stored in a ConfigMap object can be referenced in a volume of type configMap and then consumed by containerized applications running in a Pod"
  default     = []
}

# @label "Volume Empty"
# @group "Pod/Storage"
variable "volume_empty_dir" {
  type = list(object({
    volume_name = string
    medium      = optional(string)
    size_limit  = optional(string)
  }))
  description = "EmptyDir represents a temporary directory that shares a pod's lifetime"
  default     = []
}

# @label "Volume Secret"
# @group "Pod/Storage"
variable "volume_secret" {
  type = list(object({
    volume_name  = string
    secret_name  = string
    default_mode = optional(string)
    optional     = optional(string)
    items = optional(list(object({
      key  = string
      path = string
      mode = optional(string)
    })), [])
  }))
  description = "Create volume from secret"
  default     = []
}

# @label "Volume Claim"
# @group "Pod/Storage"
variable "volume_claim" {
  type = list(object({
    volume_name = string
    claim_name  = optional(string)
    read_only   = optional(string)
  }))
  description = "Represents an Persistent volume Claim resource that is attached to a kubelet's host machine and then exposed to the pod"
  default     = []
}

# @label "Deployment Labels"
# @group "Deployment/Labels & Annotations"
variable "deployment_labels" {
  description = "Labels for deployment"
  type        = map(string)
  default     = null
}

# @label "Deployment Annotations"
# @group "Deployment/Labels & Annotations"
variable "deployment_annotations" {
  description = "Annotations for deployment"
  type        = map(string)
  default     = null
}

# @label "Scaling and Upgrade Policy"
# @group "Deployment/Scaling and Upgrade Policy"
# @options ["RollingUpdate","Recreate"]
variable "strategy" {
  description = "Strategy of deployment update"
  type        = string
  default     = "RollingUpdate"
}

# @label "Max Surge"
# @group "Deployment/Scaling and Upgrade Policy"
# @show_if "strategy=RollingUpdate"
variable "max_surge" {
  description = "The maximum number of pods that can be scheduled above the desired number of pods"
  type        = string
  default     = "25%"
}

# @label "Max Unavailable"
# @group "Deployment/Scaling and Upgrade Policy"
# @show_if "strategy=RollingUpdate"
variable "max_unavailable" {
  description = "The maximum number of pods that can be unavailable during the update"
  type        = string
  default     = "25%"
}

# @label "Mininum Ready"
# @group "Deployment/Scaling and Upgrade Policy"
variable "min_ready_seconds" {
  description = "Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available"
  type        = number
  default     = 0
}

# @label "Revision History Limit"
# @group "Deployment/Scaling and Upgrade Policy"
variable "revision_history_limit" {
  description = "The number of old ReplicaSets to retain to allow rollback"
  type        = number
  default     = 10
}

# @label "Progress Deadline"
# @group "Deployment/Scaling and Upgrade Policy"
variable "progress_deadline" {
  description = "The maximum time in seconds for a deployment to make progress before it is considered to be failed"
  type        = number
  default     = 600
}

# @hidden
variable "seal_metadata_application_name" {
  type        = string
  description = "Seal metadata application name."
  default     = ""
}
# @hidden
variable "seal_metadata_application_instance_name" {
  type        = string
  description = "Seal metadata application instance name."
  default     = ""
}
# @hidden
variable "seal_metadata_project_name" {
  type        = string
  description = "Seal metadata project name."
  default     = ""
}
# @hidden
variable "seal_metadata_module_name" {
  type        = string
  description = "Seal metadata module name."
  default     = ""
}