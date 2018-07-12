package com.laosafu{	
	import flash.filters.*;
	import flash.display.BitmapData;
	import flash.geom.Point;
	public class ASFilter{		
		public function ASFilter(){
		}		
		/*
		distance:Number (default = 4.0) — 斜角的偏移距离，以像素为单位（浮点）。  
        angle:Number (default = 45) — 斜角的角度，0 至 360 度。  
        highlightColor:uint (default = 0xFFFFFF) — 斜角的加亮颜色，0xRRGGBB。  
        highlightAlpha:Number (default = 1.0) — 加亮颜色的 Alpha 透明度值。 有效值为 0.0 到 1.0。 例如，.25 设置透明度值为 25%。  
        shadowColor:uint (default = 0x000000) — 斜角的阴影颜色，0xRRGGBB。  
        shadowAlpha:Number (default = 1.0) — 阴影颜色的 Alpha 透明度值。 有效值为 0.0 到 1.0。 例如，.25 设置透明度值为 25%。  
        blurX:Number (default = 4.0) — 水平模糊量，以像素为单位。 有效值为 0 到 255.0（浮点）。  
        blurY:Number (default = 4.0) — 垂直模糊量，以像素为单位。 有效值为 0 到 255.0（浮点）。  
        strength:Number (default = 1) — 印记或跨页的强度。 该值越高，压印的颜色越深，而且斜角与背景之间的对比度也越强。 有效值为 0 到 255.0。  
        quality:int (default = 1) — 斜角的品质。 有效值为 0 至 15，但是对于大多数应用，可以使用 BitmapFilterQuality 常数： 
        BitmapFilterQuality.LOW
        BitmapFilterQuality.MEDIUM
        BitmapFilterQuality.HIGH
        这些值越低，滤镜的呈现速度就越快。 可以使用其它可用的数值来实现不同的效果。
        type:String (default = "inner") — 斜角类型。 有效值为 BitmapFilterType 常数：BitmapFilterType.INNER、BitmapFilterType.OUTER 或 BitmapFilterType.FULL。  
        knockout:Boolean (default = false) — 应用挖空效果 (true)，这将有效地使对象的填色变为透明，并显示文档的背景颜色。
		*/
		public static function getBevelFilter(distance:Number = 4.0,
											  angle:Number = 45,
											  highlightColor:uint = 0xFFFFFF,
											  highlightAlpha:Number = 1.0,
											  shadowColor:uint = 0x000000,
											  shadowAlpha:Number = 1.0,
											  blurX:Number = 4.0,
											  blurY:Number = 4.0,
											  strength:Number = 1,
											  quality:int = 1,
											  type:String = "inner",
											  knockout:Boolean = false):BitmapFilter{
			return new BevelFilter(distance,
                                   angle,
                                   highlightColor,
                                   highlightAlpha,
                                   shadowColor,
                                   shadowAlpha,
                                   blurX,
                                   blurY,
                                   strength,
                                   quality,
                                   type,
                                   knockout);
			
		}
		/*
		参数
        blurX:Number (default = 4.0) — 水平模糊量。 有效值为 0 到 255.0（浮点值）。  
        blurY:Number (default = 4.0) — 垂直模糊量。 有效值为 0 到 255.0（浮点值）。  
        quality:int (default = 1) — 应用滤镜的次数。 您可以使用 BitmapFilterQuality 常数来指定品质： 
        flash.filters.BitmapFilterQuality.LOW
        flash.filters.BitmapFilterQuality.MEDIUM
        flash.filters.BitmapFilterQuality.HIGH 
		*/
		public static function getBlurFilter(blurX:Number = 4.0, blurY:Number = 4.0, quality:int = 1):BitmapFilter{
			return new BlurFilter(blurX,blurY,quality);
		}
		/*
		参数
        matrixX:Number (default = 0) — 矩阵的 x 维度（矩阵中列的数目）。 默认值为 0。  
        matrixY:Number (default = 0) — 矩阵的 y 维度（矩阵中行的数目）。 默认值为 0。  
        matrix:Array (default = null) — 用于矩阵转换的值的数组。 数组中的项数必须等于 matrixX * matrixY。  
        divisor:Number (default = 1.0) — 矩阵转换中使用的除数。 默认值为 1。 如果除数是所有矩阵值的总和，则可调平结果的总体色彩强度。 忽略 0 值，此时使用默认值。  
        bias:Number (default = 0.0) — 要添加到矩阵转换结果的偏差。 默认值为 0。  
        preserveAlpha:Boolean (default = true) — false 值表示未保留 Alpha 值，并且卷积适用于所有通道（包括 Alpha 通道）。 值为 true 表示只对颜色通道应用卷积。 默认值为 true。  
        clamp:Boolean (default = true) — 对于源图像之外的像素，如果值为 true，则表明通过复制输入图像给定边缘处的颜色值，沿着输入图像的每个边框按需要扩展输入图像。 如果值为 false，则表明应按照 color 和 alpha 属性中的指定使用其它颜色。 默认值为 true。  
        color:uint (default = 0) — 要替换源图像之外的像素的十六进制颜色。  
        alpha:Number (default = 0.0) — 替换颜色的 Alpha
		*/
		public static function getConvolutionFilter(matrixX:Number = 0, 
													matrixY:Number = 0, 
													matrix:Array = null, 
													divisor:Number = 1.0, 
													bias:Number = 0.0, 
													preserveAlpha:Boolean = true, 
													clamp:Boolean = true, 
													color:uint = 0, 
													alpha:Number = 0.0):BitmapFilter{
			return new ConvolutionFilter(matrixX, 
										 matrixY, 
										 matrix,
										 divisor, 
										 bias, 
										 preserveAlpha, 
										 clamp, 
										 color, 
										 alpha);
		}
		
		/*
		参数  matrix:Array (default = null) — 由 20 个项目（排列成 4 x 5 矩阵）组成的数组。

		*/
		public static function getColorMatrixFilter(matrix:Array = null):BitmapFilter{
			return new ColorMatrixFilter(matrix);
		}
		
		/*
		参数
        mapBitmap:BitmapData (default = null) — 包含置换映射数据的 BitmapData 对象。 
        mapPoint:Point (default = null) — 一个值，它包含目标显示对象的左上角相对于映射图像左上角的偏移量。  
        componentX:uint (default = 0) — 说明在映射图像中使用哪个颜色通道来置换 x 结果。 可能的值为 BitmapDataChannel 常数。  
        componentY:uint (default = 0) — 说明在映射图像中使用哪个颜色通道来置换 y 结果。 可能的值为 BitmapDataChannel 常数。  
        scaleX:Number (default = 0.0) — 用于缩放映射计算的 x 置换结果的乘数。  
        scaleY:Number (default = 0.0) — 用于缩放映射计算的 y 置换结果的乘数。  
        mode:String (default = "wrap") — 滤镜模式。 可能的值为 DisplacementMapFilterMode 常数。  
        color:uint (default = 0) — 指定对于超出范围的替换应用什么颜色。 置换的有效范围是 0.0 到 1.0。如果 mode 设置为 DisplacementMapFilterMode.COLOR，则使用此参数。  
        alpha:Number (default = 0.0) — 指定对于超出范围的替换应用什么 Alpha 值。 它被指定为 0.0 到 1.0 之间的标准值。例如，.25 设置透明度值为 25%。 如果 mode 设置为 DisplacementMapFilterMode.COLOR，则使用此参数。 
		*/
		public static function getDisplacementMapFilter(mapBitmap:BitmapData = null, 
														mapPoint:Point = null, 
														componentX:uint = 0, 
														componentY:uint = 0, 
														scaleX:Number = 0.0, 
														scaleY:Number = 0.0, 
														mode:String = "wrap", 
														color:uint = 0, 
														alpha:Number = 0.0):BitmapFilter{
			return new DisplacementMapFilter(mapBitmap,
											 mapPoint,
											 componentX,
											 componentY,
											 scaleX,
											 scaleY,
											 mode,
											 color,
											 alpha
											 );
		}
		
		/*
		参数
        distance:Number (default = 4.0) — 阴影的偏移距离，以像素为单位。  
        angle:Number (default = 45) — 阴影的角度，0 到 360 度（浮点）。  
        color:uint (default = 0) — 阴影颜色，采用十六进制格式 0xRRGGBB。 默认值为 0x000000。  
        alpha:Number (default = 1.0) — 阴影颜色的 Alpha 透明度值。 有效值为 0.0 到 1.0。 例如，.25 设置透明度值为 25%。  
        blurX:Number (default = 4.0) — 水平模糊量。 有效值为 0 到 255.0（浮点）。  
        blurY:Number (default = 4.0) — 垂直模糊量。 有效值为 0 到 255.0（浮点）。  
        strength:Number (default = 1.0) — 印记或跨页的强度。 该值越高，压印的颜色越深，而且阴影与背景之间的对比度也越强。 有效值为 0 到 255.0。  
        quality:int (default = 1) — 应用滤镜的次数。 使用 BitmapFilterQuality 常数： 
        BitmapFilterQuality.LOW
        BitmapFilterQuality.MEDIUM
        BitmapFilterQuality.HIGH
        有关这些值的详细信息，请参阅 quality 属性说明。
        inner:Boolean (default = false) — 表示阴影是否为内侧阴影。 值 true 指定内侧阴影。 值 false 指定外侧阴影（对象外缘周围的阴影）。  
        knockout:Boolean (default = false) — 应用挖空效果 (true)，这将有效地使对象的填色变为透明，并显示文档的背景颜色。  
        hideObject:Boolean (default = false) — 表示是否隐藏对象。 如果值为 true，则表示没有绘制对象本身，只有阴影是可见的。 
		*/
		public static function getDropShadowFilter(distance:Number = 4.0, 
												   angle:Number = 45, 
												   color:uint = 0, 
												   alpha:Number = 1.0, 
												   blurX:Number = 4.0, 
												   blurY:Number = 4.0, 
												   strength:Number = 1.0, 
												   quality:int = 1, 
												   inner:Boolean = false, 
												   knockout:Boolean = false, 
												   hideObject:Boolean = false):BitmapFilter{
			return new DropShadowFilter(distance,
										angle,
										color,
										alpha,
										blurX,
										blurY,
										strength,
										quality,
										inner,
										knockout,
										hideObject);										
		}
		/*
		参数  
		color:uint (default = 0xFF0000) — 光晕颜色，采用十六进制格式 0xRRGGBB。 默认值为 0xFF0000。  
        alpha:Number (default = 1.0) — 颜色的 Alpha 透明度值。 有效值为 0 到 1。 例如，.25 设置透明度值为 25%。    
        blurX:Number (default = 6.0) — 水平模糊量。 有效值为 0 到 255（浮点）。 2 的乘方值（如 2、4、8、16 和 32）经过优化，呈现速度比其它值更快。  
        blurY:Number (default = 6.0) — 垂直模糊量。 有效值为 0 到 255（浮点）。 2 的乘方值（如 2、4、8、16 和 32）经过优化，呈现速度比其它值更快。   
        strength:Number (default = 2) — 印记或跨页的强度。 该值越高，压印的颜色越深，而且发光与背景之间的对比度也越强。 有效值为 0 到 255。  
        quality:int (default = 1) — 应用滤镜的次数。 使用 BitmapFilterQuality 常数： 
        BitmapFilterQuality.LOW
        BitmapFilterQuality.MEDIUM
        BitmapFilterQuality.HIGH
        有关详细信息，请参阅 quality 属性的说明。  
        inner:Boolean (default = false) — 指定发光是否为内侧发光。 值 true 指定发光是内侧发光。 值 false 指定发光是外侧发光（对象外缘周围的发光）。  
        knockout:Boolean (default = false) — 指定对象是否具有挖空效果。 值为 true 将使对象的填充变为透明，并显示文档的背景颜色。 
		*/
		public static function getGlowFilter(color:uint = 0xFF0000, 
											 alpha:Number = 1.0, 
											 blurX:Number = 6.0, 
											 blurY:Number = 6.0, 
											 strength:Number = 2, 
											 quality:int = 1, 
											 inner:Boolean = false, 
											 knockout:Boolean = false):BitmapFilter{
			return new GlowFilter(color,
								  alpha,
								  blurX,
								  blurY,
								  strength,
								  quality,
								  inner,
								  knockout);
		}
		/*
		参数
        distance:Number (default = 4.0) — 偏移距离。 有效值为 0 到 8。 
        angle:Number (default = 45) — 角度，以度为单位。 有效值为 0 到 360。  
        colors:Array (default = null) — 渐变中使用的 RGB 十六进制颜色值数组。 例如，红色为 0xFF0000，蓝色为 0x0000FF 等等。 alphas:Array (default = null) — colors 数组中对应颜色的 Alpha 透明度值的数组。 数组中每个元素的有效值为 0 到 1。 例如，.25 设置透明度值为 25%。  
        ratios:Array (default = null) — 颜色分布比例的数组；有效值为 0 到 255。  
        blurX:Number (default = 4.0) — 水平模糊量。 有效值为 0 到 255。 如果模糊量小于或等于 1，则表明原始图像是按原样复制的。 默认值为 4。 2 的乘方值（如 2、4、8、16 和 32）经过优化，呈现速度比其它值更快。  
        blurY:Number (default = 4.0) — 垂直模糊量。 有效值为 0 到 255。 如果模糊量小于或等于 1，则表明原始图像是按原样复制的。 2 的乘方值（如 2、4、8、16 和 32）经过优化，呈现速度比其它值更快。  
        strength:Number (default = 1) — 印记或跨页的强度。 该值越高，压印的颜色越深，而且斜角与背景之间的对比度也越强。 有效值为 0 到 255。 值为 0 表示未应用滤镜。  
        quality:int (default = 1) — 滤镜的品质。 使用 BitmapFilterQuality 常数： 
        BitmapFilterQuality.LOW
        BitmapFilterQuality.MEDIUM
        BitmapFilterQuality.HIGH
        有关详细信息，请参阅 quality 属性的说明。
        type:String (default = "inner") — 斜角效果的放置。 可能的值为 BitmapFilterType 常数： 
        BitmapFilterType.OUTER -- 对象外缘上的斜角
        BitmapFilterType.INNER -- 对象内缘上的斜角
        BitmapFilterType.FULL -- 对象顶部的斜角
        knockout:Boolean (default = false) — 指定是否应用挖空效果。 值为 true 将使对象的填充变为透明，并显示文档的背景颜色
		*/
		public static function getGradientBevelFilter(distance:Number = 4.0, 
													  angle:Number = 45, 
													  colors:Array = null, 
													  alphas:Array = null, 
													  ratios:Array = null, 
													  blurX:Number = 4.0, 
													  blurY:Number = 4.0, 
													  strength:Number = 1, 
													  quality:int = 1, 
													  type:String = "inner",
													  knockout:Boolean = false):BitmapFilter{
			return new GradientBevelFilter(distance,
										   angle,
										   colors,
										   alphas,
										   ratios,
										   blurX,
										   blurY,
										   strength,
										   quality,
										   type,
										   knockout);
		}
		
		/*
		参数
        distance:Number (default = 4.0) — 光晕的偏移距离。  
        angle:Number (default = 45) — 角度，以度为单位。 有效值为 0 到 360。  
        colors:Array (default = null) — 定义渐变的颜色数组。 例如，红色为 0xFF0000，蓝色为 0x0000FF 等等。  
        alphas:Array (default = null) — colors 数组中对应颜色的 Alpha 透明度值的数组。 数组中每个元素的有效值为 0 到 1。 例如，值 .25 将 Alpha 透明度值设置为 25%。  
        ratios:Array (default = null) — 颜色分布比例的数组。 有效值为 0 到 255。 该值定义颜色采样率为 100% 之处的宽度百分比。  
        blurX:Number (default = 4.0) — 水平模糊量。 有效值为 0 到 255。 如果模糊量小于或等于 1，则表明原始图像是按原样复制的。 2 的乘方值（如 2、4、8、16 和 32）经过优化，呈现速度比其它值更快。  
        blurY:Number (default = 4.0) — 垂直模糊量。 有效值为 0 到 255。 如果模糊量小于或等于 1，则表明原始图像是按原样复制的。 2 的乘方值（如 2、4、8、16 和 32）经过优化，呈现速度比其它值更快。  
        strength:Number (default = 1) — 印记或跨页的强度。 该值越高，压印的颜色越深，而且发光与背景之间的对比度也越强。 有效值为 0 到 255。 值越大，压印越强。 值为 0 意味着未应用滤镜。  
        quality:int (default = 1) — 应用滤镜的次数。 使用 BitmapFilterQuality 常数： 
        BitmapFilterQuality.LOW
        BitmapFilterQuality.MEDIUM
        BitmapFilterQuality.HIGH
        有关详细信息，请参阅 quality 属性的说明。
        type:String (default = "inner") — 滤镜效果的放置。 可能的值是 flash.filters.BitmapFilterType 常数： 
        BitmapFilterType.OUTER -- 对象外缘上的发光
        BitmapFilterType.INNER -- 对象内缘上的发光；默认值。
        BitmapFilterType.FULL -- 对象顶部的发光
        knockout:Boolean (default = false) — 指定对象是否具有挖空效果。 应用挖空效果将使对象的填充变为透明，并显示文档的背景颜色。 值为 true 将指定应用挖空效果；默认值为 false，即不应用挖空效果。  
		*/
		public static function getGradientGlowFilter(distance:Number = 4.0, 
													 angle:Number = 45, 
													 colors:Array = null, 
													 alphas:Array = null, 
													 ratios:Array = null, 
													 blurX:Number = 4.0, 
													 blurY:Number = 4.0, 
													 strength:Number = 1, 
													 quality:int = 1, 
													 type:String = "inner", 
													 knockout:Boolean = false):BitmapFilter{
			return new GradientGlowFilter(distance,
										  angle,
										  colors,
										  alphas,
										  ratios,
										  blurX,
										  blurY,
										  strength,
										  quality,
										  type,
										  knockout);
										  
		}
	}
}