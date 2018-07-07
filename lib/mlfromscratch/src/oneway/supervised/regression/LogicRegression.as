package oneway.supervised.regression 
{
	import oneway.deeplearning.active.Sigmoid;
	/**
	 * ...
	 * @author ww
	 */
	public class LogicRegression extends Regression 
	{
		
		public function LogicRegression(n_itrations:int, learning_rate:Number) 
		{
			super(n_itrations, learning_rate);
			this.regularization = new None_regularization();
			this.transformFun = (new Sigmoid()).__call__;
			this.transformDirSame = true;
		}
		
	}

}