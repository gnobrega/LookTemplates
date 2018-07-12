package com.laosafu.graphics.draw2d{
	//===========================
	//  绘制圆角矩形
	//===========================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	
	public class RoundRect implements IDraw{
		private var x:Number;
		private var y:Number;		
		private var width:Number;
		private var height:Number;
		private var ellipseWidth:Number;
		private var ellipseHeight:Number;
		
		public function RoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number = 10, ellipseHeight:Number = 10){
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.ellipseWidth = ellipseWidth;
			this.ellipseHeight = ellipseHeight;
		}
		
		public function draw(target:Graphics):void{
			target.drawRoundRect(x,y,width,height,ellipseWidth,ellipseHeight);			
		}
	}
}