package com.laosafu{
	import flash.display.Sprite;
	import com.laosafu.chart.CircleChart;	
    import org.aswing.ASColor;
	
	public class CChart extends Sprite{
		private var radiusArr:Array = [40,150];
		private var radiusInt:Array = [150];
		
		private var radius1:Array = [130,180];
		private var radius2:Array = [78,128];
		private var radius3:Array = [76];
		
		private var data1:Array = [34,22,57,28,15,78,45,58];
		private var data2:Array = [57,24,46,23,15,54,37,80];
		private var data3:Array = [33,24,23,56,21,44,23,46];
		public function CChart(){
			var circleChart1:CircleChart = createChart(radius1,data1);
			var circleChart2:CircleChart = createChart(radius2,data2);
			var circleChart3:CircleChart = createChart(radius3,data3);
			circleChart1.x = 200;
			circleChart1.y = 200;
			addChild(circleChart1);
			circleChart1.addChild(circleChart2);
			circleChart1.addChild(circleChart3);			
			var circleChart4:CircleChart = createChart(radiusArr,data1);
			var circleChart5:CircleChart = createChart(radiusInt,data2);
			circleChart4.x = 440;
			circleChart4.y = 440;
			circleChart5.x = 560;
			circleChart5.y = 160;
			addChild(circleChart4);
			addChild(circleChart5);
		}
		
		private function createChart(radius:Array, datas:Array):CircleChart{
			var circleChart:CircleChart = new CircleChart();			
			circleChart.radius = radius;			
            circleChart.chartData.data = datas;      
			var len:uint = circleChart.chartData.data.length;
			circleChart.init();
            circleChart.bevelMode = true;
			for(var i:uint = 0; i < len; i++){
	           var color:ASColor = new ASColor(Math.round((Math.random() * 0xFFFFFF)));
	           circleChart.fillColor([color,color.darker(0.7)], i);	
            }
            circleChart.draw();
			return circleChart;
		}
	}
}