package  {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	public class TextBg extends MovieClip {
		
		
		public function TextBg(textoReferencia:TextField) {
			
			this.x = textoReferencia.x;
			this.y = textoReferencia.y;
			this.width = textoReferencia.width;
			this.height = textoReferencia.height;	
		}
	}
	
}
