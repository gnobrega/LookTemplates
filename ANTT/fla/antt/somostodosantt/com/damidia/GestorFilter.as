package com.damidia
{
	public class GestorFilter
	{
		private var name:String;
		private var value:String;
		private var useAttribute:Boolean;
		
		public function GestorFilter(name:String, value:String, isAttribute:Boolean = true)
		{
			this.name = name;
			this.value = value;
			this.useAttribute = isAttribute;
		}
		
		public function isAttribute():Boolean
		{
			return this.useAttribute;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function getValue():String
		{
			return this.value;
		}
	}
}