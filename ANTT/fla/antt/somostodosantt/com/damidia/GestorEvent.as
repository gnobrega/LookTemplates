package com.damidia
{
	import flash.events.Event;
	
	public final class GestorEvent extends Event
	{
		public static const PARAMETERS_LOADED:String = "GestorEvent::PARAMETERS_LOADED";
		
		public function GestorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}