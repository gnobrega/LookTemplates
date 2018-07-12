package com.laosafu.chart.data{	
	/*
	//=========属性=================================
	@ data         原始数据
	@ count        数量，做图表有多少个元素组成，例如:一个圆上有多少块，只读	
	@ total        元数据的总和,只读
	@ content      数据内容
	//=========方法=================================
	
	*/
	
	public class ChartData{
		
		//原始数据
		private var _data:Array;
		//数据内容
		private var _content:Array;
				
		//做图表数量
		public function get count():uint{
			return _data.length;			
		}
		
		//元数组数据总和		
		public function get total():Number{			
			return getTotal();
		}
		
		private function getTotal():Number{
			var _total:Number = 0;
			if(_data){				
				for(var i:uint = 0; i < _data.length; i++){
					_total += _data[i];
				}				
			}
			return _total;
		}		
		
		//构造函数
		public function ChartData(data:Array = null){			
			this._data = data;
			if(!_data){
			    this._data = [];				
			}
		}		
		
		//把原始数据转成%表示
		public function toData():Array{
			var tmpArray:Array = new Array();			
			var tmpTotal:Number = total;
			var totalNum:Number = 0;			
			if((_data) && (tmpTotal > 0)){				
				for(var i:uint = 0; i < count; i++){					
					tmpArray.push((_data[i]/tmpTotal) * 100);					
				}				
			}			
			return tmpArray;		
		}
		/*
		原数据属性
		*/
		public function set data(arr:Array):void{
			_data = arr;
		}
		public function get data():Array{
			return _data;
		}
		
		//元始数据转换成内容
		public function set content(arr:Array):void{
			_content = arr;
		}
		public function get content():Array{
			return _content;
		}
		
		//追加数据
		public function append(...num):void{
			var n:uint = num.length;
			for(var i:uint = 0; i < n; i++){
				if(num[i] is Number){
					this._data.push(num[i]);
				}			
			}
			
		}
		//最前面追加数据
		public function unshift(num:Number):void{
			this._data.unshift(num);
		}
		//在某一索引处追加数据
		public function insert(index:uint,num:Number):void{
			this._data.splice(index, 0, num);
		}
		//删除最后一个数据
		public function pop():void{
			this._data.pop();
		}
		//删除最前一个数据
		public function shift():void{
			this._data.shift();
		}
		//删除某一索引的数据
		public function delIndex(index:uint):void{
			this._data.splice(index, 1);
		}
		//降序
		public function desc():void{
			this._data.sort(Array.DESCENDING);
		}
		//升序
		public function asc():void{
			this._data.sort();
		}
		
		//最大值
		public function get max():Number{
			var tmp:Array = this._data.concat();
			tmp.sort(Array.NUMERIC);
			return tmp[tmp.length - 1];			
		}
		
		//最小值
		public function get min():Number{
			var tmp:Array = this._data.concat();
			tmp.sort(Array.NUMERIC);
			return tmp[0];			
		}
	}
}