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
		static public var noItensEvent = null;
		private static var frameId:String = "";
		private var root:DisplayObject;
		private var source:String;
		private var parameters:Object;
		private var onParametersLoaded:Function;
		private var jsReadyHandler:Function;
		private var nameSession = "";
		private var MODULE_NAME = "";
		
		public function Gestor(config:Object)
		{
			this.root = config.root;
			this.source = config.source || Gestor.LOCAL_PATH;
			this.onParametersLoaded = config.onParametersLoaded;
			this.jsReadyHandler = config.jsReadyHandler;
			if( config.nameSession ) {
				this.nameSession = config.nameSession;
			}
			if( config.noItensEvent ) {
				Gestor.noItensEvent = config.noItensEvent;
			}
		}
		
		public function setNameSession(nameSession:String) {
			this.nameSession = nameSession;
		}
		
		static public function get debugger():SharedObject
		{
			return SharedObject.getLocal('gestor/tresmidia/debug',"/");
		}
		
		//Verifica se a máquina possui permissão de escrita
		public function allowSharedObject() {
			var sharedObject:SharedObject = SharedObject.getLocal("allowSharedObject", "/");
			sharedObject.data.allow = true;
			sharedObject = SharedObject.getLocal("allowSharedObject", "/");

			if( sharedObject.data.allow == undefined ) {
				return false;
			} else {
				return true;
			}
		}
		
		//Retorna um indice aleatorio caso a máquina nao permita escrita
		public function getIndexRandon(max:uint) {
			return (Math.floor(Math.random() * max));
		}
		
		//Armaza o indice da materia exibida e retorna o seguinte
		public function getRegistryIndex(total:uint):uint
		{
			if( allowSharedObject() ) {
				var name:String = "PLUX_INDEX_" + MODULE_NAME.toUpperCase();
				debugger.data.name = name;
				if( this.nameSession != "" ) {
					name = this.nameSession;
				}

				var sharedObject:SharedObject = SharedObject.getLocal(name, "/");
				
				if (!sharedObject.data.hasOwnProperty('indexCounter') || (sharedObject.data.indexCounter) >= total)
				{
					sharedObject.data.indexCounter = 0;
				}
				
				var returnValue:uint = sharedObject.data.indexCounter++;
				
				sharedObject.flush();
				
				return returnValue;
			} else {
				return getIndexRandon(total);
			}
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
			MODULE_NAME = module;
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
		
		public function setSource(value:String):void
		{
			source = value;
		}
	}
}