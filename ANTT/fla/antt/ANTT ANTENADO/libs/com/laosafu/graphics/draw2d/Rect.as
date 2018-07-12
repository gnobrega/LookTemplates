
package com.laosafu.graphics.draw2d{
	/*
	@@绘制矩形类
	*/
	import com.laosafu.graphics.draw2d.IDraw;
	import flash.display.Graphics;
	
	public class Rect implements IDraw{
		private var _width:Number;
		private var _height:Number;
		private var _x:Number;
		private var _y:Number;		
		
		//====================================
		//	Constructor
		//====================================
		/**
		* 绘制矩形
		* @width      矩形宽度
		* @height     矩形高度
		* @x          矩形左上角x坐标
		* @y          短形左上角y坐标
		*/
		public function Rect(width:Number, height:Number, x:Number = 0, y:Number = 0){
			_width = width;
			_height = height;
			_x = x;
			_y = y;
		}
		
		//====================================
		//	public Methods
		//====================================
		/**
		* 绘制
		* @target      Graphics对象		
		*/
		
		public function draw(target:Graphics):void{			
			target.drawRect(_x, _y, _width, _height);			
		}
	}
}