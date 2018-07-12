package com.damidia
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.net.Socket;
	import flash.net.XMLSocket;
	import flash.utils.flash_proxy;
	
	public class Gestor extends EventDispatcher
	{
		public static const LOCAL_PATH:String = "C:/3MIDIA/EMPRESAS/";
		
		static public var xml:XML = null;
		
		private static var frameId:String = "";
		
		private var root:DisplayObject;
		private var source:String;
		private var parameters:Object;
		private var onParametersLoaded:Function;
		private var jsReadyHandler:Function;
		
		public function Gestor(config:Object)
		{
			this.root = config.root;
			this.source = config.source || Gestor.LOCAL_PATH;
			
			this.onParametersLoaded = config.onParametersLoaded;
			this.jsReadyHandler = config.jsReadyHandler;
		}
		
		static public function get debugger():SharedObject
		{
			return SharedObject.getLocal('gestor/tresmidia/debug',"/");
		}
		
		public function getRegistryIndex(total:uint):uint
		{
			var name:String = "gestor/tresmidia/" + this.root.loaderInfo.url.replace(/\\/g,"/").split("/").pop().split(".").shift().toLowerCase();
			
			debugger.data.name = name;
			
			trace(name);
			
			var sharedObject:SharedObject = SharedObject.getLocal(name, "/");
			
			if (!sharedObject.data.hasOwnProperty('indexCounter') || (sharedObject.data.indexCounter) >= total)
			{
				sharedObject.data.indexCounter = 0;
			}
			
			var returnValue:uint = sharedObject.data.indexCounter++;
			
			sharedObject.flush();
			
			return returnValue;
		}
		
		public function getSource():String
		{
			return source;
		}
		
		static public function stop():void
		{
			var theSocket:Socket = new Socket();
			
			theSocket.addEventListener(Event.CONNECT, function(e:Event):void
			{
				theSocket.writeUTFBytes("<rc version=\"1\" id=\"1\" action=\"stop\" frame_id=\""+frameId+"\" />\r\n\r\n");
			});
			
			theSocket.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void
			{
				trace("Broadsign offline");
			});
			
			theSocket.connect("localhost", 2324);
		}
		
		public function initialize():void
		{
			log('Adicionando escuta do loaderInfo');
			this.root.loaderInfo.addEventListener(Event.COMPLETE, loaderInfoCompleteHandler);
		}
		
		static public function log(data:*):void
		{
			if (ExternalInterface.available)
			{
				ExternalInterface.call('callLog', data);
			}
			else
			{
				trace(data);
			}
		}
		
		public function loadData(module:String, handler:Function, filter:Vector.<GestorFilter> = null):void
		{
			var loader:GestorXmlLoader = new GestorXmlLoader(source + module + ".xml");
			
			loader.load(handler, filter);
		}
		
		public function loaderInfoCompleteHandler(e:Event):void 
		{
			log('LoaderInfo carregado');
			
			this.parameters = this.root.loaderInfo.parameters;
			
			frameId = this.parameters.frame_id;
			
			if (getParameter('previewEnabled'))
			{
				Gestor.log('Modo Preview Ativado!');
				ExternalInterface.addCallback('callUpdate', jsReadyHandler);
				ExternalInterface.call('callUpdate');
			}
			else
			{
				this.onParametersLoaded();
			}
		}
		
		public function getParameters():Object
		{
			return this.parameters;
		}
		
		public function getParameter(name:String):Object 
		{
			return this.parameters[name];
		}
	}
}