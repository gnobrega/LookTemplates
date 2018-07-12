/*
 Copyright aswing.org, 颜色类.
*/

package org.aswing{

/**
 * ASColor object to set color and alpha for a movieclip.
 * @author firdosh, iiley, n0rthwood
 */
public class ASColor{
			
	public static const WHITE:ASColor = new ASColor(0xffffff);
	
	public static const LIGHT_GRAY:ASColor = new ASColor(0xc0c0c0);
	
	public static const GRAY:ASColor = new ASColor(0x808080);
	
	public static const DARK_GRAY:ASColor = new ASColor(0x404040);
	
	public static const BLACK:ASColor = new ASColor(0x000000);
	
	public static const RED:ASColor = new ASColor(0xff0000);
	
	public static const PINK:ASColor = new ASColor(0xffafaf);
	
	public static const ORANGE:ASColor = new ASColor(0xffc800);
	
	public static const HALO_ORANGE:ASColor = new ASColor(0xFFC200);
	
	public static const YELLOW:ASColor = new ASColor(0xffff00);
	
	public static const GREEN:ASColor = new ASColor(0x00ff00);
	
	public static const HALO_GREEN:ASColor = new ASColor(0x80FF4D);
	
	public static const MAGENTA:ASColor = new ASColor(0xff00ff);
	
	public static const CYAN:ASColor = new ASColor(0x00ffff);
	
	public static const BLUE:ASColor = new ASColor(0x0000ff);
	
	public static const HALO_BLUE:ASColor = new ASColor(0x2BF5F5);
	
	
	protected var rgb:uint;
	protected var alpha:Number;
	
	protected var hue:Number;
	protected var luminance:Number;
	protected var saturation:Number;
	private var hlsCounted:Boolean;
	
	/**
	 * Create a ASColor，建立颜色，参数1:颜色值  参数2:透明值
	 */
	public function ASColor (rgb:uint=0x000000, alpha:Number=1){
		this.rgb = rgb;
		this.alpha = Math.min(1, Math.max(0, alpha));
		hlsCounted = false;
	}
	
	/**
	 * Returns the alpha component in the range 0-1.获取透明值，取值范围为0-1
	 */
	public function getAlpha():Number{
		return alpha;	
	}
	
	/**
	 * Returns the RGB value representing the color.返回RGB顔色
	 */
	public function getRGB():uint{
		return rgb;	
	}
	
	/**
	 * Returns the ARGB value representing the color.返回32位带透明的顔色值
	 */	
	public function getARGB():uint{
		var a:uint = alpha*255;
		return rgb | (a << 24);
	}
	
	/**
     * Returns the red component in the range 0-255.
     * @return the red component.
	 * @返回红色通道顔色值，范围在0-255之间
     */
	public function getRed():uint{
		return (rgb & 0x00FF0000) >> 16;
	}
	
	/**
     * Returns the green component in the range 0-255.
     * @return the green component.
	 * @返回绿色通道顔色值，范围在0-255之间
     */	
	public function getGreen():uint{
		return (rgb & 0x0000FF00) >> 8;
	}
	
	/**
     * Returns the blue component in the range 0-255.
     * @return the blue component.
	 * @返回蓝色通道顔色值，范围在0-255之间
     */	
	public function getBlue():uint{
		return (rgb & 0x000000FF);
	}
	
	/**
     * Returns the hue component in the range [0, 1].
     * @return the hue component.
	 * @获取色相，范围为0-1.
     */
	public function getHue():Number{
		countHLS();
		return hue;
	}
	
	
	/**
     * Returns the luminance component in the range [0, 1].
     * @return the luminance component.
	 * @获取亮度，范围为0-1.
     */
	public function getLuminance():Number{
		countHLS();
		return luminance;
	}
	
	
	/**
     * Returns the saturation component in the range [0, 1].
     * @return the saturation component.
	 * @获取保和度，范围为0-1.
     */
	public function getSaturation():Number{
		countHLS();
		return saturation;
	}
	
	private function countHLS():void{
		if(hlsCounted){
			return;
		}
		hlsCounted = true;
		var rr:Number = getRed() / 255.0;
		var gg:Number = getGreen() / 255.0;
		var bb:Number = getBlue() / 255.0;
		
		var rnorm:Number, gnorm:Number, bnorm:Number;
		var minval:Number, maxval:Number, msum:Number, mdiff:Number;
		var r:Number, g:Number, b:Number;
		   
		r = g = b = 0;
		if (rr > 0) r = rr; if (r > 1) r = 1;
		if (gg > 0) g = gg; if (g > 1) g = 1;
		if (bb > 0) b = bb; if (b > 1) b = 1;
		
		minval = r;
		if (g < minval) minval = g;
		if (b < minval) minval = b;
		maxval = r;
		if (g > maxval) maxval = g;
		if (b > maxval) maxval = b;
		
		rnorm = gnorm = bnorm = 0;
		mdiff = maxval - minval;
		msum  = maxval + minval;
		luminance = 0.5 * msum;
		if (maxval != minval) {
			rnorm = (maxval - r)/mdiff;
			gnorm = (maxval - g)/mdiff;
			bnorm = (maxval - b)/mdiff;
		} else {
			saturation = hue = 0;
			return;
		}
		
		if (luminance < 0.5)
		  saturation = mdiff/msum;
		else
		  saturation = mdiff/(2.0 - msum);
		
		if (r == maxval)
		  hue = 60.0 * (6.0 + bnorm - gnorm);
		else if (g == maxval)
		  hue = 60.0 * (2.0 + rnorm - bnorm);
		else
		  hue = 60.0 * (4.0 + gnorm - rnorm);
		
		if (hue > 360)
			hue = hue - 360;
		hue /= 360;
	}	
	
	/**
	 * Create a new <code>ASColor</code> with another alpha but same rgb.
	 * @param newAlpha the new alpha
	 * @return the new <code>ASColor</code>
	 * @建立一个新的ASColor对象，相同颜色，不同的透明度
	 */
	public function changeAlpha(newAlpha:Number):ASColor{
		return new ASColor(getRGB(), newAlpha);
	}
	
	/**
	 * Create a new <code>ASColor</code> with just change hue channel value.
	 * @param newHue the new hue value
	 * @return the new <code>ASColor</code>
	 * @建立一个新的ASColor对象，攺变色相通道的值
	 * @参数：新的色相值
	 * @返回一个新的ASColor对象
	 */	
	public function changeHue(newHue:Number):ASColor{
		return getASColorWithHLS(newHue, getLuminance(), getSaturation(), getAlpha());
	}
	
	/**
	 * Create a new <code>ASColor</code> with just change luminance channel value.
	 * @param newLuminance the new luminance value
	 * @return the new <code>ASColor</code>
	 * @建立一个新的ASColor对象，攺变亮度通道的值
	 * @参数：新的亮度值
	 * @返回一个新的ASColor对象
	 */	
	public function changeLuminance(newLuminance:Number):ASColor{
		return getASColorWithHLS(getHue(), newLuminance, getSaturation(), getAlpha());
	}
	
	/**
	 * Create a new <code>ASColor</code> with just change saturation channel value.
	 * @param newSaturation the new saturation value
	 * @return the new <code>ASColor</code>
	 * @建立一个新的ASColor对象，攺变保和度通道的值
	 * @参数：新的保和度
	 * @返回一个新的ASColor对象
	 */	
	public function changeSaturation(newSaturation:Number):ASColor{
		return getASColorWithHLS(getHue(), getLuminance(), newSaturation, getAlpha());
	}
	
    /**
     * Creates a new <code>ASColor</code> that is a darker version of this
     * <code>ASColor</code>.
     * @param factor the darker factor(0, 1), default is 0.7
     * @return     a new <code>ASColor</code> object that is  
     *                 a darker version of this <code>ASColor</code>.
     * @see        #brighter()
	 //颜色变暗
     */		
	public function darker(factor:Number=0.7):ASColor{
        var r:uint = getRed();
        var g:uint = getGreen();
        var b:uint = getBlue();
		return getASColor(r*factor, g*factor, b*factor, alpha);
	}
	
    /**
     * 创建一个新的ASColor对象，使颜色变亮    
     * @加亮系数,取值范围为[0-1] 默认为0.7   
     */	
	public function brighter(factor:Number=0.7):ASColor{
        var r:uint = getRed();
        var g:uint = getGreen();
        var b:uint = getBlue();

        /* From 2D group:
         * 1. black.brighter() should return grey
         * 2. applying brighter to blue will always return blue, brighter
         * 3. non pure color (non zero rgb) will eventually return white
         */
        var i:Number = Math.floor(1.0/(1.0-factor));
        if ( r == 0 && g == 0 && b == 0) {
           return getASColor(i, i, i, alpha);
        }
        if ( r > 0 && r < i ) r = i;
        if ( g > 0 && g < i ) g = i;
        if ( b > 0 && b < i ) b = i;
        
        return getASColor(r/factor, g/factor, b/factor, alpha);
	}
	
	/**
	 * 根据RGB三原色的值和透明度，返回一个ASColor对象，RGB三原色的取值范围为[0-255],透明度的取值范围为[0-1] 
	 
	 * @参数r：红色通道
	 * @参数g：绿色通道
	 * @参数b：蓝色通道
	 * @参数a：透明通道
	 */
	public static function getASColor(r:uint, g:uint, b:uint, a:Number=1):ASColor{
		return new ASColor(getRGBWith(r, g, b), a);
	}
	
	/**
	 * 根据ARGB值,返回一个ASColor对象
	 * @参数为argb32位颜色值,如0xFFEEEEEE;
	 * @返回ASColor对象
	 */
	public static function getWithARGB(argb:uint):ASColor{
		var rgb:uint = argb & 0x00FFFFFF;
		var alpha:Number = (argb >>> 24)/255;
		return new ASColor(rgb, alpha);
	}
	
	/**
	 * 根据HLS色系(色相\亮度\饱和度\透明度)，取值范围为0-1，返回一个ASColor对象 	 
	 * @参数 h 色相
	 * @参数 l 亮度
	 * @参数 s 饱和度
	 * @参数 a 透明度
	 */	
	public static function getASColorWithHLS(h:Number, l:Number, s:Number, a:Number=1):ASColor{
		var c:ASColor = new ASColor(0, a);
		c.hlsCounted = true;
		c.hue = Math.max(0, Math.min(1, h));
		c.luminance = Math.max(0, Math.min(1, l));
		c.saturation = Math.max(0, Math.min(1, s));
		
		var H:Number = c.hue;
		var L:Number = c.luminance;
		var S:Number = c.saturation;
		
		var p1:Number, p2:Number, r:Number, g:Number, b:Number;
		p1 = p2 = 0;
		H = H*360;
		if(L<0.5){
			p2=L*(1+S);
		}else{
			p2=L + S - L*S;
		}
		p1=2*L-p2;
		if(S==0){
			r=L;
			g=L;
			b=L;
		}else{
			r = hlsValue(p1, p2, H+120);
			g = hlsValue(p1, p2, H);
			b = hlsValue(p1, p2, H-120);
		}
		r *= 255;
		g *= 255;
		b *= 255;
		var color_n:Number = (r<<16) + (g<<8) +b;
		var color_rgb:uint = Math.max(0, Math.min(0xFFFFFF, Math.round(color_n)));
		c.rgb = color_rgb;
		return c;
	}
	
	private static function hlsValue(p1:Number, p2:Number, h:Number):Number{
	   if (h > 360) h = h - 360;
	   if (h < 0)   h = h + 360;
	   if (h < 60 ) return p1 + (p2-p1)*h/60;
	   if (h < 180) return p2;
	   if (h < 240) return p1 + (p2-p1)*(240-h)/60;
	   return p1;
	}	
		
	/**
	 * 根据红、绿、蓝,取值范围[0-255]，返回RGB颜色值,一个无符号整数. 
	 * @参数rr:红色通道
	 * @参数gg 绿色通道
	 * @参数bb 蓝色通道
	 */
	public static function getRGBWith(rr:uint, gg:uint, bb:uint):uint {
		var r:uint = rr;
		var g:uint = gg;
		var b:uint = bb;
		if(r > 255){
			r = 255;
		}
		if(g > 255){
			g = 255;
		}
		if(b > 255){
			b = 255;
		}
		var color_n:uint = (r<<16) + (g<<8) +b;
		return color_n;
	}
	
	public function toString():String{
		return "ASColor(rgb:"+rgb.toString(16)+", alpha:"+alpha+")";
	}

	/**
	 * 比较二个ASColor对象是否为同一个对象
	 * @参数o：被比较的ASColor对象
	 * 
	 * @返回  一个布尔值,如果两个对象相同，返回真;
	 */	
	public function equals(o:Object):Boolean{
		var c:ASColor = o as ASColor;
		if(c != null){
			return c.alpha === alpha && c.rgb === rgb;
		}else{
			return false;
		}
	}
}

}