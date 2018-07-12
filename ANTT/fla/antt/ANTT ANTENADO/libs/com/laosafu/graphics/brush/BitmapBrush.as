package com.laosafu.graphics.brush
{
	import flash.display.Graphics;
	import flash.display.BitmapData;
	import flash.geom.Matrix;


public class BitmapBrush implements IBrush{
	
	public var bitmapData:BitmapData;
	public var matrix:Matrix;
	public var repeat:Boolean;
	public var smooth:Boolean;
	
	public function BitmapBrush(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false){
		this.bitmapData=bitmap;
		this.matrix=matrix;
		this.repeat=repeat;
		this.smooth=smooth;
	}
	
	public function fill(target:Graphics):void{
		target.beginBitmapFill(this.bitmapData,this.matrix,this.repeat,this.smooth);
	}	
}

}