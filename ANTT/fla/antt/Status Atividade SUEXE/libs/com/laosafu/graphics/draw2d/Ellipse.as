package com.laosafu.graphics.draw2d{
	//===========================
	//  绘制椭圆
	//===========================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	
	public class Ellipse implements IDraw{
		private var x:Number;
		private var y:Number;		
		private var width:Number;
		private var height:Number;
		
		
		public function Ellipse(x:Number, y:Number, width:Number, height:Number){
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		public function draw(target:Graphics):void{
			target.drawEllipse(x,y,width,height);			
		}
	}
}