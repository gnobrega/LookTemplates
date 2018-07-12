package com.laosafu.graphics.draw2d{
	//===========================
	//  绘制三解形
	//===========================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	/**
	@x         三角形重心x坐标
	@y         三角形重心y坐标
	@ab        ab边的长度
	@ac        ac边的长度
	@angle     二线段的夹角,以角度为单位
	@rotation  旋转角度,以角度为单位
	*/
	public class Triangle implements IDraw{
		private var x:Number;
		private var y:Number;
		private var ab:Number;
		private var ac:Number;
		private var angle:Number;
		private var rotation:Number;
		
		public function Triangle(x:Number, y:Number, ab:Number, ac:Number, angle:Number, rotation:Number = 0){
			this.x = x;
			this.y = y;
			this.ab = ab;
			this.ac = ac;
			this.angle = angle;
			this.rotation = rotation;
		}
		
		public function draw(target:Graphics):void{
			if(angle >= 180){
				return;				
			}
			angle *= Math.PI/180;
			rotation *= Math.PI/180;
			var bX:Number = ab * Math.cos(angle - rotation);
			var bY:Number = ab * Math.sin(angle - rotation);
			var cX:Number = ac * Math.cos(-rotation);
			var cY:Number = ac * Math.sin(-rotation);
			var centerX:Number = 0;
			var centerY:Number = 0;			
			target.moveTo(-centerX + x, -centerY + y);
			target.lineTo(cX - centerX + x, cY - centerY + y);
			target.lineTo(bX - centerX + x, bY - centerY + y);
			target.lineTo(-centerX + x, -centerY + y);
		}
	}
}