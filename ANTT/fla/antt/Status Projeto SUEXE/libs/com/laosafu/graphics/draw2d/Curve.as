package com.laosafu.graphics.draw2d{
	//===========================
	//  绘制曲线
	//===========================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	
	public class Curve implements IDraw{
		private var startX:Number;
		private var startY:Number;
		private var ctrlX:Number;
		private var ctrlY:Number;
		private var endX:Number;
		private var endY:Number;
		
		public function Curve(startX:Number, startY:Number, ctrlX:Number, ctrlY:Number, endX:Number, endY:Number){
			this.startX = startX;
			this.startY = startY;
			this.ctrlX = ctrlX;
			this.ctrlY = ctrlY;
			this.endX = endX;
			this.endY = endY;
		}
		
		public function draw(target:Graphics):void{
			target.moveTo(startX, startY);
			target.curveTo(ctrlX, ctrlY, endX, endY);
		}
	}
}