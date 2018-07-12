package
{
	public class Util
	{
		public function Util()
		{
		}
		
		static public function dataFormat(strData:String, format:String="d/m", fromDb:Boolean = true):String
		{
			if (strData == "") return null;
			var splt:Array = strData.split(" ")[0].split("-");
			
			var month:uint = Math.floor(splt[1]);
			var strReturn:String = format.replace("d", zeroPad(splt[2])).replace("m", zeroPad(month.toString())).replace("y", splt[0]);
			
			return strReturn;
		}
		
		static public function zeroPad(string:String,length:int=2):String
		{
			return ("0"+string).substr(-length);
		}
		
		static public function getDateObject(strData:String):Date
		{
			var splt:Array = strData.split(" ")[0].split("-");
			
			var dateReturn:Date = new Date();
			dateReturn.fullYear = Number(splt[0]);
			dateReturn.month = Number(splt[1])-1;
			dateReturn.date = Number(splt[2]);
			
			return dateReturn;
		}
		
		static public function dateInBetween(date:Date, from:String, to:String):Boolean
		{
			if (to == "")
			{
				to = "3000-12-12";
			}
			return (date.time >= getDateObject(from).time && date.time <= getDateObject(to).time);				
		}
	}
}