package oneway.deeplearning.active 
{
	/**
	 * ...
	 * @author ww
	 */
	public class Sigmoid 
	{
		
		public function Sigmoid() 
		{
			
		}
		
		public function __call__(x:Number):Number
		{
			return 1 / (1+Math.exp(-x));
		}
		
		public function grad(x:Number):Number
		{
			var v:Number;
			v = __call__(x);
			return v * (1 - v);
		}
		
	}

}