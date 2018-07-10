package oneway.supervised.decisiontree 
{
	import oneway.math.Matrix;
	import oneway.math.MatrixTools;
	import oneway.utils.DataManipulation;
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
		public var one_dim:Boolean = false;
		public var leaf_value:*;
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
			var best_criteria:Object;
			var best_sets:Object;
			
			var Xy:Matrix;
			Xy = X.concatenate(y,1);
			
			var yList:Array;
			yList = y.getCulAsList(0);
			var n_samples:int;
			var n_features:int;
			[n_samples, n_features] = X.shape();
			if (n_samples >= this.min_samples_split && current_depth < this.max_depth)
			{
				var feature_i:int;
				for (feature_i = 0; feature_i < n_features; feature_i++)
				{
					var feature_values:Array;
					feature_values = MatrixTools.getColumn(feature_i, X);
					var featureDic:Object;
					featureDic = MatrixTools.listToCountDic(feature_values);
					var threshold:*;
					for (threshold in featureDic)
					{
						//threshold
						var Xy1:Matrix, Xy2:Matrix;
						[Xy1, Xy2] = DataManipulation.divide_on_feature(Xy, feature_i, threshold);
						if ( Xy1.length > 0 && Xy2.length > 0)
						{
							var y1:Array;
							var y2:Array;
							y1 = Xy1.getCulAsList(n_features);
							y2 = Xy2.getCulAsList(n_features);
							
							var impurity:Number;
							impurity = this._impurity_calculation(yList, y1, y2);
							
							if (impurity > largest_impurity)
							{
								largest_impurity = impurity;
								best_criteria = { "feature_i":feature_i, "threshold":threshold };
								best_sets = { };
								best_sets["leftX"] = Xy1.copyRec(0, -1, 0, n_features);
								best_sets["lefty"] = Xy1.copyRec(0, -1, n_features, -1);
								best_sets["rightX"] = Xy2.copyRec(0, -1, 0, n_features);
								best_sets["righty"]=Xy2.copyRec(0,-1,n_features,-1);
							}
						}
					}
				}
			}
			
			if (largest_impurity > this.min_impurity)
			{
				var true_branch:DecisionNode;
				var false_branch:DecisionNode;
				true_branch = this._build_tree(best_sets["leftX"], best_sets["lefty"], current_depth + 1);
				false_branch = this._build_tree(best_sets["rightX"], best_sets["righty"], current_depth + 1);
				return DecisionNode(best_criteria["feature_i"], best_criteria["threshold"], null, true_branch, false_branch);
				
			}
			leaf_value = this._leaf_value_calculation(yList);
			return new DecisionNode(0, null, leaf_value, null, null);
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