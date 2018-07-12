package com.laosafu.chart.data{
	/*
	pie图
	*/
	public class ArcChart{
		//圆心x坐标
		public var x:Number;
		//圆心y坐标
		public var y:Number;
		//半径数组，当数组长度为1时,表示圆，是数组长度为2时，表示环状
		public var radius:Array;
		//饼的夹角
		public var angle:Number;				
		//饼的旋转角度，以顺时针为正
		public var rotation:Number;
		
		//判断饼图形状，是圆还是环
		public static const ARC:String = "arc";
		public static const RING:String = "ring";		
		public function get outLine():String{			
			return IsArc();
		}
				
		public function ArcChart(x:Number = 0, y:Number = 0, radius:Array = null, angle:Number = 0, rotation:Number = 0){
			this.x = x;
			this.y = y;
			this.radius = radius;
			this.angle = angle;
			this.rotation = rotation;			
		}
		
		private function IsArc():String{
			var tmp:String = null;
			if(radius is Array){
				if(radius.length == 1){
					tmp = ARC;
				}else if(radius.length == 2){
					tmp = RING; 
				}
			}
			return tmp;
		}
		
				
		public function toString():String{
			return "[圆心x坐标:" + this.x + " 圆心y坐标:" + this.y + " 半径数组：[" + this.radius + "] 夹角:" + this.angle + " 旋转角度:" + this.rotation + " 外形:" + this.outLine + "]";
		}
	}
}