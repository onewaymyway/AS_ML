package oneway.supervised.regression 
{
	import oneway.math.Matrix;
	/**
	 * ...
	 * @author ww
	 */
	public class Regression 
	{
		public var n_iterations:int;
		public var learning_rate:Number;
		public var w:Matrix;
		public var regularization:IRegularization;
		public var transformFun:Function;
		public var transformDirSame:Boolean = true;
		public function Regression(n_itrations:int,learning_rate:Number) 
		{
			this.n_iterations = n_iterations;
			this.learning_rate = learning_rate;
		}
		
		
		public function initialize_weights(n_features:int):void
		{
			var limit:Number;
			limit = 1 / Math.sqrt(n_features);
			this.w = new Matrix();
			this.w.makeShape(n_features, 1);
			this.w.fillByRandom( -limit, limit);
		}
		
		public function getPredValue(X:Matrix):Matrix
		{
			var rst:Matrix;
			rst = X.dot(this.w);
			if (transformFun != null)
			{
				return rst.applyFunction(transformFun);
			}
			return rst;
		}
		public function fit(X:Matrix, y:Matrix):void
		{
			//add bias w=1
			X = X.clone().insertCulByNum(0, 1);
			this.initialize_weights(X.shape()[1]);
			var i:int, len:int;
			len = n_iterations;
			for (i = 0; i < len; i++)
			{
				var y_pred:Matrix;
				y_pred = getPredValue(X);
				var grad_w:Matrix;
				//grad_w=X.T*(y_pred-y)+rg.grad(this.w)
				grad_w = X.T.dot(y_pred.sub(y)).add(this.regularization.grad(this.w));
				
				//this.w=this.w-alpha*grad_w
				if (transformDirSame)
				{
					this.w = this.w.sub(grad_w.multiply(this.learning_rate));
				}else
				{
					this.w = this.w.add(grad_w.multiply(this.learning_rate));
				}
				
			}
		}
		
		public function predict(X:Matrix):Matrix
		{
			X = X.clone().insertCulByNum(0, 1);
			var y_pred:Matrix = getPredValue(X);
			return y_pred;
		}
	}

}