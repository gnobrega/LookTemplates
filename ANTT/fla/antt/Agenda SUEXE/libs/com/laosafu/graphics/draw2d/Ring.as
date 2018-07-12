package com.laosafu.graphics.draw2d{
	//==============================
	//绘制环形
	//==============================
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class Ring implements IDraw{
		private var centerPoint:Point;
		private var _x:Number;
		private var _y:Number;
		private var _radiusIn:Number;
		private var _radiusOut:Number;
		private var _arc:Number;
		private var _startingAngle:Number;
		private var _radialArcs:Boolean;
		//====================================
		//	Constructor
		//====================================
		/**
		* 绘制环形
		* @x              弧线中心（圆心）X坐标
		* @y              弧线中心（圆心）Y坐标
		* @radiusIn       内圆半径
		* @radiusOut      外圆半径
		* @arc            弧线的角度，以度数指定
		* @startingAngle  弧线的开始角度,预设值为0
		* @radialArcs    布尔值，指出是否绘制半径线把弧线连接至圆心
		*/
		public function Ring(x:Number, y:Number, radiusIn:Number, radiusOut:Number, arc:Number, startingAngle:Number = 0, radialArcs:Boolean = true){
			centerPoint = new Point(x,y);
			this._x = x;
			this._y = y;
			this._radiusIn = radiusIn;
			this._radiusOut = radiusOut;
			this._arc = arc
			this._startingAngle = startingAngle
			this._radialArcs = radialArcs;
		}
		//====================================
		//	public Method
		//====================================
		public function draw(target:Graphics):void{
			if(_arc > 360){
				_arc = 360;
			}
			//夹角转化为弧度
			var arcRadian:Number = Math.PI/180 * _arc;
			//弧线的开始角度转化为弧度
			var startAngleRadian:Number = Math.PI/180 * _startingAngle;			
			//把弧度平均分为8段
			var nAngleDelta:Number = arcRadian/8;
			//分8段之后,求出圆心到二条切线交叉的距离
			var ctrlDircIn:Number = _radiusIn/Math.cos(nAngleDelta/2);
			var ctrlDircOut:Number = _radiusOut/Math.cos(nAngleDelta/2);
			//起始弧度
			var nAngle:Number = startAngleRadian;			
			var startInX:Number = _radiusIn * Math.cos(startAngleRadian) + _x;
			var startInY:Number = _radiusIn * Math.sin(startAngleRadian) + _y;
			var endInX:Number = _radiusIn * Math.cos(startAngleRadian + arcRadian) + _x;
			var endInY:Number = _radiusIn * Math.sin(startAngleRadian + arcRadian) + _y;
			var startOutX:Number = _radiusOut * Math.cos(startAngleRadian) + _x;
			var startOutY:Number = _radiusOut * Math.sin(startAngleRadian) + _y;
			var endOutX:Number = _radiusOut * Math.cos(startAngleRadian + arcRadian) + _x;
			var endOutY:Number = _radiusOut * Math.sin(startAngleRadian + arcRadian) + _y;
			target.moveTo(startInX, startInY);
			tmpDraw(target,nAngle,nAngleDelta,ctrlDircIn,_radiusIn);
			if(_radialArcs){
				target.lineTo(endOutX, endOutY);
			}
			else{
				target.moveTo(endOutX, endOutY);
			}			
			tmpDraw(target,startAngleRadian+arcRadian,-nAngleDelta,ctrlDircOut,_radiusOut);
			if(_radialArcs){
				target.lineTo(startInX, startInY);
			}			
		}
		
		private function tmpDraw(target:Graphics, nAngle:Number, nAngleDelta:Number, ctrlDirc:Number, radius:Number):void{
			for(var i:uint = 0; i < 8; i++){
				nAngle += nAngleDelta;
				//求出控制点坐标
				var controlX:Number = Math.cos((nAngle - nAngleDelta/2)) * ctrlDirc + _x;
			    var controlY:Number = Math.sin((nAngle - nAngleDelta/2)) * ctrlDirc + _y;
				//求出画曲线的另一点坐标
				var anchorX:Number = Math.cos(nAngle) * radius + _x;
				var anchorY:Number = Math.sin(nAngle) * radius + _y;
				//画曲线线段
				target.curveTo(controlX,controlY,anchorX,anchorY);
			}
		}
		
		public function toString():String{
			return "圆心:(" + _x + "," + _y + ") 内半径:" + _radiusIn + " 外半径:" + _radiusOut + " 夹角:" + _arc + " 起始角度:" + _startingAngle + "\n";
		}
	}
	
}