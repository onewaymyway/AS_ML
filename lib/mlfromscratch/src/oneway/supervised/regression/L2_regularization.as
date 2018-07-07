package oneway.supervised.regression 
{
	import oneway.math.Matrix;
	/**
	 * ...
	 * @author ww
	 */
	public class L2_regularization implements IRegularization
	{
		
		public var alpha:Number;
		public function L2_regularization(alpha:Number) 
		{
			this.alpha = alpha;
		}
		
		public function __call__(w:Matrix):*
		{
			return w.T.dot(w).multiply(alpha * 0.5);
		}
		
		public function grad(w:Matrix):*
		{
			return w.multiply(alpha,true);
		}
		
	}

}