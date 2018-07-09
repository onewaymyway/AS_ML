package oneway.supervised.decisiontree 
{
	import oneway.math.Matrix;
	/**
	 * ...
	 * @author ww
	 */
	public class DecisionTree 
	{
		public var root:*;
		public var min_samples_split:int;
		public var min_impurity:Number;
		public var max_depth:Number;
		public var loss:Function;
		public var _impurity_calculation:Function;
		public var _leaf_value_calculation:Function;
		public var one_dim:Boolean=false;
		public function DecisionTree(min_samples_split:int=2, min_impurity:Number=1e-7,max_depth:Number=999, loss:Function=null) 
		{
			this.min_samples_split = min_samples_split;
			this.min_impurity = min_impurity;
			this.max_depth = max_depth;
			this.loss = loss;
		}
		
		public function fit(X:Matrix, y:Matrix, loss:Function = null):void
		{
			if (y[0] is Array)
			{
				one_dim = false;
			}else
			{
				one_dim = true;
			}
			this.root = _build_tree(X, y);
			this.loss = null;
		}
		
		public function _build_tree(X:Matrix, y:Matrix, current_depth:int = 0):DecisionNode
		{
			var largest_impurity:Number;
			largest_impurity = 0;
			var best_criteria:int;
			var best_sets:Array;
			
			var Xy:Matrix;
			
			
			//todo
		}
		
		public function predict_value(x:Matrix, tree:DecisionNode= null):void
		{
			if (!tree) tree = this.root;
			if (tree.value!=null) return tree.value;
			
			var feature_value:*;
			feature_value = x[tree.feature_i];
			
			var branch:DecisionNode;
			branch = tree.false_branch;
			if (feature_value is Number)
			{
				if (feature_value >= tree.threshold)
				{
					branch = tree.true_branch;
				}
			}else
			{
				if (feature_value == tree.threshold)
				{
					branch = tree.true_branch;
				}
			}
			return predict_value(x, branch);
		}
		
		public function predict(X:Matrix):Array
		{
			var i:int, len:int;
			len = X.length;
			var pred:Array;
			pred = [];
			for (i = 0; i < len; i++)
			{
				pred.push(predict_value(X[i]);
			}
		
			return pred;
		}
		
	}

}