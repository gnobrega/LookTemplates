package com.damidia
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLNode;

	public class GestorXmlLoader
	{
		private var url:String;
		private var handler:Function;
		private var filter:Vector.<GestorFilter>;
		
		public function GestorXmlLoader(url:String)
		{
			this.url = url;	
		}
		
		public function load(handler:Function, filter:Vector.<GestorFilter> = null):void
		{
			this.filter = filter;
			
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener(Event.COMPLETE, fileLoadedHandler);
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void{
				trace(e);
			});
			
			loader.load(new URLRequest(this.url));
			
			this.handler = handler;
		}
		
		public function fileLoadedHandler(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			var xml:XML = new XML(loader.data);
			Gestor.xml = xml;
			var list:XMLList = xml.module.item;
			
			if (filter)
			{
				for(var i:uint = 0, l:uint = filter.length; i < l; i++)
				{
					if (filter[i].isAttribute())
					{
						list = list.(attribute(filter[i].getName()) == filter[i].getValue())
					}
					else
					{
						list = list.(child(filter[i].getName()).toString() == filter[i].getValue())
					}
				}
			}
			
			if (list.length() <= 0)
			{
				Gestor.stop();
			}
			else
			{
				var items:Vector.<XML> = new Vector.<XML>();
				var dt:Date = new Date();
				
				for(var c:uint = 0, k:uint = list.length(); c < k; c++)
				{
					if (list[c].schedule_start && list[c].schedule_start.toString() != "")
					{
						var itemDate:Date = new Date();
						var strDtStart:String = list[c].schedule_start.toString();
						var strDtEnd:String = list[c].schedule_end.toString();
						
						var spltStart1:Array = strDtStart.split(" ");
						var spltStartData:Array = spltStart1[0].split("-");
						var spltStartHora:Array = spltStart1[1].split(":");
						
						itemDate.fullYear = spltStartData[0];
						itemDate.month = Number(spltStartData[1]) - 1;
						itemDate.date = spltStartData[2];
						
						itemDate.hours = spltStartHora[0];
						itemDate.minutes = spltStartHora[1];
						itemDate.seconds = 0;
						
						if (dt.time - itemDate.time < 0)
						{
							continue;
						}
						
						var spltEnd1:Array = strDtEnd.split(" ");
						var strDtEndData:Array = spltEnd1[0].split("-");
						var strDtEndHora:Array = spltEnd1[1].split(":");
						
						var itemDateEnd:Date = new Date();
						
						itemDateEnd.fullYear = parseInt(strDtEndData[0]);
						itemDateEnd.month = parseInt(strDtEndData[1])-1;
						itemDateEnd.date = parseInt(strDtEndData[2]);
						
						itemDateEnd.hours = parseInt(strDtEndHora[0]);
						itemDateEnd.minutes = parseInt(strDtEndHora[1]);
						itemDateEnd.seconds = 0;
												
						if (dt.time - itemDateEnd.time >= 0)
						{
							continue;
						}						
					}
					
					items.push(list[c]);
				}
				
				if (items.length <= 0)
				{
					Gestor.stop();
				}
				else
				{
					this.handler(items);	
				}
			}
		}
	}
}