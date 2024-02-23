terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.4"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_sentryhost_dashboard" {
  dashboard_name        = "Hardware Sentry - Host"
  project_name          = var.lightstep_project
  dashboard_description = "This collection of dashboards (**Hardware Sentry**) leverages the [`hw.*` metrics](/metric/summary?filter=hw.) collected by [Hardware Sentry OpenTelemetry Collector](https://www.sentrysoftware.com/products/hardware-sentry-opentelemetry-collector.html).\n\n| Dashboard | Description |\n|---|---|\n| Hardware Sentry - Observability & Sustainability | Overview of all monitored hosts, with a focus on sustainability |\n| Hardware Sentry - Site | Metrics associated to one *site* (a data center or a server room) and its monitored *hosts* |\n| **Hardware Sentry - Host** (this dashboard) | Metrics associated to one *host* and its internal devices |\n\n## Host\n\nThis dashboard summarizes the monitoring of a specific *host* with **[Hardware Sentry OpenTelemetry Collector](https://www.sentrysoftware.com/products/hardware-sentry-opentelemetry-collector.html)**.\n\nUse the `$site` and `$hostname` dashboard variables to select the *host* to display.\n\nA *host* can be a server, a blade chassis, a network switch or a storage system.\n\nTo configure the monitoring of a host with **Hardware Sentry OpenTelemetry Collector**, [edit the **hws-config.yaml** file](https://www.sentrysoftware.com/docs/hws-otel-collector/latest/configuration/configure-agent.html) and add an entry as in the example below.\n\n```yaml\nhosts:\n  - host:\n      hostname: idrac-dell-23w41\n      type: management\n    snmp:\n      version: v2c\n      community: public\n```"

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"
  }
  group {
    rank            = 1
    title           = "Host Information"
    visibility_type = "explicit"

    chart {
      name        = "Enclosures"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 24
      height      = 6

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status | filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"hw.type\" == \"enclosure\")) | latest | group_by [\"host.type\", \"vendor\", \"model\", \"device_id\", \"serial_number\"], sum"
      }

      subtitle = ""
    }
    chart {
      name   = "Devices Status"
      type   = "timeseries"
      rank   = 1
      x_pos  = 24
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status | filter (((\"state\" == \"failed\") && (\"site\" == $site)) && (\"host.name\" == $hostname)) | latest | group_by [], sum"
      }

      subtitle = "Critical"
    }
    chart {
      name   = "Devices Status"
      type   = "timeseries"
      rank   = 2
      x_pos  = 32
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status | filter (((\"state\" == \"degraded\") && (\"site\" == $site)) && (\"host.name\" == $hostname)) | latest | group_by [], sum"
      }

      subtitle = "Degraded"
    }
    chart {
      name   = "Missing Devices"
      type   = "timeseries"
      rank   = 3
      x_pos  = 40
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status \n| filter (((\"state\" == \"present\") && (\"site\" == $site)) && (\"host.name\" == $hostname)) \n| latest 5m\n| point_filter value == 0\n| group_by [], count"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 2
    title           = "Power Consumption and Carbon Emissions"
    visibility_type = "explicit"

    chart {
      name        = "Current Power * PUE"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "a_b"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | latest | group_by [], mean;\njoin ((a*b)), a=0, b=0\n| point round(value)"
      }

      subtitle = "Watts"
    }
    chart {
      name   = "Total Power * PUE"
      type   = "timeseries"
      rank   = 1
      x_pos  = 8
      y_pos  = 0
      width  = 16
      height = 12

      query {
        query_name   = "a_b"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | latest 5m | group_by [], mean;\njoin ((a*b)), a=0, b=0\n| point round(value) "
      }

      subtitle = ""
    }
    chart {
      name   = "Daily Energy Consumption"
      type   = "timeseries"
      rank   = 2
      x_pos  = 24
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a_b_24"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\njoin (((a*b)*24)), a=0, b=0"
      }

      subtitle = "Wh"
    }
    chart {
      name   = "Daily Cost"
      type   = "timeseries"
      rank   = 3
      x_pos  = 32
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_1000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  c = metric hw.site.electricity_cost | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\njoin (((((a*b)*c)*24)/1000)), a=0, b=0, c=0"
      }

      subtitle = "$"
    }
    chart {
      name   = "Daily CO₂ Emissions"
      type   = "timeseries"
      rank   = 4
      x_pos  = 40
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_1000_1000000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\njoin ((((((a*b)*c)*24)/1000)/1000000)), a=0, b=0, c=0"
      }

      subtitle = "t"
    }
    chart {
      name        = "Power"
      description = ""
      type        = "timeseries"
      rank        = 5
      x_pos       = 0
      y_pos       = 6
      width       = 8
      height      = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.host.power \n| filter ((\"site\" == $site) && (\"host.name\" == $hostname))\n| latest\n| group_by [], sum\n| point round(value)"
      }

      subtitle = "Watts"
    }
    chart {
      name   = "Monthly Energy Consumption"
      type   = "timeseries"
      rank   = 6
      x_pos  = 24
      y_pos  = 6
      width  = 8
      height = 6

      query {
        query_name   = "a_b_24_30"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 30m, mean | group_by [], mean;\njoin ((((a*b)*24)*30)), a=0, b=0"
      }

      subtitle = "Wh"
    }
    chart {
      name   = "Monthly Cost"
      type   = "timeseries"
      rank   = 7
      x_pos  = 32
      y_pos  = 6
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_30_1000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 30d, mean | group_by [], mean;\n  c = metric hw.site.electricity_cost | filter (\"site\" == $site) | reduce 30d, mean | group_by [], mean;\njoin ((((((a*b)*c)*24)*30)/1000)), a=0, b=0, c=0"
      }

      subtitle = "$"
    }
    chart {
      name   = "Copy of Daily CO₂ Emissions"
      type   = "timeseries"
      rank   = 8
      x_pos  = 40
      y_pos  = 6
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_1000_1000000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 30d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | filter (\"site\" == $site) | reduce 30d, mean | group_by [], mean;\njoin (((((((a*b)*c)*24)*30)/1000)/1000000)), a=0, b=0, c=0"
      }

      subtitle = "t"
    }
    chart {
      name        = "Power Consumption Reading"
      description = ""
      type        = "timeseries"
      rank        = 9
      x_pos       = 0
      y_pos       = 12
      width       = 8
      height      = 6

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest | group_by [\"quality\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Power per Device Type (%)"
      description = ""
      type        = "timeseries"
      rank        = 10
      x_pos       = 8
      y_pos       = 12
      width       = 16
      height      = 6

      query {
        query_name = "a"
        display    = "ordered_list"

        display_type_options {
          sort_by        = "value"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "with \n\ttype = metric hw.energy\n\t\t| rate\n\t\t| filter ((\"site\" == $site) && (\"host.name\" == $hostname))\n\t\t| group_by [\"hw.type\"], sum;\n\ttotal = metric hw.energy\n\t\t| rate\n\t\t| filter ((\"site\" == $site) && (\"host.name\" == $hostname))\n\t\t| group_by [], sum; \njoin round(type * 100 / total)"
      }

      subtitle = ""
    }
    chart {
      name   = "Yearly Energy Consumption"
      type   = "timeseries"
      rank   = 11
      x_pos  = 24
      y_pos  = 12
      width  = 8
      height = 6

      query {
        query_name   = "a_b_24_365"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\njoin ((((a*b)*24)*365)), a=0, b=0"
      }

      subtitle = "Wh"
    }
    chart {
      name   = "Yearly Cost"
      type   = "timeseries"
      rank   = 12
      x_pos  = 32
      y_pos  = 12
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_365_1000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\n  c = metric hw.site.electricity_cost | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\njoin ((((((a*b)*c)*24)*365)/1000)), a=0, b=0, c=0"
      }

      subtitle = "$"
    }
    chart {
      name   = "Yearly CO₂ Emissions"
      type   = "timeseries"
      rank   = 13
      x_pos  = 40
      y_pos  = 12
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_365_1000_1000000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\njoin (((((((a*b)*c)*24)*365)/1000)/1000000)), a=0, b=0, c=0"
      }

      subtitle = "t"
    }
  }
  group {
    rank            = 3
    title           = "Devices"
    visibility_type = "explicit"

    chart {
      name        = "Count of Monitored Devices"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 12

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "hw.type"
          sort_direction = "asc"
        }
        hidden       = false
        query_string = "metric hw.status | filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"state\" == \"present\")) | latest | group_by [\"hw.type\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Monitored Devices"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 32
      height      = 12

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "hw.type"
          sort_direction = "asc"
        }
        hidden       = false
        query_string = "metric hw.status | filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"state\" == \"present\")) | latest | group_by [\"hw.type\", \"name\", \"info\"], count_nonzero"
      }

      subtitle = ""
    }
    chart {
      name        = "Failed Devices"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 0
      y_pos       = 12
      width       = 24
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status \n| filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"state\" == \"failed\")) \n| latest \n| point_filter value == 1\n| group_by [\"hw.type\", \"name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Missing Devices"
      description = ""
      type        = "timeseries"
      rank        = 3
      x_pos       = 24
      y_pos       = 12
      width       = 24
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status \n| filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"state\" == \"present\")) \n| latest \n| point_filter value == 0\n| group_by [\"hw.type\", \"name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Degraded Devices"
      description = ""
      type        = "timeseries"
      rank        = 4
      x_pos       = 0
      y_pos       = 20
      width       = 24
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status \n| filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"state\" == \"degraded\")) \n| latest \n| point_filter value == 1\n| group_by [\"hw.type\", \"name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Predicted Failures"
      description = ""
      type        = "timeseries"
      rank        = 5
      x_pos       = 24
      y_pos       = 20
      width       = 24
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status \n| filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"state\" == \"predicted_failure\")) \n| latest \n| point_filter value == 1\n| group_by [\"hw.type\", \"name\"], sum"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 4
    title           = "Temperatures and Fans"
    visibility_type = "explicit"

    chart {
      name        = "Ambient (°C)"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.host.ambient_temperature | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [], mean"
      }

      subtitle = "°C"
    }
    chart {
      name        = "Temperatures (°C)"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 8
      y_pos       = 0
      width       = 16
      height      = 12

      query {
        query_name   = "Sensor"
        display      = "line"
        hidden       = false
        query_string = "metric hw.temperature | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"site\", \"host.name\", \"sensor_location\", \"instrumentation.name\"], mean"
      }
      query {
        query_name   = "Ambient"
        display      = "line"
        hidden       = false
        query_string = "metric hw.host.ambient_temperature | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"site\", \"host.name\"], mean"
      }

      subtitle = ""
    }
    chart {
      name        = "Average Fan Speed"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 24
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.fan.speed \n| filter ((\"site\" == $site) && (\"host.name\" == $hostname)) \n| latest 5m \n| group_by [], mean\n| point round(value)"
      }

      subtitle = "rpm"
    }
    chart {
      name        = "Fans Speed"
      description = ""
      type        = "timeseries"
      rank        = 3
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 12

      query {
        query_name   = "Fan"
        display      = "line"
        hidden       = false
        query_string = "metric hw.fan.speed | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"sensor_location\", \"instrumentation.name\"], mean"
      }

      subtitle = ""
    }
    chart {
      name        = "Heating Margin (°C)"
      description = ""
      type        = "timeseries"
      rank        = 4
      x_pos       = 0
      y_pos       = 6
      width       = 8
      height      = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.host.heating_margin | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [], mean"
      }

      subtitle = "°C"
    }
    chart {
      name        = "Highest Temperature (°C)"
      description = ""
      type        = "timeseries"
      rank        = 5
      x_pos       = 24
      y_pos       = 6
      width       = 8
      height      = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.temperature | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [], max"
      }

      subtitle = "°C"
    }
  }
  group {
    rank            = 5
    title           = "Network"
    visibility_type = "explicit"

    chart {
      name        = "Network Traffic (bytes/s)"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 24
      height      = 9

      query {
        query_name   = "Received"
        display      = "line"
        hidden       = false
        query_string = "metric hw.network.io | filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"direction\" == \"receive\")) | rate | group_by [\"host.name\", \"name\"], sum"
      }
      query {
        query_name   = "Transmitted"
        display      = "line"
        hidden       = false
        query_string = "metric hw.network.io | filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"direction\" == \"transmit\")) | rate 5m | group_by [\"host.name\", \"name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Network Links Status"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 24
      y_pos       = 0
      width       = 24
      height      = 9

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "value"
          sort_direction = "asc"
        }
        hidden       = false
        query_string = "metric hw.network.up | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"host.name\", \"name\", \"physical_address\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Bandwidth Utilization (%)"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 0
      y_pos       = 9
      width       = 16
      height      = 8

      query {
        query_name = "formula"
        display    = "line"

        display_type_options {
          y_axis_min = 0
          y_axis_max = 100
        }
        hidden       = false
        query_string = "metric hw.network.bandwidth.utilization | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"host.id\"], max | point ((value*100))"
      }

      subtitle = ""
    }
    chart {
      name        = "Max Network Error Ratio"
      description = ""
      type        = "timeseries"
      rank        = 3
      x_pos       = 16
      y_pos       = 9
      width       = 8
      height      = 8

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.network.error_ratio | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest | group_by [], max | point ((value*100))"
      }

      subtitle = ""
    }
    chart {
      name        = "Network Links Speed (bytes/sec)"
      description = ""
      type        = "timeseries"
      rank        = 4
      x_pos       = 24
      y_pos       = 9
      width       = 24
      height      = 8

      query {
        query_name   = "LinkSpeed"
        display      = "table"
        hidden       = false
        query_string = "metric hw.network.bandwidth.limit | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"host.name\", \"name\", \"physical_address\"], sum | point ((value*8))"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 6
    title           = "CPUs, Voltages, Batteries"
    visibility_type = "explicit"

    chart {
      name        = "CPU Speed and Power Consumption"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "CPU_Power_Watts"
        display      = "line"
        hidden       = false
        query_string = "metric hw.energy | filter (((\"site\" == $site) && (\"host.name\" == $hostname)) && (\"hw.type\" == \"cpu\")) | rate 5m | group_by [], sum"
      }
      query {
        query_name   = "CPU_Speed_GHz"
        display      = "line"
        hidden       = false
        query_string = "metric hw.cpu.speed | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"host.name\", \"site\"], mean | point ((value/1000000000))"
      }

      subtitle = ""
    }
    chart {
      name        = "Voltages (Volts)"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric hw.voltage | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"name\", \"site\", \"host.name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Battery Charge (%)"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name = "Charge"
        display    = "line"

        display_type_options {
          y_axis_min = 0
          y_axis_max = 100
        }
        hidden       = false
        query_string = "metric hw.battery.charge | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"site\", \"host.name\", \"device_id\"], mean | point ((value*100))"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 7
    title           = "Storage"
    visibility_type = "explicit"

    chart {
      name        = "Total Disks"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.physical_disk.size | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Logical Disks Layout"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "value"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.logical_disk.limit | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest | group_by [\"name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Endurance Remaining (%)"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "Endurance_Remaining"
        display      = "line"
        hidden       = false
        query_string = "metric hw.physical_disk.endurance_utilization | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest 5m | group_by [\"name\"], sum | point ((value*100))"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 8
    title           = "Monitoring Information"
    visibility_type = "explicit"

    chart {
      name        = "Connectors"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 24
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hardware_sentry.connector.status | filter ((\"site\" == $site) && (\"host.name\" == $hostname)) | latest | group_by [\"name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Hardware Sentry Agents Information"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 24
      y_pos       = 0
      width       = 24
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hardware_sentry.agent.info | filter (\"site\" == $site) | latest | group_by [\"site\", \"version\", \"build_date\", \"hc_version\"], sum"
      }

      subtitle = ""
    }
  }

  template_variable {
    name                     = "site"
    default_values           = []
    suggestion_attribute_key = "site"
  }
  template_variable {
    name                     = "hostname"
    default_values           = []
    suggestion_attribute_key = "host.name"
  }
}
