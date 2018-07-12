package com.damidia
{
	public class GestorFilter
	{
		private var name:String;
		private var value:String;
		private var useAttribute:Boolean;
		private var contains:Boolean;
		
		public function GestorFilter(name:String, value:String, isAttribute:Boolean = true, contains:Boolean = true)
		{
			this.name = name;
			this.value = value;
			this.useAttribute = isAttribute;
			this.contains = contains;
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
		
		public function useContains():Boolean
		{
			return this.contains;
		}
	}
}