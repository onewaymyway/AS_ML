package oneway.supervised.regression 
{
	/**
	 * ...
	 * @author ww
	 */
	public class LineRegression extends Regression 
	{
		
		public function LineRegression(n_itrations:int, learning_rate:Number) 
		{
			super(n_itrations, learning_rate);
			this.regularization = new None_regularization();
		}
		
	}

}