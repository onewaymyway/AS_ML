package oneway.supervised.decisiontree 
{
	import oneway.math.Matrix;
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
		
		public function _gain_by_taylor(y:Array, y1:Array, y2:Array):Number
		{
			
		}
		
		public function _approximate_update(y:Array):Number
		{
			
		}
		
		override public function fit(X:Matrix, y:Matrix, loss:Function = null):void 
		{
			this._impurity_calculation = this._gain_by_taylor;
			this._leaf_value_calculation = this._approximate_update;
			super.fit(X, y, loss);
		}
		
	}

}