package com.laosafu.errors
{	
	/**
	 *单例模式的错误类.
	 * 
	 * @author hwq88
	 */
	public class InstanceError extends Error
	{
		/**
		 * Use this error in the constructor for your abstract class.
		 */
		public static const CONSTRUCTOR_ERROR:String = "ERROR: 只能实例化一次.";		
		
		
		public function InstanceError(message:String="", id:int=0)
		{   
			super(message, id);
		}
	}
}