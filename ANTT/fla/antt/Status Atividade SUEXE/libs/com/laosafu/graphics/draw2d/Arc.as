package com.laosafu.graphics.draw2d{
	//==============================
	//绘制弧线
	//==============================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	
	public class Arc implements IDraw{
		private var _x:Number;
		private var _y:Number;
		private var _radius:Number;
		private var _arc:Number;
		private var _startingAngle:Number;
		private var _radialLines:Boolean;
		//====================================
		//	Constructor
		//====================================
		/**
		* 绘制弧线
		* @x              弧线中心（圆心）X坐标
		* @y              弧线中心（圆心）Y坐标
		* @radius         半径
		* @arc            弧线的角度，以度数指定
		* @startingAngle  弧线的开始角度,预设值为0
		* @radialLines    布尔值，指出是否绘制半径线把弧线连接至圆心
		*/
		public function Arc(x:Number, y:Number, radius:Number, arc:Number, startingAngle:Number = 0, radialLines:Boolean = false){
			this._x = x;
			this._y = y;
			this._radius = radius;
			this._arc = arc
			this._startingAngle = startingAngle
			this._radialLines = radialLines
		}
		//====================================
		//	public Method
		//====================================
		public function draw(target:Graphics):void{
			if(_arc > 360){
				_arc = 360;
			}
			//夹角转化为弧度
			var _arcRadian:Number = Math.PI/180 * _arc;
			//弧线的开始角度转化为弧度
			var _startAngleRadian:Number = Math.PI/180 * _startingAngle;			
			//把弧度平均分为8段
			var nAngleDelta:Number = _arcRadian/8;
			//分8段之后,求出圆心到二条切线交叉的距离
			var ctrlDirc:Number = _radius/Math.cos(nAngleDelta/2);			
			var nAngle:Number = _startAngleRadian;
			//求出弧线初始坐标
			var startX:Number = _radius * Math.cos(_startAngleRadian) + _x;
			var startY:Number = _radius * Math.sin(_startAngleRadian) + _y;
			if(_radialLines){
				target.moveTo(_x, _y);
				target.lineTo(startX, startY);
			}
			else{
				target.moveTo(startX, startY);
			}
			for(var i:uint = 0; i < 8; i++){
				nAngle += nAngleDelta;
				//求出控制点坐标
				var controlX:Number = Math.cos((nAngle - nAngleDelta/2)) * ctrlDirc + _x;
			    var controlY:Number = Math.sin((nAngle - nAngleDelta/2)) * ctrlDirc + _y;
				//求出画曲线的另一点坐标
				var anchorX:Number = Math.cos(nAngle) * _radius + _x;
				var anchorY:Number = Math.sin(nAngle) * _radius + _y;
				//画曲线线段
				target.curveTo(controlX,controlY,anchorX,anchorY);
			}
			if(_radialLines){
				target.lineTo(_x, _y);
			}			
		}
	}
	
}