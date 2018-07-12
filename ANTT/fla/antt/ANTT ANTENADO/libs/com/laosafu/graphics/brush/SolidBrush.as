package com.laosafu.graphics.brush{	
	import com.laosafu.graphics.brush.IBrush;
	import flash.display.Graphics;
	
	public class SolidBrush implements IBrush{
		public var color:uint;
		public var alpha:Number;
		
		public function SolidBrush(color:uint = 0xFFFFFF, alpha:Number = 1){
			this.color = color;
			this.alpha = alpha;
		}
		
		public function toString():String{
		    return ("[颜色："+this.color+" ,透明度："+this.alpha+"]");
	    }
		
		public function fill(target:Graphics):void{			
		   target.beginFill(this.color, this.alpha);			
		}
	}
}