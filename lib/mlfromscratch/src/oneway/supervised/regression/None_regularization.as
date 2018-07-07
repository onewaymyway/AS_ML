package oneway.supervised.regression 
{
	import oneway.math.Matrix;
	/**
	 * ...
	 * @author ww
	 */
	public class None_regularization implements IRegularization
	{
		
		public function None_regularization() 
		{
			
		}
		
		public function __call__(w:Matrix):*
		{
			return w.clone().fillByNum(0);
		}
		
		public function grad(w:Matrix):*
		{
			return w.clone().fillByNum(0);
		}
	}

}