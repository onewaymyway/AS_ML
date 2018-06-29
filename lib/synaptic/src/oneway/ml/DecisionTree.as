package oneway.ml {
	import oneway.math.MatrixTools;
	
	/**
	 * ...
	 * @author ww
	 */
	public class DecisionTree {
		
		public function DecisionTree() {
		
		}
		
		public function calcShannonEnt(dataSet:Array):Number {
			var numEntries:int;
			numEntries = dataSet.length;
			var labelCounts:Object;
			labelCounts = {};
			var i:int, len:int;
			len = numEntries;
			var featVec:Array;
			var currentLabel:String;
			for (i = 0; i < len; i++) {
				featVec = dataSet[i];
				currentLabel = featVec[featVec.length - 1];
				if (!labelCounts[currentLabel])
					labelCounts[currentLabel] = 0;
				labelCounts[currentLabel] += 1;
			}
			var shannonEnt:Number;
			shannonEnt = 0;
			var key:String;
			var p:Number;
			for (key in labelCounts) {
				p = labelCounts[key] / numEntries;
				shannonEnt -= p * Math.log(p);
			}
			return shannonEnt;
		}
		
		public function splitDataSet(dataSet:Array, axis:int, value:*):Array
		{
			var retDataSet:Array;
			retDataSet = [];
			var i:int, len:int;
			len = dataSet.length;
			for (i = 0; i < len; i++)
			{
				var featVec:Array;
				featVec = dataSet[i];
				if (featVec[axis] == value)
				{
					featVec = MatrixTools.copyArr(featVec);
					featVec.splice(axis, 1);
					retDataSet.push(featVec);
				}
			}
			return retDataSet;
		}
		
		public function createDataSet():Array {
			var dataSet:Array;
			dataSet = [[1, 1, 'yes'], [1, 1, 'yes'], [1, 0, 'no'], [0, 1, 'no'], [0, 1, 'no']];
			
			return dataSet;
		}
		
		
		public function shooseBestFeatureToSplit(dataSet:Array):int
		{
			var numFeatures:Array;
			numFeatures = dataSet[0].length - 1;
			var baseEntropy:Number;
			baseEntropy = calcShannonEnt(dataSet);
			var bestInfoGain:Number;
			bestInfoGain = 0;
			var bestFeature:int;
			bestFeature = -1;
			
			var i:int, len:int;
			len = numFeatures;
			for (i = 0; i < len; i++)
			{
				var featList:Array;
				featList = MatrixTools.getColumn(i,dataSet);
				var uniqueVals:Object;
				uniqueVals = MatrixTools.listToDic(featList);
				var key:String;
				var newEnt:Number;
				newEnt = 0;
				for (key in uniqueVals)
				{
					var subDataSet:Array;
					subDataSet = splitDataSet(dataSet, i, uniqueVals[key]);
					var p:Number;
					p = subDataSet.length / dataSet.length;
					
					newEnt += p * calcShannonEnt(subDataSet);
					
				}
				var infoGain:Number;
				infoGain = baseEntropy - newEnt;
				if (infoGain > bestInfoGain)
				{
					bestInfoGain = infoGain;
					bestFeature = i;
				}
			}
			
			return bestFeature;
		}
		
		public function majorityCnt(classList:Array):*
		{
			return MatrixTools.getMaxKey(MatrixTools.listToCountDic(classList));
		}
		
		public function createTree(dataSet:Array, labels:Array):*
		{
			var classList:Array;
			classList = MatrixTools.getColumn(dataSet[0].length - 1,dataSet );
			
			if (MatrixTools.count(classList,classList[0]) == classList.length)
			{
				return classList[0];
			}
			
			if (dataSet[0].length == 1)
			{
				return majorityCnt(classList);
			}
			
			var bestFeatLabel:String;
			var bestFeat:int;
			bestFeat = shooseBestFeatureToSplit(dataSet);
			bestFeatLabel = labels[bestFeat];
			
			var myTree:Object;
			myTree = { };
			myTree[bestFeatLabel] = { };
			
			MatrixTools.removeFromList(bestFeatLabel, labels);
			
			var featValues:Array;
			featValues = MatrixTools.getColumn(bestFeat, dataSet);
			var uniqueVals:Object;
			uniqueVals = MatrixTools.listToDic(featValues);
			
			var key:String;
			var value:*;
			for (key in uniqueVals)
			{
				var subLabels:Array;
				subLabels = MatrixTools.copyArr(labels);
				value = uniqueVals[key];
				myTree[bestFeatLabel][value] = createTree(splitDataSet(dataSet, bestFeat, value), subLabels);
			}
			
			return myTree;
		}
		
		public function classify(inputTree:Object, featLabels:Array, testVec:Array):String
		{
			var firstStr:String;
			firstStr = MatrixTools.getKeys(inputTree)[0];
			var secondDic:Object;
			secondDic = inputTree[firstStr];
			var featIndex:int;
			featIndex = featLabels.indexOf(firstStr);
			var key:String;
			key = testVec[featIndex];
			
			var valueOfFeat:Object;
			valueOfFeat = secondDic[key];
			
			var classLabel:String;
			if (valueOfFeat is Object)
			{
				classLabel = classify(valueOfFeat, featLabels, testVec);
			}else
			{
				classLabel = valueOfFeat as String;
			}
			return classLabel;
		}
	
	}

}