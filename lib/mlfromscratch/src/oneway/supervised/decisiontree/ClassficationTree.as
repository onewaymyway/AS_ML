package oneway.supervised.decisiontree 
{
	import oneway.math.MatrixTools;
	import oneway.utils.DataOperation;
	/**
	 * ...
	 * @author ww
	 */
	public class ClassficationTree extends DecisionTree
	{
		
		public function ClassficationTree(min_samples_split:int=2, min_impurity:Number=1e-7,max_depth:Number=999, loss:Function=null) 
		{
			super(min_samples_split,min_impurity,max_depth,loss);
		}
		
		public function _calculate_information_gain(y:Array, y1:Array, y2:Array):Number
		{
			var p:Number;
			p = y1.length / y.length;
			var entropy:Number;
			entropy = DataOperation.calculate_entropy(y);
			var info_gain:Number;
			info_gain = entropy - p * DataOperation.calculate_entropy(y1) - (1 - p) * DataOperation.calculate_entropy(y2);
			return info_gain;
		}
		
		public function _majority_vote(y:Array):*
		{
			return MatrixTools.getMaxKey(MatrixTools.listToCountDic(y));
		}
		
		override public function fit(X:Array, y:Array, loss:Function = null):void 
		{
			_impurity_calculation = _calculate_information_gain;
			_leaf_value_calculation = _majority_vote;
			super.fit(X, y, loss);
		}
	}

}