---
# Ingest metrics using the Hikaricp integration

The OTel Collector has a variety of [third party receivers](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/master/receiver) that provide integration with a wide variety of metric sources.

Please note that not all metrics receivers available for the OpenTelemetry Collector have been tested by ServiceNow Cloud Observability, and there may be bugs or unexpected issues in using these contributed receivers with ServiceNow Cloud Observability metrics. File any issues with the appropriate OpenTelemetry community.
{: .callout}

## Prerequisites for local installation

You must have a ServiceNow Cloud Observability [access token](/docs/create-and-manage-access-tokens) for the project to report metrics to.

## Running the Example

### Run the example by running:

#### 1. Run Hkaricp & collector

Next install collector and point it to the hikaricp metrics endpoint, "host.docker.internal:8080" in this case.

```bash
docker compose up -d
```

## Configuration

Installation procedures for the OpenTelemetry Collector varies by deployment mode. Please refer to the [collector documentation](https://opentelemetry.io/docs/collector/) for more information.


The following example configuration collects metrics from Hikaricp and sends them into ServiceNow Cloud Observability:

```yaml
receivers:
  prometheus:
    config:
      scrape_configs:
        - job_name: 'hikaricp'
          scrape_interval: 20s
          scrape_timeout: 20s
          metrics_path: '/actuator/prometheus'
          tls_config:
            insecure_skip_verify: true
          scheme: http
          static_configs:
            - targets: ['host.docker.internal:8080']

exporters:
  logging:
    loglevel: debug
  otlp:
    endpoint: ingest.lightstep.com:443
    headers:
      "lightstep-access-token": "${LS_ACCESS_TOKEN}"


processors:
  batch:

service:
  telemetry:
    logs:
      level: DEBUG
  pipelines:
    metrics:
      receivers: [prometheus]
      processors: [batch]
      exporters: [logging, otlp]
```