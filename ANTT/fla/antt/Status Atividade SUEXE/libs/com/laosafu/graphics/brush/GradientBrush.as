package com.laosafu.graphics.brush{
	import com.laosafu.graphics.parameter.Gradient;
	import com.laosafu.graphics.brush.IBrush;
	import flash.display.Graphics;	
	import flash.geom.Matrix;
	import flash.display.SpreadMethod;
	import flash.display.InterpolationMethod;
	import flash.display.GradientType;
	
	public class GradientBrush extends Gradient implements IBrush{
		public static const LINEAR:String = GradientType.LINEAR;
	    public static const RADIAL:String = GradientType.RADIAL;
		public function GradientBrush(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = SpreadMethod.PAD, interpolationMethod:String = InterpolationMethod.RGB, focalPointRatio:Number = 0){
			this.type = type;
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			this.matrix = matrix;
			this.spreadMethod = spreadMethod;
			this.interpolationMethod = interpolationMethod;
			this.focalPointRatio = focalPointRatio;
		}
		public function toString():String{
		    return ("[类型："+this.type+" ,颜色数组：["+this.colors+"] ,透明数组：["+this.alphas+"] ,颜色分布：["+this.ratios+"] ,矩阵对象："+this.matrix+" ,spreadMethod："+this.spreadMethod+" ,interpolationMethod："+this.interpolationMethod+" ,focalPointRatio："+this.focalPointRatio+"]");
	    }
		
		public function fill(target:Graphics):void{
			target.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);				
		}
	}
}
