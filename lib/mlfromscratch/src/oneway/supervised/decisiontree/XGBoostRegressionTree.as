package oneway.supervised.decisiontree 
{
	import oneway.math.MatrixTools;
	/**
	 * ...
	 * @author ww
	 */
	public class XGBoostRegressionTree extends DecisionTree 
	{
		
		public function XGBoostRegressionTree(min_samples_split:int=2, min_impurity:Number=1e-7, max_depth:Number=999, loss:Function=null) 
		{
			super(min_samples_split, min_impurity, max_depth, loss);
			
		}
		
		public function _split(y:Array):Array
		{
			var col:int;
			col = Math.floor(MatrixTools.shape(y)[1] / 2);
			return [y.slice(0,col),y.slice(col)];
		}
		
		public function _gain(y:Array, y_pred:Array):Number
		{
			
		}
		
	}

}