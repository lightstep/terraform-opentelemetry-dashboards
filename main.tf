terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.84.2"
    }
  }
  required_version = ">= v1.0.11"
}

provider "lightstep" {
  api_key_env_var = var.lightstep_api_key_env_var
  organization    = var.lightstep_organization
  environment     = var.lightstep_env
}

module "lightstep_otel_collector_activedirectorydsreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-activedirectorydsreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_activemqreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-activemqreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_airflow_dashboard" {
  source            = "./collector-dashboards/otel-collector-airflow-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_apachereceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-apachereceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_arangodb" {
  source            = "./collector-dashboards/otel-collector-arangodb"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_ceph_dashboard" {
  source            = "./collector-dashboards/otel-collector-ceph-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_cilium_overview_dashboard" {
  source            = "./collector-dashboards/otel-collector-cilium-overview-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_clickhouse_dashboard" {
  source            = "./collector-dashboards/otel-collector-clickhouse-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_cockroachdb_dashboard" {
  source            = "./collector-dashboards/otel-collector-cockroachdb-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_couchdbreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-couchdbreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_dashboard" {
  source            = "./collector-dashboards/otel-collector-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_dockerstats_dashboard" {
  source            = "./collector-dashboards/otel-collector-dockerstats-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_elasticsearchreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-elasticsearchreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_etcd_dashboard" {
  source            = "./collector-dashboards/otel-collector-etcd-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_flink_dashboard" {
  source            = "./collector-dashboards/otel-collector-flink-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_fluentd_dashboard" {
  source            = "./collector-dashboards/otel-collector-fluentd-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_grafana_dashboard" {
  source            = "./collector-dashboards/otel-collector-grafana-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_gunicorn_dashboard" {
  source            = "./collector-dashboards/otel-collector-gunicorn-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_hadoop_dashboard" {
  source            = "./collector-dashboards/otel-collector-hadoop-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_haproxy_dashboard" {
  source            = "./collector-dashboards/otel-collector-haproxy-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_hbase_dashboard" {
  source            = "./collector-dashboards/otel-collector-hbase-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_host_dashboard" {
  source            = "./collector-dashboards/otel-collector-host-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_host_metrics_dashboard" {
  source            = "./collector-dashboards/otel-collector-host-metrics-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_host_metrics_prom_dashboard" {
  source            = "./collector-dashboards/otel-collector-host-metrics-prom-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_hostmetrics_cpu_dashboard" {
  source            = "./collector-dashboards/otel-collector-hostmetrics-cpu-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_hostmetrics_disk_dashboard" {
  source            = "./collector-dashboards/otel-collector-hostmetrics-disk-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_hostmetrics_memory_dashboard" {
  source            = "./collector-dashboards/otel-collector-hostmetrics-memory-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_hostmetrics_paging_dashboard" {
  source            = "./collector-dashboards/otel-collector-hostmetrics-paging-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_httpcheck_dashboard" {
  source            = "./collector-dashboards/otel-collector-httpcheck-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_ibmmq_dashboard" {
  source            = "./collector-dashboards/otel-collector-ibmmq-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_iisreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-iisreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_jbosswildfly" {
  source            = "./collector-dashboards/otel-collector-jbosswildfly"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_k8s_kubelet_prom_dashboard" {
  source            = "./collector-dashboards/otel-collector-k8s-kubelet-prom-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_k8s_pod_resources_prom_dashboard" {
  source            = "./collector-dashboards/otel-collector-k8s-pod-resources-prom-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_kafka_dashboard" {
  source            = "./collector-dashboards/otel-collector-kafka-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_kafkametricsreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-kafkametricsreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_kubeletstatsreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-kubeletstatsreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_kubernetes_application_dashboard" {
  source            = "./collector-dashboards/otel-collector-kubernetes-application-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_kubernetes_comprehensive_dashboard_prometheus" {
  source            = "collector-dashboards/otel-collector-kubernetes-comprehensive-dashboard-prometheus"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_kubernetes_comprehensive_dashboard" {
  source            = "collector-dashboards/otel-collector-kubernetes-comprehensive-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_kubernetes_dashboard" {
  source            = "./collector-dashboards/otel-collector-kubernetes-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_memcachedreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-memcachedreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_minio_dashboard" {
  source            = "./collector-dashboards/otel-collector-minio-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_mongodbatlasreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-mongodbatlasreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_mongodbreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-mongodbreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_mysqlreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-mysqlreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_nginxreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-nginxreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_nomad_dashboard" {
  source            = "./collector-dashboards/otel-collector-nomad-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_postgresqlreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-postgresqlreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_powerdns_dashboard" {
  source            = "./collector-dashboards/otel-collector-powerdns-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_rabbitmqreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-rabbitmqreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_redisreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-redisreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_riakreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-riakreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_snmp_dashboard" {
  source            = "./collector-dashboards/otel-collector-snmp-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_solr_dashboard" {
  source            = "./collector-dashboards/otel-collector-solr-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_sqlserverreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-sqlserverreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_squid_dashboard" {
  source            = "./collector-dashboards/otel-collector-squid-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_tomcat_dashboard" {
  source            = "./collector-dashboards/otel-collector-tomcat-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_varnish_dashboard" {
  source            = "./collector-dashboards/otel-collector-varnish-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_vault_dashboard" {
  source            = "./collector-dashboards/otel-collector-vault-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_collector_zookeeperreceiver_dashboard" {
  source            = "./collector-dashboards/otel-collector-zookeeperreceiver-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_operator_dashboard" {
  source            = "./collector-dashboards/otel-operator-dashboard"
  lightstep_project = var.lightstep_project
}

module "lightstep_otel_target_allocator_dashboard" {
  source            = "./collector-dashboards/otel-target-allocator-dashboard"
  lightstep_project = var.lightstep_project
}
