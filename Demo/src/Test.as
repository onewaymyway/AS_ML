package  
{
	import oneway.math.MatrixTools;
	import oneway.ml.DecisionTree;
	/**
	 * ...
	 * @author ww
	 */
	public class Test 
	{
		
		public function Test() 
		{
			test();
		}
		
		private function test():void
		{
			var dt:DecisionTree;
			dt = new DecisionTree();
			
			var dataSet:Array;
			dataSet =  [[1, 1, 'yes'], [1, 1, 'yes'], [1, 0, 'no'], [0, 1, 'no'], [0, 1, 'no']];
			
			var labels:Array = ['no surfacing', 'flippers'];
			var ent:Number;
			ent = dt.calcShannonEnt(dataSet);
			trace("ent:", ent);
			
			var myTree:Object;
			myTree = dt.createTree(dataSet, MatrixTools.copyArr(labels));
			
			trace(myTree);
			
			var rst:String;
			rst = dt.classify(myTree, labels, [1, 1]);
			
			trace(rst);
			
			var a:int, b:int;
			[a, b] = [1, 2];
			trace(a,b);
		}
	}

}