terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.91.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_sentrysite_dashboard" {
  dashboard_name        = "Hardware Sentry - Site"
  project_name          = var.lightstep_project
  dashboard_description = "This collection of dashboards (**Hardware Sentry**) leverages the [`hw.*` metrics](/metric/summary?filter=hw.) collected by [Hardware Sentry OpenTelemetry Collector](https://www.sentrysoftware.com/products/hardware-sentry-opentelemetry-collector.html).\n\n| Dashboard | Description |\n|---|---|\n| Hardware Sentry - Observability & Sustainability | Overview of all monitored hosts, with a focus on sustainability |\n| **Hardware Sentry - Site** (this dashboard) | Metrics associated to one *site* (a data center or a server room) and its monitored *hosts*|\n| Hardware Sentry - Host | Metrics associated to one *host* and its internal devices |\n\n## Site\n\nA *site* represents a data center or a server room. Select a site with the `$site` dashboard variable. \n\nThis dashboard is split in 5 sections:\n\n* Summary of what is monitored in the selected *site*\n* Power consumption, electricity cost and carbon emissions\n* Temperature optimization and potential reduction in carbon emissions\n* List of hosts in the *site* \n* Inventory\n\n## How to configure *sites*?\n\n*Sites* are determined from the `site` label in the `hw.*` metrics that are displayed in this dashboard. The `site` label is added by **Hardware Sentry OpenTelemetry Collector** when collecting hardware metrics.\n\nInstall an instance of [Hardware Sentry OpenTelemetry Collector](https://www.sentrysoftware.com/products/hardware-sentry-opentelemetry-collector.html) in each data center or server room. For each, [configure **hws-config.yaml**](https://www.sentrysoftware.com/docs/hws-otel-collector/latest/configuration/configure-agent.html) to specify the characteristics of the *site* as in the example below:\n\n```yaml\nextraLabels:\n  site: Datacenter 1 # Customize with your own site naming\n\nextraMetrics:\n  hw.site.carbon_intensity: 350 # in g/kWh\n  hw.site.electricity_cost: 0.12 # in your currency/kWh\n  hw.site.pue: 1.8\n```\n"

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"
  }
  group {
    rank            = 1
    title           = "Site Overall Information"
    visibility_type = "explicit"

    chart {
      name        = "Hosts"
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
        query_string = "metric hardware_sentry.host.configured | filter (\"site\" == $site) | reduce 1h, max | group_by [], sum"
      }

      subtitle = "Hosts"
    }
    chart {
      name   = "Missing Devices"
      type   = "timeseries"
      rank   = 0
      x_pos  = 24
      y_pos  = 6
      width  = 24
      height = 8

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "site"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.status\n| filter ((state == \"present\") && (site = $site))\n| point_filter value == 0\n| latest 5m\n| group_by [\"site\", \"host.id\", \"name\"], min\n"
      }

      subtitle = ""
    }
    chart {
      name        = "Coverage"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 8
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  hostCount = metric hardware_sentry.host.configured | filter site == $site | latest 1h | group_by [], count;\n  connectorOk = metric hardware_sentry.connector.status | filter site == $site | filter state == \"ok\" | reduce 1h, max | group_by [\"host.id\", \"site\"], max | point_filter value == 1 | group_by [], count;\njoin round(connectorOk * 1.0 / (hostCount * 1.0) * 100.0), hostCount=1, connectorOk=0"
      }

      subtitle = "%"
    }
    chart {
      name   = "Devices Status"
      type   = "timeseries"
      rank   = 2
      x_pos  = 16
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status | filter ((\"site\" == $site) && (\"state\" == \"failed\")) | latest | group_by [], sum"
      }

      subtitle = "Critical"
    }
    chart {
      name   = "Missing Devices"
      type   = "timeseries"
      rank   = 3
      x_pos  = 32
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status \n| filter ((\"state\" == \"present\") && (\"site\" == $site))\n| latest 5m\n| point_filter value == 0\n| group_by [], count"
      }

      subtitle = "Missing Devices"
    }
    chart {
      name   = "Devices Status"
      type   = "timeseries"
      rank   = 3
      x_pos  = 24
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status | filter ((\"site\" == $site) && (\"state\" == \"degraded\")) | latest | group_by [], sum"
      }

      subtitle = "Degraded"
    }
    chart {
      name   = "Active Alerts"
      type   = "timeseries"
      rank   = 4
      x_pos  = 0
      y_pos  = 6
      width  = 24
      height = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status | filter site == $site | filter state == \"degraded\" || state == \"failed\" | point_filter value == 1 | latest | group_by [\"site\", \"host.id\", \"name\", \"state\"], max"
      }

      subtitle = ""
    }
    chart {
      name   = "PUE (24 hrs)"
      type   = "timeseries"
      rank   = 5
      x_pos  = 0
      y_pos  = 14
      width  = 8
      height = 7

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.site.pue | filter site == $site | reduce 1d, mean | group_by [\"site\"], mean"
      }

      subtitle = ""
    }
    chart {
      name   = "PUE"
      type   = "timeseries"
      rank   = 6
      x_pos  = 8
      y_pos  = 14
      width  = 8
      height = 7

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric hw.site.pue | filter site == $site | reduce 2h, mean | group_by [\"site\"], mean"
      }

      subtitle = ""
    }
    chart {
      name   = "CO₂ Intensity (g)"
      type   = "timeseries"
      rank   = 7
      x_pos  = 16
      y_pos  = 14
      width  = 8
      height = 7

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric hw.site.carbon_intensity | filter site == $site | latest 5m | group_by [\"site\"], mean"
      }

      subtitle = ""
    }
    chart {
      name   = "Electricity Cost ($/kWh)"
      type   = "timeseries"
      rank   = 8
      x_pos  = 24
      y_pos  = 14
      width  = 8
      height = 7

      query {
        query_name   = "a"
        display      = "line"
        hidden       = false
        query_string = "metric hw.site.electricity_cost | filter (\"site\" == $site) | latest 5m | group_by [\"site\"], mean"
      }

      subtitle = ""
    }
    chart {
      name        = "Hosts Type"
      description = ""
      type        = "timeseries"
      rank        = 9
      x_pos       = 32
      y_pos       = 14
      width       = 8
      height      = 7

      query {
        query_name   = "a"
        display      = "ordered_list"
        hidden       = false
        query_string = "metric hw.host.configured | filter site == $site | latest | group_by [\"host.type\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Hosts Vendor"
      description = ""
      type        = "timeseries"
      rank        = 10
      x_pos       = 40
      y_pos       = 14
      width       = 8
      height      = 7

      query {
        query_name   = "a"
        display      = "ordered_list"
        hidden       = false
        query_string = "metric hw.status | filter (((\"site\" == $site) && (\"hw.type\" == \"enclosure\")) && (\"state\" == \"present\")) | latest | group_by [\"vendor\"], count"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 2
    title           = "Estimated Consumption and Emissions"
    visibility_type = "explicit"

    chart {
      name   = "Copy of Daily CO₂ Emissions"
      type   = "timeseries"
      rank   = 0
      x_pos  = 40
      y_pos  = 6
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_1000_1000000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 30d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | filter (\"site\" == $site) | reduce 30d, mean | group_by [], mean;\njoin (((((((a*b)*c)*24)*30)/1000)/1000000)), a=0, b=0, c=0"
      }

      subtitle = "t"
    }
    chart {
      name        = "Total Power * PUE"
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
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | latest | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | latest | group_by [], mean;\njoin ((a*b)), a=0, b=0"
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
      height = 18

      query {
        query_name   = "a_b"
        display      = "area"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | latest 5m | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | latest 5m | group_by [], mean;\njoin ((a*b)), a=0, b=0"
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
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\njoin (((a*b)*24)), a=0, b=0"
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
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\njoin ((((((a*b)*c)*24)/1000)/1000000)), a=0, b=0, c=0"
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
        query_string = "metric hw.host.power | filter (\"site\" == $site) | latest | group_by [], sum"
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
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 30m, mean | group_by [], mean;\njoin ((((a*b)*24)*30)), a=0, b=0"
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
      name        = "Margin of Error"
      description = ""
      type        = "timeseries"
      rank        = 9
      x_pos       = 0
      y_pos       = 12
      width       = 8
      height      = 6

      query {
        query_name   = "a_5_b_15_10000_c_d_a_b_100_c_d"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter site == $site | filter quality == \"measured\" | latest | group_by [], sum;\n  b = metric hw.host.power | filter site == $site | filter quality == \"estimated\" | latest | group_by [], sum;\n  c = metric hardware_sentry.host.configured | filter site == $site | latest | group_by [\"host.id\"], max;\n  d = metric hardware_sentry.connector.status | filter site == $site | filter state == \"ok\" | reduce max | group_by [\"host.id\"], max;\njoin round((a * 5 + b * 15 + 10000 * (c - d)) / (a + b + 100 * (c - d)))"
      }

      subtitle = "%"
    }
    chart {
      name   = "Yearly Energy Consumption"
      type   = "timeseries"
      rank   = 10
      x_pos  = 24
      y_pos  = 12
      width  = 8
      height = 6

      query {
        query_name   = "a_b_24_365"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\njoin ((((a*b)*24)*365)), a=0, b=0"
      }

      subtitle = "Wh"
    }
    chart {
      name   = "Yearly Cost"
      type   = "timeseries"
      rank   = 11
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
      rank   = 12
      x_pos  = 40
      y_pos  = 12
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_365_1000_1000000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | filter (\"site\" == $site) | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | filter (\"site\" == $site) | reduce 365d, mean | group_by [], mean;\njoin (((((((a*b)*c)*24)*365)/1000)/1000000)), a=0, b=0, c=0"
      }

      subtitle = "t"
    }
  }
  group {
    rank            = 3
    title           = "Site Temperature Optimization"
    visibility_type = "explicit"

    chart {
      name        = "Heating Margin"
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
        query_string = "metric hw.host.heating_margin | filter (\"site\" == $site) | reduce 1d, min | group_by [], min"
      }

      subtitle = "°C"
    }
    chart {
      name        = "Monitoring Confidence"
      description = "Monitoring Confidence"
      type        = "timeseries"
      rank        = 1
      x_pos       = 0
      y_pos       = 6
      width       = 8
      height      = 6

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.ambient_temperature | filter (\"site\" == $site) | latest 5m | group_by [], sum;\n  b = metric hw.host.ambient_temperature | filter (\"site\" == $site) | latest 5m | group_by [], mean;\n  c = metric hw.host.configured | filter (\"site\" == $site) | latest 5m | group_by [], sum;\njoin ((((a/b)/c)*100)), a=0, b=0, c=0\n| point round(value)"
      }

      subtitle = "%"
    }
    chart {
      name        = "Site Heating Margin"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 8
      y_pos       = 0
      width       = 16
      height      = 12

      query {
        query_name = "a"
        display    = "line"

        display_type_options {
          y_axis_min = 0
          y_axis_max = 15
        }
        hidden       = false
        query_string = "metric hw.host.heating_margin | filter (\"site\" == $site) | reduce 5m, min | group_by [], min"
      }

      subtitle = ""
    }
    chart {
      name        = "Current Site Temperature"
      description = ""
      type        = "timeseries"
      rank        = 3
      x_pos       = 24
      y_pos       = 6
      width       = 8
      height      = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.host.ambient_temperature | filter (\"site\" == $site) | latest 5m | group_by [], mean\n| point round(value)"
      }

      subtitle = "°C"
    }
    chart {
      name        = "Recommended Max Site Temperature"
      description = ""
      type        = "timeseries"
      rank        = 4
      x_pos       = 32
      y_pos       = 6
      width       = 8
      height      = 6

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.ambient_temperature | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  b = metric hw.host.heating_margin | filter (\"site\" == $site) | reduce 1d, min | group_by [], min;\n  c = metric hw.host.ambient_temperature | filter (\"site\" == $site) | reduce 1d, max | group_by [], mean;\njoin (((a+(b-5))-(c-a))), a=0, b=0, c=0\n| point round(value)"
      }

      subtitle = "°C"
    }
    chart {
      name        = "Potential Yearly Energy Savings"
      description = ""
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.energy | filter (\"site\" == $site) | rate 1d | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  c = metric hw.host.ambient_temperature | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  d = metric hw.host.heating_margin | filter (\"site\" == $site) | reduce 1d, min | group_by [], min;\n  e = metric hw.host.ambient_temperature | reduce 1d, max | group_by [], mean;\njoin ((((((a*(b-1.15000))*24)*365)*((((c+d)-5)-(e-c))-c))*0.05000)), a=0, b=0, c=0, d=0, e=0"
      }

      subtitle = "Wh"
    }
    chart {
      name        = "Potential Yearly Savings"
      description = ""
      type        = "timeseries"
      rank        = 6
      x_pos       = 24
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.energy | filter (\"site\" == $site) | rate 1d | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  c = metric hw.host.ambient_temperature | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  d = metric hw.host.heating_margin | filter (\"site\" == $site) | reduce 1d, min | group_by [], min;\n  e = metric hw.host.ambient_temperature | reduce 1d, max | group_by [], mean;\n  f = metric hw.site.electricity_cost | reduce 1d, mean | group_by [], mean;\njoin ((((((((a*(b-1.15000))*24)*365)*((((c+d)-5)-(e-c))-c))*0.05000)*f)/1000)), a=0, b=0, c=0, d=0, e=0, f=0"
      }

      subtitle = "$"
    }
    chart {
      name        = "Potential Yearly CO₂ Reduction"
      description = ""
      type        = "timeseries"
      rank        = 7
      x_pos       = 40
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.energy | filter (\"site\" == $site) | rate 1d | group_by [], sum;\n  b = metric hw.site.pue | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  c = metric hw.host.ambient_temperature | filter (\"site\" == $site) | reduce 1d, mean | group_by [], mean;\n  d = metric hw.host.heating_margin | filter (\"site\" == $site) | reduce 1d, min | group_by [], min;\n  e = metric hw.host.ambient_temperature | reduce 1d, max | group_by [], mean;\n  f = metric hw.site.carbon_intensity | latest 1d | group_by [], mean;\njoin (((((((((a*(b-1.15000))*24)*365)*((((c+d)-5)-(e-c))-c))*0.05000)*f)/1000)/1000000)), a=0, b=0, c=0, d=0, e=0, f=0"
      }

      subtitle = "t"
    }
  }
  group {
    rank            = 4
    title           = "Hosts Power Usage and Temperatures"
    visibility_type = "explicit"

    chart {
      name        = "Host Power Consumption (W)"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
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
        query_string = "metric hw.host.power | filter (\"site\" == $site) | latest 5m | group_by [\"host.name\", \"host.type\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Hosts Ambient Temperature (°C)"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 32
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
        query_string = "metric hw.host.ambient_temperature | filter (\"site\" == $site) | latest 5m | group_by [\"host.name\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Host Heating Margin (°C)"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "value"
          sort_direction = "asc"
        }
        hidden       = false
        query_string = "metric hw.host.heating_margin | filter (\"site\" == $site) | latest 5m | group_by [\"host.name\"], sum"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 5
    title           = "Hardware Sentry Agent Status"
    visibility_type = "explicit"

    chart {
      name        = "Hardware Sentry Agents Information"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 48
      height      = 6

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
}
