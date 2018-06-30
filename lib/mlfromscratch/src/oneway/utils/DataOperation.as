package oneway.utils 
{
	import oneway.math.MatrixTools;
	/**
	 * ...
	 * @author ww
	 */
	public class DataOperation 
	{
		
		public function DataOperation() 
		{
			
		}
		
		public static function calculate_entropy(y:Array):Number
		{
			var dic:Object;
			dic = MatrixTools.listToCountDic(y);
			var key:String;
			var entropy:Number = 0;
			var dataLen:int = y.length;
			for (key in dic)
			{
				var p:Number;
				p = dic[key] / dataLen;
				entropy += -p * Math.log(p);
			}
			return entropy;
		}
		
		public static function mean_squared_error(y_true:Array, y_pred:Array):Number
		{
			var rst:Number = 0;
			var i:int, len:int;
			len = y_true.length;
			for (i = 0; i < len; i++)
			{
				rst += (y_true-y_pred) * (y_true-y_pred);
			}
			return rst / len;
		}
		
		public static function mean(list:Array):Number
		{
			var i:int, len:int;
			var rst:Number;
			rst = 0;
			len = list.length; 
			for (i = 0; i < len; i++)
			{
				rst += list[i];
			}
			return rst / len;
		}
		public static function calculate_variance(X:Array):Number
		{
			var i:int, len:int;
			var rst:Number;
			rst = 0;
			var m:Number;
			m = mean(X);
			len = X.length;
			for (i = 0; i < len; i++)
			{
				rst += (X[i] - m) * (X[i] - m);
			}
			return rst / len;
		}
		
		public static function calculate_std_dev(X:Array):Number
		{
			return Math.sqrt(calculate_variance(X));
		}
		
		public static function euclidean_distance(x1:Array, x2:Array):Number
		{
			var i:int, len:int;
			var rst:Number = 0;
			len = x1.length;
			for (i = 0; i < len; i++)
			{
				rst += (x1[i] - x2[i]) * (x1[i] - x2[i]);
			}
			return Math.sqrt(rst);
		}
		
		public static function accuracy_score(y_true:Array, y_pred:Array):Number
		{
			var i:int, len:int;
			len = y_true.length;
			var count:int=0;
			for (i = 0; i < len; i++)
			{
				if (y_true[i] == y_pred[i]) count++;
			}
			return count / len;
		}
		
	}

}