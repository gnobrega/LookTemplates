package com.laosafu.graphics.pen{
	import com.laosafu.graphics.parameter.Gradient;
	import com.laosafu.graphics.pen.IPen;
	import flash.display.Graphics;	
	import flash.geom.Matrix;
	import flash.display.GradientType;
	
	public class GradientPen extends Gradient implements IPen{
		public var thickness:Number;
		public static const LINEAR:String = GradientType.LINEAR;
	    public static const RADIAL:String = GradientType.RADIAL; 
		public function GradientPen(thickness:Number, type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0){
			this.thickness = thickness;
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
		    return ("[线条宽度："+this.thickness+" ,[类型："+this.type+" ,颜色数组：["+this.colors+"] ,透明数组：["+this.alphas+"] ,颜色分布：["+this.ratios+"] ,矩阵对象："+this.matrix+" ,spreadMethod："+this.spreadMethod+" ,interpolationMethod："+this.interpolationMethod+" ,focalPointRatio："+this.focalPointRatio+"]");
	    }
		public function line(target:Graphics):void{
			target.lineStyle(thickness);
			target.graphics.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);			
		}
	}
}
