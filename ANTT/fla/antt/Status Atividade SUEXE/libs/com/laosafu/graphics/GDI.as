/**绘图类*/
package com.laosafu.graphics{
	import flash.display.Graphics;	
	import com.laosafu.graphics.draw2d.IDraw;
	import com.laosafu.graphics.brush.IBrush;
	import com.laosafu.graphics.pen.IPen;	
	
	public class GDI{
		private var _target:Graphics;
		
		public function GDI(target:Graphics = null){			
			this._target = target;
		}
		
		public function set target(tar:Graphics):void{
			_target = tar;
		}
		
		public function get target():Graphics{
			return _target;
		}
		
		public function draw(d:IDraw, ...para):void{
			var n:uint = para.length;
			if(n == 0){
				d.draw(_target);
			}
			if(n == 1){
				if(para[0] is IBrush){
					fill(d, para[0]);
				}
				else if(para[0] is IPen){
					line(d, para[0]);
				}
			}
			if(n == 2){
				if((para[0] is IPen) && (para[1] is IBrush)){
					lineAndfill(d, para[0], para[1]);
				}
			}
		}
		
		private function fill(d:IDraw, b:IBrush):void{
			startFill(b);
			d.draw(_target);									
			endFill();			
		}
		
		private function line(d:IDraw, p:IPen):void{
			startPen(p);
			d.draw(_target);
			endPen();
		}
		
		private function lineAndfill(d:IDraw, p:IPen, b:IBrush):void{			
			startPen(p);
			startFill(b);
			d.draw(_target);
			endFill();
			endPen();
		}
		
		private function startFill(b:IBrush):void{
			b.fill(_target);
		}
		
		private function endFill():void{
			_target.endFill();
			_target.moveTo(0,0);
		}
		
		private function startPen(p:IPen):void{
			p.line(_target);
		}
		
		private function endPen():void{
			_target.lineStyle();
			_target.moveTo(0,0);
		}
	}
}