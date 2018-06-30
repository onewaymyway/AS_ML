package oneway.utils 
{
	import oneway.math.MatrixTools;
	/**
	 * ...
	 * @author ww
	 */
	public class DataManipulation 
	{
		
		public function DataManipulation() 
		{
			
		}
		
		public static function shuffle_data(X:Array, y:Array, seed:*= null):Array
		{
			var idx:Array;
			idx = MatrixTools.range(X.length);
			MatrixTools.shuffle(idx);
			return [MatrixTools.getByIndexs(X,idx),MatrixTools.getByIndexs(y,idx)];
		}
		
		public static function batch_iterator(X:Array, y:Array = null, batch_size:int = 64):Array
		{
			var n_samples:int;
			n_samples = X.length;
			return null;
		}
		
		private static function _isFeatureBiger(vec:Array, feature_i:int, threshold:Number):Boolean
		{
			return vec[feature_i] >= threshold;
		}
		
		private static function _isFeatureEqual(vec:Array, feature_i:int, threshold:*):Boolean
		{
			return vec[feature_i] == threshold;
		}
		
		public static function divide_on_feature(X:Array, feature_i:int, threshold:*):Array
		{
			var x1:Array;
			var x2:Array;
			x1 = [];
			x2 = [];
			var i:int, len:int;
			len = X.length;
			var tVec:Array;
			var splitFun:Function;
			if (threshold is Number)
			{
				splitFun = _isFeatureBiger;
			}else
			{
				splitFun = _isFeatureEqual;
			}
			for (i = 0; i < len; i++)
			{
				tVec = X[i];
				if (splitFun(tVec, feature_i, threshold))
				{
					x1.push(tVec);
				}else
				{
					x2.push(tVec);
					
				}
			}
			
			return [x1,x2];
		}
		
		public static function train_test_split(X:Array, y:Array, test_size:Number = 0.5, shuffle:Boolean = true):Array
		{
			if (shuffle)
			{
				[X, y] = shuffle_data(X, y);
			}
			var split_i:int;
			split_i = X.length - Math.floor(X.length * test_size);
			return [X.slice(0,split_i),X.slice(split_i),y.slice(0,split_i),y.slice(split_i)];
		}
		
		
	}

}