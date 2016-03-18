$(function () {

    // var honda = 29/100.0 * gon.carbon_perkWh;
    var averageEV = 0.7;
    var gallonToCarbon = 20;
    // Create the chart
    $('#MPG-comparison').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            categories: ['Ford', 'Toyota', 'Honda Accord', 'Average EV'],
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
                name: 'Average Electric Vehicle (2016)',
                y: averageEV,
            },
          ]
        }],
    });
});
