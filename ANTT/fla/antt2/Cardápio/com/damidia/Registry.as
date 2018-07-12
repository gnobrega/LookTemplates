package com.damidia
{
	public class Registry
	{
		static private var data:Object = {};
		
		public function Registry()
		{
			throw new Error("This class cannot be initialized");
		}
		
		static public function set(name:String, value:*):void
		{
			data[name] = value;
		}
		
		static public function get(name:String):*
		{
			return data[name];
		}
	}
}