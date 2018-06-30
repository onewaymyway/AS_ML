package oneway.supervised.decisiontree 
{
	/**
	 * ...
	 * @author ww
	 */
	public class DecisionNode 
	{
		public var feature_i:int;
		public var threshold:*;
		public var value:*=null;
		public var true_branch:DecisionNode;
		public var false_branch:DecisionNode;
		public function DecisionNode(feature_i:int=0,threshold:*=null,value:*=null,true_branch:*=null,false_branch:*=null) 
		{
			this.feature_i = feature_i;
			this.threshold = threshold;
			this.value = value;
			this.true_branch = true_branch;
			this.false_branch = false_branch;
		}
		
	}

}