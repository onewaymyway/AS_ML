package oneway.math 
{
	/**
	 * ...
	 * @author ww
	 */
	public class MathFuns 
	{
		
		public function MathFuns() 
		{
			
		}
		
		public static function abs(value:Number):Number
		{
			return value >= 0?value: -value;
		}
		
		public static function sign(value:Number):Number
		{
			return value >= 0?1: -1;
		}
		
		public static function cloneValue(value:Number):Number
		{
			return value;
		}
	}

}