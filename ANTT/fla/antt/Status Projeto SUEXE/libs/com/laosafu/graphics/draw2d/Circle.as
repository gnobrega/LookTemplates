package com.laosafu.graphics.draw2d{
	//===========================
	//  绘制圆
	//===========================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	
	public class Circle implements IDraw{
		private var x:Number;
		private var y:Number;		
		private var radius:Number;
		
		
		public function Circle(x:Number, y:Number, radius:Number){
			this.x = x;
			this.y = y;
			this.radius = radius;			
		}
		
		public function draw(target:Graphics):void{
			target.drawCircle(x,y,radius);			
		}
	}
}