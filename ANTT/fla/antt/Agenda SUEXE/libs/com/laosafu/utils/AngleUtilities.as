/*
功能：角度和狐度相互转换
*/

package com.laosafu.utils{
	public class AngleUtilities{
		public function AngleUtilities(){
			AbstractEnforcer.enforceConstructor(this,AngleUtilities);
		}
		
		public static function angleToRadian(angle:Number):Number{
			return (angle * Math.PI)/180;
		}
		
		public static function radianToAngle(radian:Number):Number{
			return (radian * 180)/Math.PI;
		}
	}
		
		
	
}