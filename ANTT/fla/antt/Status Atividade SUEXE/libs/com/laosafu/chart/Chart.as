package com.laosafu.chart{
	import flash.display.Sprite;	
    import com.laosafu.graphics.GDI;
	import com.laosafu.chart.data.ChartData;
	
	public class Chart extends Sprite{
		private var _chartData:ChartData;
		private var _graph:GDI;
		
		public function Chart(chartData:ChartData = null){
			this._graph = new GDI(this.graphics);
			this._chartData = chartData;
			if(!this._chartData){
				this._chartData = new ChartData();
			}			
		}
		
		public function get chartData():ChartData{
			return this._chartData;
		}
		
		public function get graph():GDI{
			return this._graph;
		}		
	}	
}