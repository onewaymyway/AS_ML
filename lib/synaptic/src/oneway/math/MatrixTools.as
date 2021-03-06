package oneway.math 
{
	/**
	 * ...
	 * @author ww
	 */
	public class MatrixTools 
	{
		
		public function MatrixTools() 
		{
			
		}
		
		public static function getColumn(column:int, mt:Array):Array
		{
			var rst:Array;
			rst = [];
			var i:int, len:int;
			len = mt.length;
			for (i = 0; i < len; i++)
			{
				rst.push(mt[i][column]);
			}
			return rst;
		}
		
		public static function listToDic(list:Array):Object
		{
			var rst:Object;
			rst = { };
			var i:int, len:int;
			len = list.length;
			for (i = 0; i < len; i++)
			{
				rst[list[i]] = list[i];
			}
			return rst;
		}
		
		public static function listToCountDic(list:Array):Object
		{
			var rst:Object;
			rst = { };
			var i:int, len:int;
			len = list.length;
			var tKey:String;
			for (i = 0; i < len; i++)
			{
				tKey = list[i];
				if (!rst[tKey]) rst[tKey]=0;
				rst[tKey] += 1;
			}
			return rst;
		}
		
		public static function listToKeyRateDic(list:Array):Object
		{
			var allCount:int;
			allCount = list.length;
			var countDic:Object;
			countDic = listToCountDic(list);
			for (var key:String in countDic)
			{
				countDic[key] = countDic[key] / allCount;
			}
			return countDic;
		}
		public static function getMaxIndex(list:Array):int
		{
			var rst:int =-1;
			var max:Number;
			if (list.length < 1) return rst;
			var i:int, len:int;
			max = list[i];
			rst = 0;
			for (i = 1; i < len; i++)
			{
				if (list[i] > max)
				{
					max = list[i];
					rst = i;
				}
			}
			return rst;
		}
		public static function getMaxKey(dic:Object):String
		{
			var key:String;
			var max:Number = 0;
			var tMaxKey:String;
			var tValue:Number;
			for (key in dic)
			{
				tValue = dic[key];
				if (tValue > max)
				{
					max = tValue;
					tMaxKey = key;
				}
			}
			return tMaxKey;
		}
		
		public static function count(list:Array,value:*):int
		{
			var rst:int;
			rst = 0;
			var i:int, len:int;
			len = list.length;
			for (i = 0; i < len; i++)
			{
				if (list[i] == value) rst++;
			}
			return rst;
		}
		
		public static function removeFromList(value:*,list:Array ):void
		{
			var i:int, len:int;
			len = list.length;
			for (i = len - 1; i >= 0; i--)
			{
				if (list[i] == value) list.splice(i, 1);
			}
		}
		
		public static function copyArr(arr:Array):Array
		{
			var rst:Array;
			rst=[];
			var i:int,len:int;
			len=arr.length;
			for(i=0;i<len;i++)
			{
				rst.push(arr[i]);
			}
			return rst;
		}
		public static function concatArr(src:Array, a:Array):Array {
			if (!a) return src;
			if (!src) return a;
			var i:int, len:int = a.length;
			for (i = 0; i < len; i++) {
				src.push(a[i]);
			}
			return src;
		}
		
		public static function getKeys(obj:Object):Array
		{
			var rst:Array;
			var key:String;
			rst = [];
			for (key in obj)
			{
				rst.push(key);
			}
			return rst;
		}
		
		public static function shuffle(o:Array):void
		{
			for (var j:int, x:int, i:int = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x) {
			}
		}
		
		public static function range(len:int):Array
		{
			var i:int;
			var rst:Array = [];
			for (i = 0; i < len; i++)
			{
				rst.push(i);
			}
			return rst;
		}
		
		public static function createArr(len:int, value:Number):Array
		{
			var i:int;
			var rst:Array = [];
			for (i = 0; i < len; i++)
			{
				rst.push(value);
			}
			return rst;
		}
		
		public static function getByIndexs(o:Array, indexs:Array):Array
		{
			var i:int, len:int;
			len = indexs.length;
			var rst:Array;
			rst = [];
			for (i = 0; i < len; i++)
			{
				rst[i] = o[indexs[i]];
			}
			return rst;
		}
		
		public static function shape(o:Array):Array
		{
			var rst:Array;
			rst = [];
			while (o && o is Array)
			{
				rst.push(o.length);
				o = o[0];
			}
			return rst;
		}
		
		public static function expandArr(o:Array):Array
		{
			var rst:Array;
			rst = [];
			var i:int, len:int;
			len = o.length;
			for (i = 0; i < len; i++)
			{
				rst.push([o[i]]);
			}
			return rst;
		}
		
		public static function appendMat(mt0:Array, mt1:Array):Array
		{
			
		}
	}

}