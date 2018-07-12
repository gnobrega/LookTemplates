package com.laosafu.graphics.pen{	
	import com.laosafu.graphics.pen.IPen;	
	import flash.display.Graphics;
	
	public class SolidPen implements IPen{
		public var color:uint;
		public var alpha:Number;
		public var thickness:Number;
		public var pixelHinting:Boolean;
		public var scaleMode:String;
		public var caps:String;
		public var joints:String;
		public var miterLimit:Number;
		
		public function SolidPen(thickness:Number = 1, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3){
		    this.thickness = thickness;
			this.color = color;
			this.alpha = alpha;
			this.pixelHinting = pixelHinting;
			this.scaleMode = scaleMode;
			this.caps = caps;
			this.joints = joints;
			this.miterLimit = miterLimit;
		}
		
		public function line(target:Graphics):void{			
			target.lineStyle(thickness,color,alpha,pixelHinting,scaleMode,caps,joints,miterLimit);			
		}
		
		public function toString():String{
		    return ("[线条宽度："+thickness+" ,颜色："+color+" ,透明度："+alpha+" ,pixelHinting："+pixelHinting+" ,缩放模式："+scaleMode+" ,caps："+caps+" ,joints："+joints+" ,miterLimit："+miterLimit+"]");
	    }
	}	
}