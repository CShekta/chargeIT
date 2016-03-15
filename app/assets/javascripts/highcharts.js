$(function () {

    var honda = 29/100.0 * gon.carbon_perkWh;
    var gallonToCarbon = 20;
    console.log(honda);
    // Create the chart
    $('#MPG-comparison').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: 'Vehicle Comparisons'
        },
        xAxis: {
            type: 'Vehicle'
        },
        yAxis: {
            title: {
                text: 'lbs Of Carbon Per Mile '
            }

        },
        legend: {
            enabled: false
        },
        plotOptions: {
            series: {
                borderWidth: 0,
                dataLabels: {
                    enabled: false,
                    format: '{point.y:.1f}'
                }
            }
        },
        series: [{
            name: 'CO2/mile',
            data: [{
                name: 'Ford F150 Pickup 2WD (2015)',
                y: 22.0 / gallonToCarbon,
            }, {
                name: 'Toyota Camry Sedan (2015)',
                y: 25.0 / gallonToCarbon,
            }, {
                name: 'Honda Accord (2015)',
                y: 29.0 / gallonToCarbon,
            }, {
                name: 'Honda Fit EV (2014)',
                y: honda,
            }, {
                name: 'Nissan Leaf (2016)',
                y: 30/100.0 * gon.carbon_perkWh,
            }, {
                name: 'Tesla Model S AWD - 70D (2016)',
                y: 33/100.0 * gon.carbon_perkWh,
            },
          ]
        }],
    });
});
