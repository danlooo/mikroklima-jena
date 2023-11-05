#!/usr/bin/env

function(input, output, session) {
  selected_site <- reactiveVal("WB4")
  observeEvent(input$map_marker_click, {
    input$map_marker_click$id  |> selected_site()
  })
  
  # selected_site <- reactive(input$map_marker_click$id)
  
  output$map <- renderLeaflet({
    leaflet(data = sites) |>
      addTiles() |>
      addMarkers(
        lng = ~Longitude_WGS84_E,
        lat = ~Latitude_WGS84_N,
        layerId = ~WZE_ID,
        label = ~ str_glue("Station {WZE_ID} in {elevation}m Höhe")
      )
  })
  
  output$temp_span_plt <- renderPlot({
    if (input$show_all_points) {
      temp_stats |>
        filter(WZE_ID == selected_site()) |>
        ggplot(aes(date, temp_span, fill = elevation_group)) +
        stat_smooth(data = temp_stats_groups, method = "loess", color = NA) +
        geom_point(color = current_site_color) +
        stat_smooth(method = "loess", color = current_site_color, se = FALSE) +
        scale_color_manual(values = elevatioon_group_colors) +
        scale_fill_manual(values = elevatioon_group_colors) +
        guides(col = "none") +
        labs(
          x = "Zeit [Tag]",
          y = "Temperaturspanne im Tagesverlauf [°C]",
          fill = "Höhe"
        )
    } else {
      temp_stats |>
        filter(WZE_ID == selected_site()) |>
        ggplot(aes(date, temp_span, fill = elevation_group)) +
        stat_smooth(data = temp_stats_groups, method = "loess", color = NA) +
        stat_smooth(method = "loess", color = current_site_color, se = FALSE) +
        scale_color_manual(values = c(Berg = "#283618", Tal = "#b5838d")) +
        scale_fill_manual(values = c(Berg = "#283618", Tal = "#b5838d")) +
        guides(col = "none") +
        labs(
          x = "Zeit [Tag]",
          y = "Temperaturspanne im Tagesverlauf [°C]",
          fill = "Höhe"
        )
    }
  })
  
  output$current_station_text <- renderText({
    selected_site_vals <- sites |> filter(WZE_ID == selected_site()) |> as.list()
    str_glue("Ausgewählte Messtation: {selected_site_vals$WZE_ID} in {selected_site_vals$elevation}m Höhe")
  })
}