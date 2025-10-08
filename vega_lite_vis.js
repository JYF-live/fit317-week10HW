var vg_1 = "vega_gust_map.json";
vegaEmbed("#map_chart", vg_1, {
    width: 400,
    height: 300,
    actions: false
}).then(function(result) {
    // Optional: resize chart when window resizes
    window.addEventListener('resize', function() {
        result.view.resize();
    });
}).catch(console.error);

var vg_2 = "stacked_area_chart_vega.json";
vegaEmbed("#stacked_chart", vg_2, {
    width: 400,
    height: 300,
    actions: false
}).then(function(result) {
    // Optional: resize chart when window resizes
    window.addEventListener('resize', function() {
        result.view.resize();
    });
}).catch(console.error);
