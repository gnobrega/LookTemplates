package com.damidia
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class ImageLoader
	{
		
		public function ImageLoader()
		{
			
		}
		
		static public function get(url:String, success:Function=null, error:Function=null):Loader
		{
			var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void{
					Gestor.log("Imagem carregada: "+ url);
					Bitmap(loader.content).smoothing = true;
				});
				
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void{
					Gestor.log("Ocorreu um erro ao carregar o arquivo: " + url);
					if (error != null) error(e);
				});
				
			loader.load(new URLRequest(url));
			
			return loader;
		}
	}
}