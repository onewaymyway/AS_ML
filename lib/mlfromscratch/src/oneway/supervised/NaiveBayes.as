package oneway.supervised 
{
	import oneway.math.Matrix;
	import oneway.math.MatrixTools;
	import oneway.utils.DataOperation;
	/**
	 * 朴素贝叶斯算法
	 * 单个feature分布使用高斯分布估计
	 * @author ww
	 */
	public class NaiveBayes 
	{
		
		public function NaiveBayes() 
		{
			
		}
		public var rateDic:Object;
		public var keyFeatureParamDic:Object;
		public var classList:Array;
		public function fit(X:Matrix, y:Matrix):void
		{
			var yList:Array;
			yList = MatrixTools.getColumn(0, y);
			
			rateDic = MatrixTools.listToKeyRateDic(yList);
			var key:*;
			
			keyFeatureParamDic = {};
			var fealtureCount:int;
			fealtureCount = X.shape()[1];
			classList = [];
			for (key in rateDic)
			{
				classList.push(key);
				var keyX:Matrix;
				keyX = X.selectByCul(0, key, y);
				keyX = keyX.T;
				var paramList:Array;
				paramList = [];
				keyFeatureParamDic[key] = paramList;
				var i:int, len:int;
				len = fealtureCount;
				for (i = 0; i < len; i++)
				{
					var fList:Array;
					fList = keyX[i];
					var tParamO:Object;
					tParamO = {};
					tParamO.mean = DataOperation.mean(fList);
					tParamO.vari = DataOperation.calculate_variance(fList);
					paramList.push(tParamO);
				}
				
			}
		}
		
		public static const eps:Number = 1e-4;
		public function calculate_likelihood(mean:Number, vari:Number, x:Number):Number
		{
			var coeff:Number;
			coeff = 1 / Math.sqrt(2 * Math.PI * vari + eps);
			var exponent:Number;
			exponent = Math.exp( -(Math.pow(x - mean, 2) / (2 * vari + eps)));
			return coeff * exponent;
			
		}
		
		public function calculate_prior(c:Number):Number
		{
			return rateDic[c];
		}
		
		public function classify(sample:Array):Number
		{
			var posteriors:Array;
			posteriors = [];
			var i:int, len:int;
			len = classList.length;
			var fidLen:int;
			fidLen = sample.length;
			var p:Number;
			var classKey:String;
			for (i = 0; i < len; i++)
			{
				classKey = classList[i];
				p = calculate_prior(classKey);
				var keyParamList:Array;
				keyParamList = keyFeatureParamDic[classKey];
				var fid:int;
				for (fid = 0; fid < fidlLen; fid++)
				{
					var paramO:Object;
					paramO = keyParamList[i];
					p *= calculate_likelihood(paramO.mean, paramO.vari, sample[fid]);
				}
				posteriors.push(p);
				
			}
			return classList[MatrixTools.getMaxIndex(posteriors)];
			
		}
		public function predict(X:Matrix):Matrix
		{
			var i:int, len:int;
			len = X.length;
			var rst:Matrix;
			rst = new Matrix();
			for (i = 0; i < len; i++)
			{
				rst.push([classify(X[i])]);
			}
			return rst;
		}
	}

}