package com.laosafu.graphics.draw2d{
	//===========================
	//  绘制线段
	//===========================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	
	public class Line implements IDraw{
		private var startX:Number;
		private var startY:Number;
		private var endX:Number;
		private var endY:Number;
		
		public function Line(startX:Number, startY:Number, endX:Number, endY:Number){
			this.startX = startX;
			this.startY = startY;
			this.endX = endX;
			this.endY = endY;
		}
		
		public function draw(target:Graphics):void{
			target.moveTo(startX, startY);
			target.lineTo(endX, endY);
		}
	}
}