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
	}

}