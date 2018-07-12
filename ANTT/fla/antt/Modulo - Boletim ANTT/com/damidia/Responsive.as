package com.damidia
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Responsive
	{
		public function Responsive()
		{
		}
		
		static public function text(el:TextField, text:String, checkHeight=true, checkBoth=false):void
		{
			var maxHeight:Number = el.height;
			var maxWidth:Number = el.width;
			el.text = text;
			
			el.autoSize = TextFieldAutoSize.LEFT;
			var tf:TextFormat = el.getTextFormat();
			var newSize:Number = 0;
			
			var check:Boolean = (checkHeight) ? el.height > maxHeight : el.width > maxWidth;
			if (checkBoth) check = el.height > maxHeight || el.width > maxWidth;
			
			while(check)
			{
				newSize = Number(tf.size) - 1;
				
				tf.size = newSize;
				
				el.text = text;
				
				el.setTextFormat(tf);
				
				check = (checkHeight) ? el.height > maxHeight : el.width > maxWidth;
				if (checkBoth) check = el.height > maxHeight || el.width > maxWidth;
			}	
		}
	}
}