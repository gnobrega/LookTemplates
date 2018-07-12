package  {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.Stage;
	import flash.utils.setInterval;
	import flash.text.AntiAliasType;
	import flash.display.MovieClip;
	
	public class TextEffect
	{
		
		static private function geraLinha(texto:String, formatacao:TextFormat, xPos:Number):TextField
		{
			var linha:TextField = new TextField();
				linha.autoSize = TextFieldAutoSize.LEFT;
				linha.selectable = false;
				linha.embedFonts = true;
				linha.text = texto;
				linha.defaultTextFormat = formatacao;
				linha.x = xPos;
				linha.multiline = false;
				linha.wordWrap = false;
				linha.antiAliasType = AntiAliasType.NORMAL;
			
			return linha;
		}
		
		static private function aplicaTexto(stage, textoSeparado:Array, formatacao:TextFormat, initX:Number, larguraMaxima:Number):Array
		{
			var linhas:Array = new Array();
			
			var referencia:TextField = geraLinha("", formatacao, 0);
			
			for(var i:uint = 0, l:uint = textoSeparado.length; i < l; i++)
			{
				
				if (referencia.text != "") 
				{
					referencia.appendText(" ");
				}
				
				var textoAnterior:String = referencia.text;
				
				referencia.appendText(textoSeparado[i]);
				
				if (referencia.width > larguraMaxima)
				{
					linhas.push(geraLinha(textoAnterior, formatacao, initX));
					
					referencia.text = textoSeparado[i];
				}
			}
			
			if (referencia.text != "")
			{
				linhas.push(geraLinha(referencia.text, formatacao, initX));
			}
			
			return linhas;
		}
		
		static public function aplicaDivisao(stage, texto:TextField, maximoLinhas, bg:Class, strTexto:String):void
		{

			var larguraMaxima:Number = texto.width;
			
			var initX:Number = texto.x;

			texto.autoSize = TextFieldAutoSize.LEFT;
			
			var linhas:Array = new Array();
			
			var textoSeparado:Array = strTexto.split(" ");
				
			var formatacao:TextFormat = texto.getTextFormat();
			var sizeInicial:Number = Number(formatacao.size);

			var distanciaDeBaixo:Number = 100;
			
			var initHeight:Number = texto.height;			
			
			do 
			{
				texto.text = "";
				
				linhas = aplicaTexto(stage, textoSeparado, formatacao, initX, larguraMaxima);
				
				formatacao.size = Number(formatacao.size) - 1;
				
			} while(linhas.length > maximoLinhas);
			
			formatacao.size = Number(formatacao.size) + 1;
			
			var diferenca = ((Number( formatacao.size ) * initHeight) / sizeInicial) / 2;
			
			for(var idx = linhas.length, atual=1; --idx >= 0; atual++)
			{
				var linhaAtual:TextField = linhas[idx];

				linhaAtual.setTextFormat(formatacao);
				
				linhaAtual.y = distanciaDeBaixo - (diferenca * atual);

				stage.addChild(linhaAtual);
				
				var textoBg:MovieClip = (new bg(linhaAtual)) as MovieClip;
				
				stage.addChildAt(textoBg, stage.getChildIndex(linhaAtual));
			}
			
		}
	}
	
}
