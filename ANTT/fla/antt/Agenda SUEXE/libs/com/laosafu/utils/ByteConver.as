package com.laosafu.utils{
	public class ByteConver{
		public function ByteConver(){
			AbstractEnforcer.enforceConstructor(this,ByteConver);
		}		
		public static function conver(num:Number){			
			if(num < 1024){				
				return num + "B";
			}
			if(num >= 1024 && num < 1024*1024){
				return num/1024 + "KB";
			}
			if(num >= 1024*1024 && num < 1024*1024*1000){
				return num/(1024*1024) + "MB";
			}
			if(num >= 1024*1024*1000){
				return NumberUtilities.round(num/(1024*1024*1024),0.01) + "GB";
			}
		}		
	}
}