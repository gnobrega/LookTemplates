/*
单例模式：设置一个类只能实例化一次
InstanceError.enforceConstructor();
*/

package com.laosafu.utils
{
	
	import com.laosafu.errors.InstanceError;
	
	public class InstanceEnforcer
	{
		private static var num:uint;
		public static function enforceConstructor():void {
			num++;
			if (num >= 2) {
				throw (new InstanceError(InstanceError.CONSTRUCTOR_ERROR));
			}
		}		
	}
}