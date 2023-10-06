# Teamcity metrics using the OpenTelemetry Collector

## Overview

 Name: natively exposes a Prometheus endpoint and the OpenTelemetry Collector has a [Prometheus receiver][otel-prom-receiver] that can be used to scrape its Prometheus endpoint. This directory contains an example showing how to configure Name: and the Collector to send metrics to Cloud Observability.

## Prerequisites

* Docker
* Docker Compose
* A Cloud Observability [access token][ls-docs-access-token]

## How to run the example

* Export your Cloud Observability access token
  
  ```sh
  export LS_ACCESS_TOKEN=<YOUR_TOKEN>
  ```

* Run the docker compose example
  
  ```sh
  docker-compose up -d
  ```

### Explore Metrics in Cloud Observability 

See the [Name: Telemetry Docs][teamcity-docs-telemetry] for comprehensive documentation on metrics emitted and the [dashboard documentation][ls-docs-dashboards] for more details.

## Configure the Collector

Below is a snippet showing how to configure the Prometheus Receiver to scrape the Prometheus endpoint exposed by the Name: Server.

```yaml
receivers:
  prometheus:
    config:
      scrape_configs:
        - job_name: 'teamcity'
          scrape_interval: 10s
          metrics_path: "/app/metrics"
          static_configs:
            - targets: ['localhost:8111']
          tls_config:
            insecure_skip_verify: true
```


## Additional information

- [OpenTelemetry Collector Prometheus Receiver][otel-prom-receiver]
- [Name: Telemetry Reference][teamcity-docs-telemetry]

[ls-docs-access-token]: https://docs.lightstep.com/docs/create-and-manage-access-tokens
[ls-docs-dashboards]: https://docs.lightstep.com/docs/create-and-manage-dashboards
[otel-prom-receiver]: https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver
[teamcity-docs-telemetry]: https://blog.jetbrains.com/teamcity/2022/06/monitoring-teamcity-server-health/
