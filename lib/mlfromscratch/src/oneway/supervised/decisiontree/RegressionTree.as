package oneway.supervised.decisiontree {
	import oneway.math.Matrix;
	import oneway.math.MatrixTools;
	import oneway.utils.DataOperation;
	
	/**
	 * ...
	 * @author ww
	 */
	public class RegressionTree extends DecisionTree {
		
		public function RegressionTree(min_samples_split:int = 2, min_impurity:Number = 1e-7, max_depth:Number = 999, loss:Function = null) {
			super(min_samples_split, min_impurity, max_depth, loss);
		
		}
		
		public function _calculate_variance_reduction(y:Array, y1:Array, y2:Array):Number {
			var tot:Number;
			tot = DataOperation.calculate_variance(y);
			var v1:Number;
			v1 = DataOperation.calculate_variance(y1);
			var v2:Number;
			v2 = DataOperation.calculate_variance(y2);
			var f1:Number;
			f1 = y1.length / y.length;
			var f2:Number;
			f2 = y2.length / y.length;
			var v_reduction:Number;
			v_reduction = tot - (f1 * v1 + f2 * v2);
			return v_reduction;
		}
		
		public function _mean_of_y(y:Array):Number {
			return DataOperation.mean(y);
		}
		
		override public function fit(X:Matrix, y:Matrix, loss:Function = null):void {
			this._impurity_calculation = this._calculate_variance_reduction
			this._leaf_value_calculation = this._mean_of_y
			super.fit(X, y, loss);
		}
	}

}