package com.laosafu.chart{
	import com.laosafu.graphics.brush.*;
	import com.laosafu.graphics.pen.*;
	import com.laosafu.graphics.draw2d.*;
	import com.laosafu.chart.data.ArcChart;
	import com.laosafu.chart.data.ChartData;
	import com.laosafu.ASFilter;
	import org.aswing.ASColor;
	import com.laosafu.utils.FormatNumber;
		
	import flash.geom.Matrix;	
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Shape;	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/*
	pie图
	*/
	public class CircleChart extends Chart{
		//扇形对象
		private var arcChart:ArcChart;
		//坐标位置
		public var centerX:Number;
		public var centerY:Number;
		//半径,如果数组长度为1,表示实心,2表示空心
		public var radius:Array;
		//起初角度
		public var startAngle:Number;
		
		//存放每一颜色块pie的显示对象数组
		public var sprites:Array;
		//每一颜色块所占的%数组
		private var dataArray:Array;		
		//每块元素的中心出现小圆
		private var circleArray:Array;
		//每一块出现的文本
		private var textArray:Array;
		//每一块的夹角数组
		private var angleArray:Array;
		//ArcChart对象
		private var ArcChartArray:Array;
		//绘图对象
		private var drawArray:Array;		
		//保存颜色的数组
		private var fillType:Array = new Array();
		//当前颜色变换对象
		private var currentIndexColorTransform:ColorTransform;
		
		//显示
		public var bevelMode:Boolean = true;
		public var container:Sprite;
		private var masker:Sprite;		
		
		public function CircleChart(px:Number = 0, py:Number = 0, radius:Array = null, startAngle:Number = 0, chartData:ChartData = null){
			super(chartData);
			this.centerX = px;
			this.centerY = py;
			this.radius = radius;
			this.startAngle = startAngle;			
		}
		
		//初始化原始数据
		private function initialize():void{
			//夹角度数组
			angleArray = new Array();
			//占的%比例数组
			dataArray = new Array();			
			//每一块pie弧中点出现的小圆
			circleArray = new Array();
			//每一块文本
			textArray = new Array();
			//弧图表数姐(对象)
			ArcChartArray = new Array();
			//绘图数组(对象)
			drawArray = new Array();
			//精灵数组
			sprites = new Array();
			//存放片的容器
			container = new Sprite();	
			//斜角效果容器
			masker = new Sprite();
		}		
		
		//初始化数据
		public function init():void{
			make();
			for(var i:uint = 0; i < chartData.count; i++){
				var sprite:Sprite = new Sprite();
				var shape:Shape = new Shape();				
			    container.addChild(sprite);				
			    sprites.push(sprite);				
				circleArray.push(shape);
				
			}
			for(i = 0; i < chartData.count; i++){				
				var textStr:TextField = new TextField();				
			    container.addChild(textStr);
				textArray.push(textStr);				
			}
			//insertChartText();
		}
		
		//在舞台上绘制
		public function draw():void{			
			addChild(container);			
			if(bevelMode){
				for(var i:uint; i < sprites.length; i++){
					sprites[i].blendMode = BlendMode.MULTIPLY;
				}					
				container.addChild(masker);
				container.setChildIndex(container.getChildAt((container.numChildren) - 1),0);
				bevel();
			}			
		}
		
		//填充颜色
		public function fillColor(color:*, index:uint):void{			
			if(color is ASColor) setColor(color,index);
			if(color is Array) setGradient(color,index);
		}
		
		//在指定位置上插入一块元素
		public function insert(number:Number, color:*, index:uint = 0):void{
			//插入之前删除所有侦听器
			for(var i:uint = 0; i < sprites.length; i++){
				removeMouseAct(sprites[i]);
				removeMouseAct(textArray[i]);
			}
			//插入数据
			chartData.insert(index,number);
			//插入数据后，保存颜色的数组发生变化，修正所有颜色索引位置
			for(i = 0; i < fillType.length; i++){				
			    if(fillType[i].index > index - 1){
					fillType[i].index += 1;					
				}				
			}
			//初始化数据
			init();			
			fillColor(color, index); 			
			for(i = 0; i < chartData.count; i++){
				if(fillType[i]){
					fillColor(fillType[i].color, fillType[i].index);
				}				
			}
		}
		
		//指定位置删除一块元素
		public function del(index:uint):void{
			//删除侦听器
			for(var i:uint = 0; i < sprites.length; i++){
				removeMouseAct(sprites[i]);
				removeMouseAct(textArray[i]);
			}
			chartData.delIndex(index);
			fillType.splice(index,1);
			for(i = 0; i < fillType.length; i++){				
			    if(fillType[i].index > index - 1){
					fillType[i].index -= 1;					
				}				
			}
			init();
			for(i = 0; i < chartData.count; i++){
				if(fillType[i]){
					fillColor(fillType[i].color, fillType[i].index);
				}				
			}
		}
		
		public function setChartText(index:uint, str:String, sColor:uint = 0xFFFFFF, x:Number = 0, y:Number = 0):void{
			textArray[index].textColor = sColor;
			textArray[index].text = str;
			textArray[index].x += x;
			textArray[index].y += y;
		}	
		
		//设置格式化数字格式
		public function setTextFormat(sNumber:Number, 
									   sMask:String = "%", 
									   numberFormat:Number = 100, 
									   prefix:String = null, 
									   postfix:String = null,
									   format:Boolean = true):String{
			
			var formatNumber:FormatNumber = new FormatNumber();			
			sNumber = (int(sNumber * numberFormat)) / numberFormat;
			var numberString:String = sNumber.toString();			
			switch(sMask){
				case "%":
				numberString += "%";
				break;				
				case "data":
				if(format) numberString = formatNumber.format(sNumber);				
				if(prefix != null) numberString = prefix + numberString;
				if(postfix != null) numberString += postfix;				
				break;
			}
			return numberString;
		}
		//默认显示
		private function insertChartText():void{
			var initR:Number;
			if(isHollow()){
				initR = radius[0] + (radius[1] - radius[0])/2
			}
			else{
				initR = radius[0] * 3 / 5;
			}
			var arr:Array = getPoints(initR);			
			for(var i:uint = 0; i < chartData.count; i++){
				textArray[i].text = setTextFormat(dataArray[i]);
				textArray[i].autoSize = "left";
				textArray[i].textColor = 0xFFFFFF;
				textArray[i].filters = [ASFilter.getDropShadowFilter(2, 45, 0, 1, 4, 4 ,2)];				
				textArray[i].x = arr[i].x - textArray[i].textWidth/2;
				textArray[i].y = arr[i].y - textArray[i].textHeight/2;
				addMouseTxt(textArray[i]);
			}			
		}
		
		
		/*鼠标指向pie时侦听*/		
		private function addMouseAct(target:Sprite):void{			
			/*target.mouseChildren = false;
			target.addEventListener(MouseEvent.MOUSE_OVER, overHander);
			target.addEventListener(MouseEvent.MOUSE_OUT, outHander);			*/
		}
		
		/*鼠标指向文本时侦听*/		
		private function addMouseTxt(target:TextField):void{			
			/*target.addEventListener(MouseEvent.MOUSE_OVER, overHander);
			target.addEventListener(MouseEvent.MOUSE_OUT, outHander);			*/
		}
		
		private function overHander(e:MouseEvent):void{
			var index:uint;
			if((e.target) is Sprite) index = searchIndex(sprites, e.target);
			if((e.target) is TextField) index = searchIndex(textArray, e.target);						
		    yesAction(index);
		}
		
		private function outHander(e:MouseEvent):void{
			var index:uint;
			if((e.target) is Sprite) index = searchIndex(sprites, e.target);
			if((e.target) is TextField) index = searchIndex(textArray, e.target);
			noAction(index);
		}
		
		private function yesAction(index:uint):void{
			container.addChild(circleArray[index]);
			drawLitterCircle(index);
			light(sprites[index]);
			sprites[index].filters = getBevelFilter();			
		}
		
		private function noAction(index:uint):void{
			container.removeChild(circleArray[index]);			
			sprites[index].transform.colorTransform = currentIndexColorTransform;
			sprites[index].filters = null;			
		}
		
		/*删除侦听*/
		private function removeMouseAct(target:*):void{			
			if(target.hasEventListener(MouseEvent.MOUSE_OVER)){
				target.removeEventListener(MouseEvent.MOUSE_OVER, overHander);
			}
			if(target.hasEventListener(MouseEvent.MOUSE_OUT)){
				target.removeEventListener(MouseEvent.MOUSE_OUT, outHander);
			}
		}				
		
		//绘制小圆
		private function drawLitterCircle(index:uint):void{	
		    //求出最大半径处的坐标数组
		    var pointArray:Array;
			//当是空心圆时
			if(isHollow()){
				pointArray = getPoints(radius[1]);
			}
			//当是实心圆时
			else{
				pointArray = getPoints(radius[0]);
			}
			var brush:IBrush;
			var lineSytle:SolidPen;
			var colorArray:Array = new Array();
			var alphas:Array = new Array();
			var ratios:Array = new Array();
			var startRatio:Number = 0;
			var color:* = getIndexColor(index);	
			lineSytle = new SolidPen(2,0xFFFFFF); 
			var circle:Circle = new Circle(pointArray[index].x, pointArray[index].y,5);			
			graph.target = circleArray[index].graphics;
			if(color is ASColor){
				brush = new SolidBrush(color.getRGB(), color.getAlpha());
			}
			if(color is Array){
				for(var i:uint = 0; i < color.length; i++){
				   colorArray.push(color[i].getRGB());
			    }
				for(i = 0; i < colorArray.length; i++){
				   alphas.push(1);
				   ratios.push(startRatio + ((255 - startRatio)/(colorArray.length - 1)) * i);				   
			    }
				
				brush = new GradientBrush(GradientBrush.RADIAL,colorArray,alphas,ratios);
			}			
			graph.draw(circle,lineSytle,brush);
		}
		
		//根据半径长度，获取每一块中点坐标数组
		private function getPoints(r:Number):Array{
			var tmpArray:Array = new Array();
			var tmpAngle:Number;
			var n:uint = angleArray.length;
			for(var i:uint = 0; i < n; i++){				
				tmpAngle =  angleArray[i][0]/2 + angleArray[i][1];
				var point:Point = getPoint(tmpAngle, r);
				tmpArray.push(point);				
			}
			return tmpArray;
		}
		
	    //极坐标转换		
		private function getPoint(angle:Number, r:Number):Point{
			angle = angle * Math.PI/180;
			var point:Point = Point.polar(r, angle);
			point = new Point(point.x + centerX, point.y + centerY);
			return point;
		}
		
		
		//获取索引的颜色值		
		private function getIndexColor(index:uint):*{
			for(var i:uint; i < fillType.length; i++){
				if(fillType[i].index == index){
					return fillType[i].color;
					break;
				}
			}
		}
		
		//查找数组中某一元素的索引位置
		private function searchIndex(arr:Array, obj:*):int{
			var index = -1;
			for(var i:uint = 0; i < arr.length; i++){
				if(obj === arr[i]){
					index = i;
					break;
				}
			}
			return index;
		}
		
		/*每一个索引位置颜色值保存*/
		private function setColorArray(color:*, index:uint):void{
			var obj:Object = new Object();
			if(fillType.length == 0){				
				obj.index = index;
				obj.color = color;
				fillType.push(obj);					
				return;
			}
			for(var i:uint = 0; i < fillType.length; i++){
			    if(fillType[i].index == index){
					fillType[i].color = color;
					return;
				}				
			}
			obj.index = index;
			obj.color = color;
			fillType.push(obj);	
			fillType.sort(compare);
		}
		//根据对象index属性进行排序
		private function compare(paraA:Object, paraB:Object):int{
			if(paraA.index > paraB.index) return 1;
			if(paraA.index < paraB.index) return -1;
			return 0;
		}
		
		/*斜角滤镜*/
		private function getBevelFilter():Array{			
			return [ASFilter.getBevelFilter(8,45,0xFFFFFF,0.5,0x000000,0.5,8,8,1,3)]
		}
		
		//加亮
		private function light(target:DisplayObject):void{
			//保存当前的colorTransform值
			currentIndexColorTransform = target.transform.colorTransform;
			var rOffset:Number = target.transform.colorTransform.redOffset + 35;
            var bOffset:Number = target.transform.colorTransform.blueOffset + 35;
            var gOffset:Number = target.transform.colorTransform.greenOffset + 35;
			var colorTransform:ColorTransform = new ColorTransform(1,1,1,1,rOffset,gOffset,bOffset);
			target.transform.colorTransform = colorTransform;
		}		
		
		/*
		填充实体颜色
		*/
		private function setColor(color:ASColor, index:uint = 0, listener:Boolean = true, record:Boolean = true):void{			
			var solidBrush:SolidBrush = new SolidBrush(color.getRGB(),color.getAlpha());
			sprites[index].graphics.clear();			
			graph.target = sprites[index].graphics;
			graph.draw(drawArray[index],solidBrush);
			if(listener){
				addMouseAct(sprites[index]);
			}			
			if(record){
				setColorArray(color,index);
			}						
		}		
		
		/*
		填充渐变颜色
		*/
		private function setGradient(colors:Array, index:uint = 0, listener:Boolean = true, record:Boolean = true):void{
			var r:Number = getRadius();
			var n:uint = colors.length;
			var colorArray:Array = new Array();
			var alphas:Array = new Array();
			var ratios:Array = new Array();			
			var startRatio:Number = 0; 
			var matrix:Matrix = getMatrix(r * 2, r * 2, 0, -r, -r);
			for(var i:uint = 0; i < n; i++){
				colorArray.push(colors[i].getRGB());
			}
			if(isHollow()){
				startRatio = Math.round(255 * (radius[0]/radius[1]));				
			}else{
				startRatio = 0;				
			}
			for(i  =0; i < n; i++){
				alphas.push(1);
				ratios.push(startRatio + ((255 - startRatio)/(n - 1)) * i);				
			}			
			var gradientBrush:GradientBrush = new GradientBrush(GradientBrush.RADIAL,colorArray,alphas,ratios,matrix);
			sprites[index].graphics.clear();
			graph.target = sprites[index].graphics;				
			graph.draw(drawArray[index],gradientBrush);	
			if(listener){
				addMouseAct(sprites[index]);
			}			
			if(record){
				setColorArray(colors,index);
			}			
		}
		
		/*
		绘制立体效果			
		*/		
		private function bevel():void{
			var r:Number = getRadius();
			var matrix:Matrix = getMatrix(r * 2, r * 2, 0, -r, -r);
			var colors:Array;
			var alphas:Array;
			var ratios:Array;
			var startRatio:Number;
			var gradientBrush:GradientBrush;
			var drawShape:*;			
			if(isHollow()){
				startRatio = Math.round(255 * (radius[0]/radius[1]));					
				colors = [0xFFFFFF,0x999999,0xFFFFFF,0xFFFFFF,0xBBBBBB];				
				ratios = [0,startRatio,startRatio + 25,235,255];
				alphas = [1,1,1,1,1];				
				gradientBrush = new GradientBrush(GradientBrush.RADIAL,colors,alphas,ratios,matrix);
				drawShape = new Ring(centerX, centerY, radius[0], radius[1], 360);
			}else{				
				colors = [0xFFFFFF,0xFFFFFF,0xBBBBBB];				
				ratios = [0,235,255];
				alphas = [1,1,1];				
				gradientBrush = new GradientBrush(GradientBrush.RADIAL,colors,alphas,ratios,matrix);
				drawShape = new Arc(centerX, centerY, radius[0], 360);
			}			
			graph.target = masker.graphics;
			graph.draw(drawShape,gradientBrush);			
		}
		
		//获取最大半径
		private function getRadius():Number{
			var r:Number;
			if(radius.length == 2){
				r = radius[1];
			}else if(radius.length == 1){
				r = radius[0];
			}
			return r;
		}
		
		//判断是空心还是实心
		private function isHollow():Boolean{
			var b:Boolean;
			if(radius.length == 2){
				b = true;
			}else if(radius.length == 1){
				b = false;
			}
			return b;
		}
		
		//获取matrix对象
		private function getMatrix(w:Number, h:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0):Matrix{
			var matrix:Matrix = new Matrix();
			rotation = rotation * Math.PI/180;
			matrix.createGradientBox(w, h, rotation, tx, ty);
			return matrix;
		}		
		
		//注销所有数据
		public function destroy():void{
			sprites = null;
			drawArray = null;
			ArcChartArray = null;
			angleArray = null;			
		}		
		
		
		//下面三个方法把原始数据转换成百分比和角度
		private function make():void{
			toArray();
			create();
			for(var i:uint; i < ArcChartArray.length; i++){
				if(ArcChartArray[i].outLine == ArcChart.ARC){
					drawArray.push(new Arc(ArcChartArray[i].x, ArcChartArray[i].y, ArcChartArray[i].radius[0], ArcChartArray[i].angle, ArcChartArray[i].rotation,true));
				}else if(ArcChartArray[i].outLine == ArcChart.RING){
					drawArray.push(new Ring(ArcChartArray[i].x, ArcChartArray[i].y, ArcChartArray[i].radius[0], ArcChartArray[i].radius[1], ArcChartArray[i].angle, ArcChartArray[i].rotation));
				}
			}			
		}		
		
		private function create():void{			
			for(var i:uint = 0; i < chartData.count; i++){				
				ArcChartArray.push(new ArcChart(centerX, centerY,radius, angleArray[i][0], angleArray[i][1]));
			}			
		}		
		
		private function toArray():Array{
			initialize();
			var tmpArray:Array = chartData.toData();
			dataArray = tmpArray;
			var angleRotation:Array;
			var rotation:Number = 0;
			var num:uint = tmpArray.length;
			for(var i:uint = 0; i < num; i++){
				if(i == 0){
					angleRotation = [(tmpArray[i]/100) * 360, this.startAngle];
				}
				else{
				    rotation += (tmpArray[i-1]/100) * 360; 				
				    angleRotation = [(tmpArray[i]/100) * 360, rotation + this.startAngle];
				}				
				angleArray.push(angleRotation);
			}			
			return angleArray;
		}				
	}
}

