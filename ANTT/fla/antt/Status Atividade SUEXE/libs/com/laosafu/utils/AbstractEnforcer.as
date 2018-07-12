/*
抽象类概念

功能：把一个类设为抽象类AbstractEnforcer.enforceConstructor(this,class);
      把一个方法设为抽象方法AbstractEnforcer.enforceMethod();
*/
package com.laosafu.utils
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import com.laosafu.errors.AbstractError;
	
	public class AbstractEnforcer
	{
		public static function enforceConstructor(instance:Object, className:Class):void {
			if (strict(instance, className)) {
				throw (new AbstractError(AbstractError.CONSTRUCTOR_ERROR));
			}
		}
		
		public static function enforceMethod ():void {
			throw (new AbstractError(AbstractError.METHOD_ERROR));
		}
		
		private static function strict(instance:Object, compareClass:Class):Boolean {
		    var instanceClass:Class = Class(getDefinitionByName(getQualifiedClassName(instance)));		    
		    return instanceClass == compareClass;
	    }
	}
}