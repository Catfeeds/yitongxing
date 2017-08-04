/**
 * 模块化单文件引入 案例
 * 
 */
var developMode = false;

if (developMode) {
    // for develop
    require.config({
        packages: [
            {
                name: 'echarts',
                location: '/static/scripts/echarts/echarts-2.0.2/src',
                main: 'echarts'
            },
            {
                name: 'zrender',
//                location: 'http://ecomfe.github.io/zrender/src',
                location: '/static/scripts/echarts/zrender-2.0.2/src',
                main: 'zrender'
            }
        ]
    });
}
else {
    // for echarts online home page
    var fileLocation = '/static/scripts/echarts/echarts-2.0.2/build/echarts-map';
    require.config({
        paths:{ 
             echarts: fileLocation,
            'echarts/chart/line': fileLocation,
            'echarts/chart/bar': fileLocation,
            'echarts/chart/scatter': fileLocation,
            'echarts/chart/k': fileLocation,
            'echarts/chart/pie': fileLocation,
            'echarts/chart/radar': fileLocation,
            'echarts/chart/map': fileLocation,
            'echarts/chart/chord': fileLocation,
            'echarts/chart/force': fileLocation,
            'echarts/chart/gauge': fileLocation,
            'echarts/chart/funnel': fileLocation
        }
    });
}

//按需加载
function loadEcharts() {
	
	require(
		    [
		        'echarts',
		        'echarts/chart/line',
		        'echarts/chart/bar',
		        'echarts/chart/scatter',
		        'echarts/chart/k',
		        'echarts/chart/pie',
		        'echarts/chart/radar',
		        'echarts/chart/force',
		        'echarts/chart/chord',
		        'echarts/chart/map',
		        'echarts/chart/gauge',
		        'echarts/chart/funnel'
		    ],
		    function (ec) {
		        var myChart = ec.init(domMain);
		        var option = {
		            ...
		        }
		        myChart.setOption(option);
		    }
		);
}
//
