terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.79.0"
    }
  }
  required_version = ">= v1.0.11"
}

provider "lightstep" {
  api_key_env_var = var.cloud_observability_api_key_env_var
  organization    = var.cloud_observability_organization
  environment     = var.cloud_observability_env
}

module "cloud_observability_otel_collector_activedirectorydsreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-activedirectorydsreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_activemqreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-activemqreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_airflow_dashboard" {
  source                      = "./collector-dashboards/otel-collector-airflow-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_apachereceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-apachereceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_arangodb_promreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-arangodb-promreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_ceph_dashboard" {
  source                      = "./collector-dashboards/otel-collector-ceph-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_cilium_overview_dashboard" {
  source                      = "./collector-dashboards/otel-collector-cilium-overview-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_clickhouse_dashboard" {
  source                      = "./collector-dashboards/otel-collector-clickhouse-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_cockroachdb_dashboard" {
  source                      = "./collector-dashboards/otel-collector-cockroachdb-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_couchbasereceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-couchbasereceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_couchdbreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-couchdbreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_dashboard" {
  source                      = "./collector-dashboards/otel-collector-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_dockerstats_dashboard" {
  source                      = "./collector-dashboards/otel-collector-dockerstats-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_elasticsearchreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-elasticsearchreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_etcd_dashboard" {
  source                      = "./collector-dashboards/otel-collector-etcd-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_flink_dashboard" {
  source                      = "./collector-dashboards/otel-collector-flink-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_fluentd_dashboard" {
  source                      = "./collector-dashboards/otel-collector-fluentd-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_grafana_dashboard" {
  source                      = "./collector-dashboards/otel-collector-grafana-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_gunicorn_dashboard" {
  source                      = "./collector-dashboards/otel-collector-gunicorn-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_hadoop_dashboard" {
  source                      = "./collector-dashboards/otel-collector-hadoop-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_haproxy_dashboard" {
  source                      = "./collector-dashboards/otel-collector-haproxy-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_hbase_dashboard" {
  source                      = "./collector-dashboards/otel-collector-hbase-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_host_dashboard" {
  source                      = "./collector-dashboards/otel-collector-host-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_hostmetrics_cpu_dashboard" {
  source                      = "./collector-dashboards/otel-collector-hostmetrics-cpu-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_hostmetrics_disk_dashboard" {
  source                      = "./collector-dashboards/otel-collector-hostmetrics-disk-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_hostmetrics_memory_dashboard" {
  source                      = "./collector-dashboards/otel-collector-hostmetrics-memory-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_hostmetrics_paging_dashboard" {
  source                      = "./collector-dashboards/otel-collector-hostmetrics-paging-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_ibmmq_dashboard" {
  source                      = "./collector-dashboards/otel-collector-ibmmq-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_iisreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-iisreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_k8s_kubelet_prom_dashboard" {
  source                      = "./collector-dashboards/otel-collector-k8s-kubelet-prom-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_k8s_node_exporter_prom_dashboard" {
  source                      = "./collector-dashboards/otel-collector-k8s-node-exporter-prom-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_k8s_pod_resources_prom_dashboard" {
  source                      = "./collector-dashboards/otel-collector-k8s-pod-resources-prom-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_kafka_dashboard" {
  source                      = "./collector-dashboards/otel-collector-kafka-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_kafkametricsreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-kafkametricsreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_kubeletstatsreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-kubeletstatsreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_kubernetes_comprehensive_dashboard" {
  source                      = "./collector-dashboards/otel-collector-kubernetes-comprehensive-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_kubernetes_dashboard" {
  source                      = "./collector-dashboards/otel-collector-kubernetes-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_memcachedreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-memcachedreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_minio_dashboard" {
  source                      = "./collector-dashboards/otel-collector-minio-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_mongodbatlasreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-mongodbatlasreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_mongodbreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-mongodbreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_mysqlreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-mysqlreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_nginxreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-nginxreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_nomad_dashboard" {
  source                      = "./collector-dashboards/otel-collector-nomad-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_postgresqlreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-postgresqlreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_powerdns_dashboard" {
  source                      = "./collector-dashboards/otel-collector-powerdns-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_rabbitmqreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-rabbitmqreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_redisreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-redisreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_riakreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-riakreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_snmp_dashboard" {
  source                      = "./collector-dashboards/otel-collector-snmp-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_solr_dashboard" {
  source                      = "./collector-dashboards/otel-collector-solr-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_sqlserverreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-sqlserverreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_squid_dashboard" {
  source                      = "./collector-dashboards/otel-collector-squid-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_tomcat_dashboard" {
  source                      = "./collector-dashboards/otel-collector-tomcat-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_varnish_dashboard" {
  source                      = "./collector-dashboards/otel-collector-varnish-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_vault_dashboard" {
  source                      = "./collector-dashboards/otel-collector-vault-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_collector_zookeeperreceiver_dashboard" {
  source                      = "./collector-dashboards/otel-collector-zookeeperreceiver-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_operator_dashboard" {
  source                      = "./collector-dashboards/otel-operator-dashboard"
  cloud_observability_project = var.cloud_observability_project
}

module "cloud_observability_otel_target_allocator_dashboard" {
  source                      = "./collector-dashboards/otel-target-allocator-dashboard"
  cloud_observability_project = var.cloud_observability_project
}
