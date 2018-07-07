package oneway.math 
{
	/**
	 * ...
	 * @author ww
	 */
	public class Matrix extends Array
	{
		
		public function Matrix(line:int=0,cul:int=0) 
		{
			if (line > 0 && cul > 0)
			{
				makeShape();
			}
		}
		
		public function makeShape(line:int, cul:int):void
		{
			var i:int, len:int;
			len = line;
			this.length = len;
			for (i = 0; i < len; i++)
			{
				this[i] = MatrixTools.createArr(cul, 0);
			}
		}
		public function initByArray(arr:Array):void
		{
			var i:int, len:int;
			len = arr.length;
			this.length = len;
			for (i = 0; i < len; i++)
			{
				this[i] = arr[i];
			}
		}
		public function shape():Array
		{
			return MatrixTools.shape(this);
		}
		
		public function get T():Matrix
		{
			var rst:Matrix;
			rst = new Matrix();
			var shape:Array;
			shape = this.shape();
			var i:int, len:int;
			len = shape[1];
			rst.length = 0;
			for (i = 0; i < len; i++)
			{
				rst.push(MatrixTools.getColumn(i, rst));
			}
			return rst;
		}
		
		public function dot(mat:Matrix):Matrix
		{
			var line:int, lenLine:int;
			var cul:int, lenCul:int;
			var shapeI:Array;
			var shapeO:Array;
			shapeI = this.shape();
			shapeO = mat.shape();
			lenLine = shapeI[0];
			lenCul = shapeO[1];
			var rst:Matrix;
			rst = new Matrix();
			var i:int,len:int;
			len = shapeI[1];
			var sum:Number;
			rst.length = lenLine;
			var tArr:Array;
			
			for (line = 0; line < lenLine; line++)
			{
				tArr = [];
				tArr.length = lenCul;
				rst[line] = tArr;
				for (cul = 0; cum < lenCul; cul++)
				{
					sum = 0;
					for (i = 0; i < len; i++)
					{
						sum += this[line][i] * mat[i][cul];
					}
					tArr[cul] = sum;
				}
			}
			return rst;
		}
		
		public function multiply(num:Number,createNew:Boolean=false):Matrix
		{
			function multiplyfun(value:Number):Number
			{
				return value * num;
			}
			applyFunction(multiplyfun,createNew);
			return this;
		}
		
		public function sub(mat:Matrix,createNew:Boolean=true):Matrix
		{
			function subFun(value:Number, i:int, j:int):Number
			{
				return value-mat[i][j];
			}
			return applyFunction(subFun, createNew);
		}
		
		public function add(mat:Matrix,createNew:Boolean=true):Matrix
		{
			function subFun(value:Number, i:int, j:int):Number
			{
				return value+mat[i][j];
			}
			return applyFunction(subFun, createNew);
		}
		
		public function fillByNum(num:Number):Matrix
		{
			function fillFun():Number
			{
				return num;
			}
			return applyFunction(fillFun);
		}
		
		public function fillByRandom(min:Number=-1, max:Number=1):Matrix
		{
			function fillRandomFun():Number
			{
				return min + Math.random() * (max-min);
			}
			return applyFunction(fillRandomFun);
		}
		
		
		public function insertCulByNum(cul:int, num:Number):Matrix
		{
			var tar:Matrix;
			tar = this;
			var tArr:Array;
			var i:int, len:int;
			len = tar.length;
			for (i = 0; i < len; i++)
			{
				tArr = tar[i];
				tArr.splice(cul, 0, num);
			}
			return tar;
		}
		
		public function clone():Matrix
		{
			return applyFunction(MathFuns.cloneValue, true);
		}
		
		public function cloneTo(to:Matrix):Matrix
		{
			return applyFunction(MathFuns.cloneValue, false, to);
		}
		
		public function selectByCul(cul:int, value:*,selector:Matrix=null):Matrix
		{
			if (!selector) selector = this;
			var i:int, len:int;
			var rst:Matrix;
			rst = new Matrix();
			len = this.length;
			for (i = 0; i < len; i++)
			{
				if (selector[i][cul] == value)
				{
					rst.push(MatrixTools.copyArr(this[i]));
				}
			}
			return rst;
		}
		public function applyFunction(fun:Function,createNew:Boolean=false,tar:Matrix=null,dataMat:Matrix=null):Matrix
		{
			
			if (!dataMat) dataMat = this;
			var i:int, iLen:int;
			var j:int, jLen:int;
			var tArr:Array;
			var shape:Array;
			shape = dataMat.shape();
			iLen = shape[0];
			jLen = shape[1];
			if (!tar) tar = this;
			var tar:Matrix;
			if (createNew)
			{
				tar = new Matrix(iLen, jLen);
			}
			for (i = 0; i < iLen; i++)
			{
				for (j = 0; j < jLen; j++)
				{
					tar[i][j] = fun(dataMat[i][j],i,j);
				}
			}
			return tar;
		}
	}

}