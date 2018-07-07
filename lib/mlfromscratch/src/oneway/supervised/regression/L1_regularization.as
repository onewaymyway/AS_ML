package oneway.supervised.regression 
{
	import oneway.math.MathFuns;
	import oneway.math.Matrix;
	/**
	 * ...
	 * @author ww
	 */
	public class L1_regularization implements IRegularization
	{
		public var alpha:Number;
		public function L1_regularization(alpha:Number) 
		{
			this.alpha = alpha;
		}
		
		public function __call__(w:Matrix):*
		{
			var rst:Matrix;
			rst=w.applyFunction(MathFuns.abs, true);
			rst.multiply(alpha);
			return rst;
		}
		
		public function grad(w:Matrix):*
		{
			return w.applyFunction(MathFuns.sign, true).multiply(alpha);
		}
	}

}