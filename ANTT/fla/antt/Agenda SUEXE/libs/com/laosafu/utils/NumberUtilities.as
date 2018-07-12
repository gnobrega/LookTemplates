/*
功能：

1.把数字取到最近小数点位数NumberUtilities(123.345,0.01);
2.把数字取成整数最接近的倍数NumberUtilities(123.345,6);
*/

package com.laosafu.utils{	
	public class NumberUtilities{
		
		private static var _aUniqueIds:Array;
		
		public function NumberUtilities(){
			AbstractEnforcer.enforceConstructor(this,NumberUtilities);
		}
		
		public static function round(number:Number, nRoundToInterval:Number = 1):Number{
			return Math.round(number/nRoundToInterval) * nRoundToInterval;
		}
		
		public static function floor(nNumber:Number, nRoundToInterval:Number = 1):Number {      
           return Math.floor(nNumber / nRoundToInterval) * nRoundToInterval;
        }
		
		public static function ceil(nNumber:Number, nRoundToInterval:Number = 1):Number {      
           return Math.ceil(nNumber / nRoundToInterval) * nRoundToInterval;
        }
		//随机数
		public static function random(nMinimum:Number, nMaximum:Number = 0, nRoundToInterval:Number = 1):Number {      
           if(nMinimum > nMaximum) {
               var nTemp:Number = nMinimum;
               nMinimum = nMaximum;
               nMaximum = nTemp;
           }        
           var nDeltaRange:Number = (nMaximum - nMinimum) + (1 * nRoundToInterval); 		  
           var nRandomNumber:Number = Math.random() * nDeltaRange;        
           nRandomNumber += nMinimum;       
           return floor(nRandomNumber, nRoundToInterval);
      }
	  //获得一个唯一数
	  public static function getUnique():Number{
		  if( _aUniqueIds == null){
			  _aUniqueIds = new Array();
		  }
		  var dCurrent:Date = new Date();
		  var nID:Number = dCurrent.getTime();
		  while(!isUnique(nID)){
			  nID += NumberUtilities.random(dCurrent.getTime(),2 * dCurrent.getTime());
		  }
		  _aUniqueIds.push(nID);
		  return nID;
	  }
	  
	  private static function isUnique(number:Number):Boolean{
		  for(var i:uint = 0; i < _aUniqueIds.length; i++){
			  if(_aUniqueIds[i] == number){
				  return false;
			  }
		  }
		  return true;
	  }
	}
}