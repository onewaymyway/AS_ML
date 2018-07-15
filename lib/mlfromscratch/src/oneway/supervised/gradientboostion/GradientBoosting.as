package oneway.supervised.gradientboostion
{
	import oneway.deeplearning.CrossEntropy;
	import oneway.deeplearning.Loss;
	import oneway.deeplearning.SquareLoss;
	import oneway.math.Matrix;
	import oneway.supervised.decisiontree.RegressionTree;
	
	/**
	 * ...
	 * @author ww
	 */
	public class GradientBoosting
	{
		public var n_estimators:int;
		public var learning_rate:Number;
		public var min_samples_split:int;
		public var min_impurity:Number;
		public var max_depth:int;
		public var regression:Boolean;
		public var loss:Loss;
		public var trees:Array;
		public function GradientBoosting(n_estimators:int, learning_rate:Number, min_samples_split:int, min_impurity:Number, max_depth:int, regression:Boolean)
		{
		
			this.n_estimators = n_estimators;
			this.learning_rate = learning_rate;
			this.min_samples_split = min_samples_split;
			this.min_impurity = min_impurity;
			this.max_depth = max_depth;
			this.regression = regression;
			
			this.loss = new SquareLoss();
			
			if (!this.regression)
			{
				this.loss = new CrossEntropy();
			}
			trees = [];
			var i:int, len:int;
			var tTree:RegressionTree;
			for (i = 0; i < len; i++)
			{
				tTree = new RegressionTree(min_samples_split, min_impurity, max_depth);
				trees.push(tTree);
			}
		}
		
		public function fit(X:Matrix, y:Matrix):void
		{
			var y_pred:Matrix;
			y_pred = y.clone();
			y_pred.fillByNum(0);
			var i:int, len:int;
			len = n_estimators;
			var gradient:Matrix;
			var update:Matrix;
			for (i = 0; i < len; i++)
			{
				gradient = this.loss.gradient(y, y_pred);
				this.trees[i].fit(X, gradient);
				update = this.trees[i].predict(X);
				update.multiply(this.learning_rate);
				y_pred.sub(update, false);
			}
		}
		
		public function predict(X:Matrix):Matrix
		{
			var y_pred:Matrix;
			y_pred = new Matrix(X.shape()[1], 1);
			y_pred.fillByNum(0);
			var i:int, len:int;
			len = trees.length;
			var tTree:RegressionTree;
			var update:Matrix;
			for (i = 0; i < len; i++)
			{
				tTree = trees[i];
				update = tTree.predict(X);
				update.multiply(this.learning_rate, false);
				y_pred.sub(update);
			}
			if (!this.regression)
			{
				//todo
			}
			return y_pred;
		}
	
	}

}