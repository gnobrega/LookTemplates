/**格式化一个数字*/
package com.laosafu.utils{
	public class FormatNumber{
		private var _sMask:String;
		public function FormqtNumber(sMask:String = null){
			this._sMask = sMask;
		}
		/**
		@ 定义一个格式化遮照样式，此样式只如"0","#",",","."符号组成,如##,###.0000
		@“0”符号:占位符号，不是以相应的数字填入，就是以0填入
		@“#”符号:占位符号，不是以相应的数字填入，就是以空格填入
		@ ","符号：编组符号占位符，会被区域化的编组符号替代,group
		@ "."符号：小数点占位符，可以由区域化的小数点替代
		*/
		public function set sMask(s:String):void{
			this._sMask = s;
		}
		public function get sMask():String{
			return this._sMask;
		}
		/**
		Public方法
		
		*/
		public function format(sNumber:Number, para1:Object = null, para2:Object = null):String{
			var stringNumber:String;			
			var sDecimal:String = ".";
            var sGroup:String = ",";
			var oSymbols:Object;
			var lLocale:Locale;
			
			if(para1 is Number){
				var nRadix:Number;
			    var sPrefix:String = "";
				nRadix = (para1 as Number);
				stringNumber = sNumber.toString(nRadix);
				if(nRadix == 16) sPrefix = "0x";
				if(nRadix == 8) sPrefix = "0";
				if(para2 != null) sPrefix = para2.toString();
				return (sPrefix + stringNumber.toUpperCase());
			}		
			
			if(para1 != null && para1.hasOwnProperty("group")){
				oSymbols = para1;
			}
			else{
				lLocale = Locale(para1);
				if(lLocale == null){
					lLocale = new Locale();
				}				        
               oSymbols = getSymbols(false, lLocale);
			}
			sDecimal = oSymbols.decimal;
            sGroup = oSymbols.group;			
			var aParts:Array = (sNumber.toString()).split(".");
            var aPart0:Array = aParts[0].split("");
            var aPart1:Array = (aParts.length > 1) ? aParts[1].split("") : new Array();
			var nCounter:Number = 0;
			if(_sMask == null){
				aPart0.reverse();
				var step:uint = 2;
			    for(var i:uint = 0; i < aPart0.length; i++){				
				    if(nCounter > step){
					    nCounter = 0;
					    step = 3;
					    aPart0.splice(i,0,sGroup);
				    }				
				    nCounter ++;
			    }
			    aPart0.reverse();
			    stringNumber = aPart0.join("");
			    if(aParts[1]){
				    stringNumber += sDecimal + aParts[1];
			    }
			   // return stringNumber;
			}
			else{
				var aMask:Array = _sMask.split("");
				for(i = 0; i < aMask.length; i++){
					if(aMask[i] != "0" && aMask[i] != "#" && aMask[i] != "."){
						aMask.splice(i, 1);
						i--;
					}					
				}
				aMask = aMask.join("").split(".");
				var aMask0:Array = aMask[0].split("");
                var aMask1:Array = (aMask.length > 1) ? aMask[1].split("") : new Array();
                nCounter = aMask0.length;
				var nPart0Index:Number = 0;
                var nMaskIndex:Number = 0;
				stringNumber = "";
				if(nCounter < aPart0.length) {
                    for(i = 0; i < aPart0.length - nCounter; i++) {
                        stringNumber += aPart0[i];
                        nPart0Index++;
                    }
                }
                else if(nCounter > aPart0.length) {          
                    for(i = 0; i < nCounter - aPart0.length; i++) {
                        if(aMask0[i] == "0") {
                            stringNumber += "0";
                        }
                        else if (aMask0[i] == "#") {
                            stringNumber += " ";
                        }
                        nMaskIndex++;
                    }
                }
				var bNumeric:Boolean = false;        
                for(i = nMaskIndex; i < aMask0.length; i++) {          
                    if(aMask0[i] == "0" || aMask0[i] == "#") {
                        stringNumber += (aPart0[nPart0Index] == undefined) ? "" : aPart0[nPart0Index];
                        nPart0Index++;
                    }
                }        
                aMask = _sMask.split(".");
                aMask = aMask[0].split("");        
                var aNumber:Array = stringNumber.split("");
        
                for(i = 0; i < aMask.length; i++) {         
                    if(aMask[i] != "0" && aMask[i] != "#" && aMask[i] != ".") {            
                        if(bNumeric) {
                            aNumber.splice(i, 0, sGroup);
                        }
                        else {
                            aNumber.splice(i, 0, " ");
                        }
                    }         
                    if(aNumber[i] != " " && aNumber[i] != "0") {
                        bNumeric = true;
                    }
                }      
                stringNumber = aNumber.join("");        
                if(aMask1.length > 0) {
                    stringNumber += sDecimal;
                }
                var nDigits:Number;        
                for(i = 0; i < aMask1.length; i++) {         
                    if(aPart1[i] == null) {           
                        if(aMask1[i] == "0") {
                            stringNumber += "0";
                        }
                        else if(aMask1[i] == "#") {
                            stringNumber += " ";
                        }
                    }
                    else {           
                        nDigits = Number(aPart1[i] + "" + aPart1[i + 1]);
                        if(i == aMask1.length - 1 && !isNaN(nDigits)) {
                             stringNumber += String(Math.round(nDigits/10));
                        }
                        else {
                             stringNumber += aPart1[i];
                        }
                    }
                }
            }      
            return stringNumber;
		}
		
		public function currencyFormat(nAmount:Number, oParameter1:Object = null):String {     
            var lStyle:Locale = (arguments[1] is Locale) ? arguments[1] : new Locale(); 
			var oSymbols:Object;
            if(oParameter1 != null && oParameter1.hasOwnProperty("group")) {
                oSymbols = oParameter1;
            }
            else {
               oSymbols = getSymbols(true, lStyle);
            }
            var sCurrencySymbol:String = oSymbols.currency;
            var sGroup:String = oSymbols.group;
            var sDecimal:String = oSymbols.decimal;
            var sTempMask:String = _sMask;
            _sMask = null;      
            var lLocale:Locale = new Locale();
            lLocale.language = "zh";
            lLocale.variant = "CN";
            var sAmount:String = format(nAmount, lLocale);  
            _sMask = sTempMask;
           var aParts:Array = sAmount.split(".");     
           if(aParts[1] == undefined) {
               aParts[1] = "00";
           }
           else {
               aParts[1] = Number(aParts[1]);
               var nPart1Length:Number = String(aParts[1]).length;
               if(nPart1Length > 2) {
                   aParts[1] /= Math.pow(10, (nPart1Length - 2));
                   aParts[1] = Math.round(aParts[1]);
               }
           }      
           sAmount = aParts.join(".");
           var aAmount:Array = sAmount.split("");      
           for(var i:Number = 0; i < aAmount.length; i++) {
              if(aAmount[i] == ",") {
                  aAmount[i] = sGroup;
              }
              else if(aAmount[i] == ".") {
                  aAmount[i] = sDecimal;
              }
           }     
           var sReturnString:String = ((oSymbols.before) ? sCurrencySymbol : "") + aAmount.join("") + ((!oSymbols.before) ? sCurrencySymbol : "");
           return sReturnString;
       }
		
	    //这个方法是用于grouping, decimal, and currency symbols    
	    private function getSymbols(bCurrency:Boolean, lStyle:Locale):Object {
            var oSymbols:Object = new Object();
            switch(lStyle.languageVariant) {
            case "en-US":
               oSymbols.currency = "$";
               oSymbols.group = ",";
               oSymbols.decimal = ".";
               oSymbols.before = true;
            break;
            case "en-UK":
               oSymbols.currency = "\u00A3";
               oSymbols.group = ",";
               oSymbols.decimal = ".";
               oSymbols.before = true;
            break;
            case "es-MX":
               oSymbols.currency = "$";
               oSymbols.group = ",";
               oSymbols.decimal = ".";
               oSymbols.before = true;
            break;
            case "es-ES":
               oSymbols.currency = "\u20AC";
               oSymbols.group = ".";
               oSymbols.decimal = ",";
               oSymbols.before = false;
            break;
            case "fr":
               oSymbols.currency = "\u20AC";
               oSymbols.group = ".";
               oSymbols.decimal = ",";
               oSymbols.before = false;
            break;
            case "sv":
               oSymbols.currency = "kr";
               oSymbols.group = bCurrency ? "," : " ";
               oSymbols.decimal = ".";
               oSymbols.before = false;
            break;
            case "jp":
               oSymbols.currency = "\u200A5";
               oSymbols.group = ",";
               oSymbols.decimal = ".";
               oSymbols.before = true;
            break;
            case "nl":
               oSymbols.currency = "€";
               oSymbols.group = ".";
               oSymbols.decimal = ",";
               oSymbols.before = true;
            break;
		    case "zh-CN":
		       oSymbols.currency = "￥";
               oSymbols.group = ",";
               oSymbols.decimal = ".";
               oSymbols.before = true;
		    break;
            default:
               oSymbols.currency = "￥";
               oSymbols.group = ",";
               oSymbols.decimal = ".";
               oSymbols.before = true;
            break;
         }
         return oSymbols;
       }
	}
}