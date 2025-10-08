var vg_1 = "vega_gust_map.json";
vegaEmbed("#map_chart", vg_1, {
    width: 400,
    height: 300,
    actions: false
}).then(function(result) {
    
}).catch(console.error);

var vg_2 = "bar_chart_windy_days.json";
vegaEmbed("#bar_chart", vg_2, {
    width: 400,
    height: 300,
    actions: false
}).then(function(result) {
}).catch(console.error);
