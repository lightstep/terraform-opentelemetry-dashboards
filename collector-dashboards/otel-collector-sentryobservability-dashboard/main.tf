terraform {
  required_providers {
    lightstep = {
      source  = "lightstep/lightstep"
      version = "~> 1.86.1"
    }
  }
  required_version = ">= v1.0.11"
}

resource "lightstep_dashboard" "otel_collector_sentryobservability_dashboard" {
  dashboard_name        = "Hardware Sentry - Observability & Sustainability"
  project_name          = var.lightstep_project
  dashboard_description = "This collection of dashboards (**Hardware Sentry**) leverages the [`hw.*` metrics](/metric/summary?filter=hw.) collected by [Hardware Sentry OpenTelemetry Collector](https://www.sentrysoftware.com/products/hardware-sentry-opentelemetry-collector.html).\n\n| Dashboard | Description |\n|---|---|\n| **Hardware Sentry - Observability & Sustainability** (this dashboard) | Overview of all monitored hosts, with a focus on sustainability |\n| Hardware Sentry - Site | Metrics associated to one *site* (a data center or a server room) and its monitored *hosts* |\n|[Hardware Sentry - Host | Metrics associated to one *host* and its internal devices |\n\nThis main dashboard focuses on the energy usage and carbon emissions of your data centers and server rooms."

  group {
    rank            = 0
    title           = ""
    visibility_type = "implicit"
  }
  group {
    rank            = 1
    title           = "Overall Information"
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
        query_string = "metric hardware_sentry.host.configured | reduce 1h, max | group_by [], sum"
      }

      subtitle = "Hosts"
    }
    chart {
      name   = "Missing Devices"
      type   = "timeseries"
      rank   = 1
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
        query_string = "metric hw.status\n| filter state == \"present\"\n| point_filter value == 0\n| latest 5m\n| group_by [\"site\", \"host.id\", \"name\"], min\n"
      }

      subtitle = ""
    }
    chart {
      name        = "Coverage"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 8
      y_pos       = 0
      width       = 8
      height      = 6

      query {
        query_name   = "formula"
        display      = "big_number"
        hidden       = false
        query_string = "with\n\thostCount = metric hardware_sentry.host.configured\n\t\t| latest 1h\n\t\t| group_by [], count;\n\tconnectorOk = metric hardware_sentry.connector.status\n\t\t| filter state == \"ok\"\n\t\t| reduce 1h, max\n\t\t| group_by [\"host.id\", \"site\"], max\n\t\t| point_filter value == 1\n\t\t| group_by [], count;\njoin round((connectorOk * 1.0) / (hostCount * 1.0) * 100.0), connectorOk=0, hostCount=1"
      }

      subtitle = "%"
    }
    chart {
      name   = "Devices Status"
      type   = "timeseries"
      rank   = 3
      x_pos  = 16
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status | filter (\"state\" == \"failed\") | latest | group_by [], sum"
      }

      subtitle = "Critical"
    }
    chart {
      name   = "Missing Devices"
      type   = "timeseries"
      rank   = 4
      x_pos  = 32
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status \n| filter (\"state\" == \"present\") \n| latest 5m\n| point_filter value == 0\n| group_by [], count"
      }

      subtitle = "Missing Devices"
    }
    chart {
      name   = "Devices Status"
      type   = "timeseries"
      rank   = 5
      x_pos  = 24
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name   = "a"
        display      = "big_number"
        hidden       = false
        query_string = "metric hw.status | filter (\"state\" == \"degraded\") | latest | group_by [], sum"
      }

      subtitle = "Degraded"
    }
    chart {
      name   = "Active Alerts"
      type   = "timeseries"
      rank   = 6
      x_pos  = 0
      y_pos  = 6
      width  = 24
      height = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status\n| filter state == \"degraded\" || state == \"failed\"\n| point_filter value == 1\n| latest\n| group_by [\"site\", \"host.id\", \"name\", \"state\"], max\n"
      }

      subtitle = ""
    }

    text_panel {
      x_pos  = 40
      y_pos  = 0
      width  = 8
      height = 6
      text   = "[![Hardware Sentry](https://dl.sentrysoftware.com/public/hwslogo-servicenow-light.png)](https://www.sentrysoftware.com/products/hardware-sentry.html)"
    }
  }
  group {
    rank            = 2
    title           = "Power, Cost and CO₂ Emissions"
    visibility_type = "explicit"

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
        query_string = "with\n  a = metric hw.host.power | latest | group_by [], sum;\n  b = metric hw.site.pue | latest | group_by [], mean;\njoin ((a*b)), a=0, b=0"
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
        query_string = "with\n  a = metric hw.host.power | latest 5m | group_by [], sum;\n  b = metric hw.site.pue | latest 5m | group_by [], mean;\njoin ((a*b)), a=0, b=0"
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
        query_string = "with\n  a = metric hw.host.power | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 1d, mean | group_by [], mean;\njoin (((a*b)*24)), a=0, b=0"
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
        query_string = "with\n  a = metric hw.host.power | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 1d, mean | group_by [], mean;\n  c = metric hw.site.electricity_cost | reduce 1d, mean | group_by [], mean;\njoin (((((a*b)*c)*24)/1000)), a=0, b=0, c=0"
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
        query_string = "with\n  a = metric hw.host.power | reduce 1d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 1d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | reduce 1d, mean | group_by [], mean;\njoin ((((((a*b)*c)*24)/1000)/1000000)), a=0, b=0, c=0"
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
        query_string = "metric hw.host.power | latest | group_by [], sum"
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
        query_string = "with\n  a = metric hw.host.power | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 30d, mean | group_by [], mean;\njoin ((((a*b)*24)*30)), a=0, b=0"
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
        query_string = "with\n  a = metric hw.host.power | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 30d, mean | group_by [], mean;\n  c = metric hw.site.electricity_cost | reduce 30d, mean | group_by [], mean;\njoin ((((((a*b)*c)*24)*30)/1000)), a=0, b=0, c=0"
      }

      subtitle = "$"
    }
    chart {
      name   = "Monthly CO₂ Emissions"
      type   = "timeseries"
      rank   = 8
      x_pos  = 40
      y_pos  = 6
      width  = 8
      height = 6

      query {
        query_name   = "a_b_c_24_30_46700_1000_1000000"
        display      = "big_number"
        hidden       = false
        query_string = "with\n  a = metric hw.host.power | reduce 30d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 30d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | reduce 30d, mean | group_by [], mean;\njoin (((((((a*b)*c)*24)*30.467000)/1000)/1000000)), a=0, b=0, c=0"
      }

      subtitle = "t"
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
        query_string = "with\n\ta = metric hw.host.power\n\t\t| filter quality == \"measured\"\n\t\t| latest\n\t\t| group_by [], sum;\n\tb = metric hw.host.power\n\t\t| filter quality == \"estimated\"\n\t\t| latest\n\t\t| group_by [], sum;\n\tc = metric hardware_sentry.host.configured\n\t\t| latest\n\t\t| group_by [\"host.id\"], max;\n\td = metric hardware_sentry.connector.status\n\t\t| filter state == \"ok\"\n\t\t| reduce max\n\t\t| group_by [\"host.id\"], max;\njoin round((a * 5 + b * 15 + 10000 * (c - d)) / (a + b + 100 * (c - d)))"
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
        query_string = "with\n  a = metric hw.host.power | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 365d, mean | group_by [], mean;\njoin ((((a*b)*24)*365)), a=0, b=0"
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
        query_string = "with\n  a = metric hw.host.power | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 365d, mean | group_by [], mean;\n  c = metric hw.site.electricity_cost | reduce 365d, mean | group_by [], mean;\njoin ((((((a*b)*c)*24)*365)/1000)), a=0, b=0, c=0"
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
        query_string = "with\n  a = metric hw.host.power | reduce 365d, mean | group_by [], sum;\n  b = metric hw.site.pue | reduce 365d, mean | group_by [], mean;\n  c = metric hw.site.carbon_intensity_grams | latest 365d | group_by [], mean;\njoin (((((((a*b)*c)*24)*365)/1000)/1000000)), a=0, b=0, c=0"
      }

      subtitle = "t"
    }
  }
  group {
    rank            = 3
    title           = "Sites"
    visibility_type = "explicit"

    chart {
      name   = "Power (W)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "site"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.host.power\n| latest 5m\n| group_by [\"site\"], sum\n| point round(value)"
      }

      subtitle = ""
    }
    chart {
      name   = "PUE"
      type   = "timeseries"
      rank   = 1
      x_pos  = 8
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "site"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.site.pue\n| reduce 1d, mean\n| group_by [\"site\"], mean"
      }

      subtitle = ""
    }
    chart {
      name   = "Electricity Cost ($/kWh)"
      type   = "timeseries"
      rank   = 2
      x_pos  = 16
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "site"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.site.electricity_cost\n| reduce 1d, mean\n| group_by [\"site\"], mean"
      }

      subtitle = ""
    }
    chart {
      name   = "CO₂ Intensity (g)"
      type   = "timeseries"
      rank   = 3
      x_pos  = 24
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "site"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.site.carbon_intensity\n| reduce 1d, mean\n| group_by [\"site\"], mean"
      }

      subtitle = ""
    }
    chart {
      name   = "Ambient Temperature (°C)"
      type   = "timeseries"
      rank   = 4
      x_pos  = 32
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "site"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.host.ambient_temperature\n| reduce 1d, mean\n| group_by [\"site\"], mean\n| point round(value)"
      }

      subtitle = ""
    }
    chart {
      name   = "Heating Margin (°C)"
      type   = "timeseries"
      rank   = 5
      x_pos  = 40
      y_pos  = 0
      width  = 8
      height = 6

      query {
        query_name = "a"
        display    = "table"

        display_type_options {
          sort_by        = "site"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.host.heating_margin\n| reduce 1d, min\n| group_by [\"site\"], min\n| point round(value)"
      }

      subtitle = ""
    }
    chart {
      name        = "Yearly Energy Usage (Wh)"
      description = ""
      type        = "timeseries"
      rank        = 6
      x_pos       = 0
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a_b_24_365_1000"
        display      = "ordered_list"
        hidden       = false
        query_string = "with\n\ta = metric hw.host.energy\n\t\t| rate\n\t\t| group_by [\"site\"], sum;\n\tb = metric hw.site.pue\n\t\t| reduce mean\n\t\t| group_by [\"site\"], mean;\njoin round(a * b * 24 * 365 / 1000), a=0, b=0"
      }

      subtitle = ""
    }
    chart {
      name        = "Yearly Cost ($)"
      description = ""
      type        = "timeseries"
      rank        = 7
      x_pos       = 16
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a_b_c_24_365_1000"
        display      = "ordered_list"
        hidden       = false
        query_string = "with\n\ta = metric hw.host.energy\n\t\t| rate\n\t\t| group_by [\"site\"], sum;\n\tb = metric hw.site.pue\n\t\t| reduce mean\n\t\t| group_by [\"site\"], mean;\n\tc = metric hw.site.electricity_cost\n\t\t| reduce mean\n\t\t| group_by [\"site\"], mean;\njoin round(a * b * c * 24 * 365 / 1000), a=0, b=0, c=0"
      }

      subtitle = ""
    }
    chart {
      name        = "Yearly CO₂ Emissions  (tons)"
      description = ""
      type        = "timeseries"
      rank        = 8
      x_pos       = 32
      y_pos       = 6
      width       = 16
      height      = 8

      query {
        query_name   = "a_b_c_24_365_1000_1000000"
        display      = "ordered_list"
        hidden       = false
        query_string = "with\n\ta = metric hw.host.energy\n\t\t| rate\n\t\t| group_by [\"site\"], sum;\n\tb = metric hw.site.pue\n\t\t| reduce mean\n\t\t| group_by [\"site\"], mean;\n\tc = metric hw.site.carbon_intensity_grams\n\t\t| reduce mean\n\t\t| group_by [\"site\"], mean;\njoin a * b * c * 24 * 365 / 1000 / 1000000, a=0, b=0, c=0"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 4
    title           = "Power and Host Information"
    visibility_type = "explicit"

    chart {
      name        = "Top Consumers (W)"
      description = ""
      type        = "timeseries"
      rank        = 0
      x_pos       = 0
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name = "a"
        display    = "ordered_list"

        display_type_options {
          sort_by        = "value"
          sort_direction = "desc"
        }
        hidden       = false
        query_string = "metric hw.host.power | latest | group_by [\"site\", \"host.id\"], max"
      }

      subtitle = ""
    }
    chart {
      name        = "Power per Host Type (W)"
      description = ""
      type        = "timeseries"
      rank        = 1
      x_pos       = 16
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.host.power\n| latest\n| group_by [\"host.type\"], sum\n| point round(value)"
      }

      subtitle = ""
    }
    chart {
      name        = "Power per Host Type (%)"
      description = ""
      type        = "timeseries"
      rank        = 2
      x_pos       = 32
      y_pos       = 0
      width       = 16
      height      = 8

      query {
        query_name = "a"
        display    = "bar"

        display_type_options {
          y_axis_min = 0
          y_axis_max = 100
        }
        hidden       = false
        query_string = "with\n\thostTypePower = metric hw.host.power\n\t\t| latest\n\t\t| group_by [\"host.type\"], sum;\n\ttotalPower = metric hw.host.power\n\t\t| latest\n\t\t| group_by [], sum;\njoin round(hostTypePower * 100 / totalPower)"
      }

      subtitle = ""
    }
    chart {
      name        = "Hosts Type"
      description = ""
      type        = "timeseries"
      rank        = 3
      x_pos       = 0
      y_pos       = 8
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.host.configured\n| latest\n| group_by [\"host.type\"], sum"
      }

      subtitle = ""
    }
    chart {
      name        = "Hosts Vendor"
      description = ""
      type        = "timeseries"
      rank        = 4
      x_pos       = 16
      y_pos       = 8
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.status | filter ((\"hw.type\" == \"enclosure\") && (\"state\" == \"present\")) | latest | group_by [\"vendor\"], count"
      }

      subtitle = ""
    }
    chart {
      name        = "Power per Platform Type (W)"
      description = ""
      type        = "timeseries"
      rank        = 5
      x_pos       = 32
      y_pos       = 8
      width       = 16
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hw.host.power\n| latest\n| group_by [\"os.type\"], sum\n| point round(value)"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 5
    title           = "Hosts Temperatures"
    visibility_type = "explicit"

    chart {
      name   = "Host Ambient Temperature (°C)"
      type   = "timeseries"
      rank   = 0
      x_pos  = 0
      y_pos  = 0
      width  = 24
      height = 8

      query {
        query_name   = "a"
        display      = "ordered_list"
        hidden       = false
        query_string = "metric hw.host.ambient_temperature\n| latest\n| group_by [\"host.name\", \"site\"], sum\n| point round(value)"
      }

      subtitle = ""
    }
    chart {
      name   = "Host Highest Temperature (°C)"
      type   = "timeseries"
      rank   = 1
      x_pos  = 24
      y_pos  = 0
      width  = 24
      height = 8

      query {
        query_name   = "a"
        display      = "ordered_list"
        hidden       = false
        query_string = "metric hw.temperature | latest | group_by [\"host.name\", \"site\"], max"
      }

      subtitle = ""
    }
  }
  group {
    rank            = 6
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
      height      = 8

      query {
        query_name   = "a"
        display      = "table"
        hidden       = false
        query_string = "metric hardware_sentry.agent.info | latest | group_by [\"site\", \"version\", \"build_date\", \"hc_version\"], sum"
      }

      subtitle = ""
    }
  }

  label {
    key   = ""
    value = "hardware"
  }
}
