var window = window || global;
var document = document || (window.document = {});
/***********************************/
/*http://www.layabox.com 2017/01/16*/
/***********************************/
var Laya=window.Laya=(function(window,document){
	var Laya={
		__internals:[],
		__packages:{},
		__classmap:{'Object':Object,'Function':Function,'Array':Array,'String':String},
		__sysClass:{'object':'Object','array':'Array','string':'String','dictionary':'Dictionary'},
		__propun:{writable: true,enumerable: false,configurable: true},
		__presubstr:String.prototype.substr,
		__substr:function(ofs,sz){return arguments.length==1?Laya.__presubstr.call(this,ofs):Laya.__presubstr.call(this,ofs,sz>0?sz:(this.length+sz));},
		__init:function(_classs){_classs.forEach(function(o){o.__init$ && o.__init$();});},
		__isClass:function(o){return o && (o.__isclass || o==Object || o==String || o==Array);},
		__newvec:function(sz,value){
			var d=[];
			d.length=sz;
			for(var i=0;i<sz;i++) d[i]=value;
			return d;
		},
		__extend:function(d,b){
			for (var p in b){
				if (!b.hasOwnProperty(p)) continue;
				var gs=Object.getOwnPropertyDescriptor(b, p);
				var g = gs.get, s = gs.set; 
				if ( g || s ) {
					if ( g && s)
						Object.defineProperty(d,p,gs);
					else{
						g && Object.defineProperty(d, p, g);
						s && Object.defineProperty(d, p, s);
					}
				}
				else d[p] = b[p];
			}
			function __() { Laya.un(this,'constructor',d); }__.prototype=b.prototype;d.prototype=new __();Laya.un(d.prototype,'__imps',Laya.__copy({},b.prototype.__imps));
		},
		__copy:function(dec,src){
			if(!src) return null;
			dec=dec||{};
			for(var i in src) dec[i]=src[i];
			return dec;
		},
		__package:function(name,o){
			if(Laya.__packages[name]) return;
			Laya.__packages[name]=true;
			var p=window,strs=name.split('.');
			if(strs.length>1){
				for(var i=0,sz=strs.length-1;i<sz;i++){
					var c=p[strs[i]];
					p=c?c:(p[strs[i]]={});
				}
			}
			p[strs[strs.length-1]] || (p[strs[strs.length-1]]=o||{});
		},
		__hasOwnProperty:function(name,o){
			o=o ||this;
		    function classHas(name,o){
				if(Object.hasOwnProperty.call(o.prototype,name)) return true;
				var s=o.prototype.__super;
				return s==null?null:classHas(name,s);
			}
			return (Object.hasOwnProperty.call(o,name)) || classHas(name,o.__class);
		},
		__typeof:function(o,value){
			if(!o || !value) return false;
			if(value===String) return (typeof o==='string');
			if(value===Number) return (typeof o==='number');
			if(value.__interface__) value=value.__interface__;
			else if(typeof value!='string')  return (o instanceof value);
			return (o.__imps && o.__imps[value]) || (o.__class==value);
		},
		__as:function(value,type){
			return (this.__typeof(value,type))?value:null;
		},		
		interface:function(name,_super){
			Laya.__package(name,{});
			var ins=Laya.__internals;
			var a=ins[name]=ins[name] || {self:name};
			if(_super)
			{
				var supers=_super.split(',');
				a.extend=[];
				for(var i=0;i<supers.length;i++){
					var nm=supers[i];
					ins[nm]=ins[nm] || {self:nm};
					a.extend.push(ins[nm]);
				}
			}
			var o=window,words=name.split('.');
			for(var i=0;i<words.length-1;i++) o=o[words[i]];
			o[words[words.length-1]]={__interface__:name};
		},
		class:function(o,fullName,_super,miniName){
			_super && Laya.__extend(o,_super);
			if(fullName){
				Laya.__package(fullName,o);
				Laya.__classmap[fullName]=o;
				if(fullName.indexOf('.')>0){
					if(fullName.indexOf('laya.')==0){
						var paths=fullName.split('.');
						miniName=miniName || paths[paths.length-1];
						if(Laya[miniName]) console.log("Warning!,this class["+miniName+"] already exist:",Laya[miniName]);
						Laya[miniName]=o;
					}
				}
				else {
					if(fullName=="Main")
						window.Main=o;
					else{
						if(Laya[fullName]){
							console.log("Error!,this class["+fullName+"] already exist:",Laya[fullName]);
						}
						Laya[fullName]=o;
					}
				}
			}
			var un=Laya.un,p=o.prototype;
			un(p,'hasOwnProperty',Laya.__hasOwnProperty);
			un(p,'__class',o);
			un(p,'__super',_super);
			un(p,'__className',fullName);
			un(o,'__super',_super);
			un(o,'__className',fullName);
			un(o,'__isclass',true);
			un(o,'super',function(o){this.__super.call(o);});
		},
		imps:function(dec,src){
			if(!src) return null;
			var d=dec.__imps|| Laya.un(dec,'__imps',{});
			function __(name){
				var c,exs;
				if(! (c=Laya.__internals[name]) ) return;
				d[name]=true;
				if(!(exs=c.extend)) return;
				for(var i=0;i<exs.length;i++){
					__(exs[i].self);
				}
			}
			for(var i in src) __(i);
		},
		getset:function(isStatic,o,name,getfn,setfn){
			if(!isStatic){
				getfn && Laya.un(o,'_$get_'+name,getfn);
				setfn && Laya.un(o,'_$set_'+name,setfn);
			}
			else{
				getfn && (o['_$GET_'+name]=getfn);
				setfn && (o['_$SET_'+name]=setfn);
			}
			if(getfn && setfn) 
				Object.defineProperty(o,name,{get:getfn,set:setfn,enumerable:false});
			else{
				getfn && Object.defineProperty(o,name,{get:getfn,enumerable:false});
				setfn && Object.defineProperty(o,name,{set:setfn,enumerable:false});
			}
		},
		static:function(_class,def){
				for(var i=0,sz=def.length;i<sz;i+=2){
					if(def[i]=='length') 
						_class.length=def[i+1].call(_class);
					else{
						function tmp(){
							var name=def[i];
							var getfn=def[i+1];
							Object.defineProperty(_class,name,{
								get:function(){delete this[name];return this[name]=getfn.call(this);},
								set:function(v){delete this[name];this[name]=v;},enumerable: true,configurable: true});
						}
						tmp();
					}
				}
		},		
		un:function(obj,name,value){
			value || (value=obj[name]);
			Laya.__propun.value=value;
			Object.defineProperty(obj, name, Laya.__propun);
			return value;
		},
		uns:function(obj,names){
			names.forEach(function(o){Laya.un(obj,o)});
		}
	};

	window.console=window.console || ({log:function(){}});
	window.trace=window.console.log;
	Error.prototype.throwError=function(){throw arguments;};
	String.prototype.substr=Laya.__substr;
	Object.defineProperty(Array.prototype,'fixed',{enumerable: false});

	return Laya;
})(window,document);

(function(window,document,Laya){
	var __un=Laya.un,__uns=Laya.uns,__static=Laya.static,__class=Laya.class,__getset=Laya.getset,__newvec=Laya.__newvec;
	/**
	*...
	*@author ww
	*/
	//class Test
	var Test=(function(){
		function Test(){
			this.test();
		}

		__class(Test,'Test');
		var __proto=Test.prototype;
		__proto.test=function(){
			var dt;
			dt=new DecisionTree();
			var dataSet;
			dataSet=[[1,1,'yes'],[1,1,'yes'],[1,0,'no'],[0,1,'no'],[0,1,'no']];
			var labels=['no surfacing','flippers'];
			var ent=NaN;
			ent=dt.calcShannonEnt(dataSet);
			console.log("ent:",ent);
			var myTree;
			myTree=dt.createTree(dataSet,MatrixTools.copyArr(labels));
			console.log(myTree);
			var rst;
			rst=dt.classify(myTree,labels,[1,1]);
			console.log(rst);
		}

		return Test;
	})()


	/**
	*...
	*@author ww
	*/
	//class oneway.math.MatrixTools
	var MatrixTools=(function(){
		function MatrixTools(){}
		__class(MatrixTools,'oneway.math.MatrixTools');
		MatrixTools.getColumn=function(column,mt){
			var rst;
			rst=[];
			var i=0,len=0;
			len=mt.length;
			for (i=0;i < len;i++){
				rst.push(mt[i][column]);
			}
			return rst;
		}

		MatrixTools.listToDic=function(list){
			var rst;
			rst={};
			var i=0,len=0;
			len=list.length;
			for (i=0;i < len;i++){
				rst[list[i]]=list[i];
			}
			return rst;
		}

		MatrixTools.listToCountDic=function(list){
			var rst;
			rst={};
			var i=0,len=0;
			len=list.length;
			var tKey;
			for (i=0;i < len;i++){
				tKey=list[i];
				if (!rst[tKey])rst[tKey]=0;
				rst[tKey]+=1;
			}
			return rst;
		}

		MatrixTools.getMaxKey=function(dic){
			var key;
			var max=0;
			var tMaxKey;
			var tValue=NaN;
			for (key in dic){
				tValue=dic[key];
				if (tValue > max){
					max=tValue;
					tMaxKey=key;
				}
			}
			return tMaxKey;
		}

		MatrixTools.count=function(list,value){
			var rst=0;
			rst=0;
			var i=0,len=0;
			len=list.length;
			for (i=0;i < len;i++){
				if (list[i]==value)rst++;
			}
			return rst;
		}

		MatrixTools.removeFromList=function(value,list){
			var i=0,len=0;
			len=list.length;
			for (i=len-1;i >=0;i--){
				if (list[i]==value)list.splice(i,1);
			}
		}

		MatrixTools.copyArr=function(arr){
			var rst;
			rst=[];
			var i=0,len=0;
			len=arr.length;
			for(i=0;i<len;i++){
				rst.push(arr[i]);
			}
			return rst;
		}

		MatrixTools.concatArr=function(src,a){
			if (!a)return src;
			if (!src)return a;
			var i=0,len=a.length;
			for (i=0;i < len;i++){
				src.push(a[i]);
			}
			return src;
		}

		MatrixTools.getKeys=function(obj){
			var rst;
			var key;
			rst=[];
			for (key in obj){
				rst.push(key);
			}
			return rst;
		}

		return MatrixTools;
	})()


	/**
	*...
	*@author ww
	*/
	//class oneway.ml.DecisionTree
	var DecisionTree=(function(){
		function DecisionTree(){}
		__class(DecisionTree,'oneway.ml.DecisionTree');
		var __proto=DecisionTree.prototype;
		__proto.calcShannonEnt=function(dataSet){
			var numEntries=0;
			numEntries=dataSet.length;
			var labelCounts;
			labelCounts={};
			var i=0,len=0;
			len=numEntries;
			var featVec;
			var currentLabel;
			for (i=0;i < len;i++){
				featVec=dataSet[i];
				currentLabel=featVec[featVec.length-1];
				if (!labelCounts[currentLabel])
					labelCounts[currentLabel]=0;
				labelCounts[currentLabel]+=1;
			};
			var shannonEnt=NaN;
			shannonEnt=0;
			var key;
			var p=NaN;
			for (key in labelCounts){
				p=labelCounts[key] / numEntries;
				shannonEnt-=p *Math.log(p);
			}
			return shannonEnt;
		}

		__proto.splitDataSet=function(dataSet,axis,value){
			var retDataSet;
			retDataSet=[];
			var i=0,len=0;
			len=dataSet.length;
			for (i=0;i < len;i++){
				var featVec;
				featVec=dataSet[i];
				if (featVec[axis]==value){
					featVec=MatrixTools.copyArr(featVec);
					featVec.splice(axis,1);
					retDataSet.push(featVec);
				}
			}
			return retDataSet;
		}

		__proto.createDataSet=function(){
			var dataSet;
			dataSet=[[1,1,'yes'],[1,1,'yes'],[1,0,'no'],[0,1,'no'],[0,1,'no']];
			return dataSet;
		}

		__proto.shooseBestFeatureToSplit=function(dataSet){
			var numFeatures;
			numFeatures=dataSet[0].length-1;
			var baseEntropy=NaN;
			baseEntropy=this.calcShannonEnt(dataSet);
			var bestInfoGain=NaN;
			bestInfoGain=0;
			var bestFeature=0;
			bestFeature=-1;
			var i=0,len=0;
			len=numFeatures;
			for (i=0;i < len;i++){
				var featList;
				featList=MatrixTools.getColumn(i,dataSet);
				var uniqueVals;
				uniqueVals=MatrixTools.listToDic(featList);
				var key;
				var newEnt=NaN;
				newEnt=0;
				for (key in uniqueVals){
					var subDataSet;
					subDataSet=this.splitDataSet(dataSet,i,uniqueVals[key]);
					var p=NaN;
					p=subDataSet.length / dataSet.length;
					newEnt+=p *this.calcShannonEnt(subDataSet);
				};
				var infoGain=NaN;
				infoGain=baseEntropy-newEnt;
				if (infoGain > bestInfoGain){
					bestInfoGain=infoGain;
					bestFeature=i;
				}
			}
			return bestFeature;
		}

		__proto.majorityCnt=function(classList){
			return MatrixTools.getMaxKey(MatrixTools.listToCountDic(classList));
		}

		__proto.createTree=function(dataSet,labels){
			var classList;
			classList=MatrixTools.getColumn(dataSet[0].length-1,dataSet);
			if (MatrixTools.count(classList,classList[0])==classList.length){
				return classList[0];
			}
			if (dataSet[0].length==1){
				return this.majorityCnt(classList);
			};
			var bestFeatLabel;
			var bestFeat=0;
			bestFeat=this.shooseBestFeatureToSplit(dataSet);
			bestFeatLabel=labels[bestFeat];
			var myTree;
			myTree={};
			myTree[bestFeatLabel]={};
			MatrixTools.removeFromList(bestFeatLabel,labels);
			var featValues;
			featValues=MatrixTools.getColumn(bestFeat,dataSet);
			var uniqueVals;
			uniqueVals=MatrixTools.listToDic(featValues);
			var key;
			var value;
			for (key in uniqueVals){
				var subLabels;
				subLabels=MatrixTools.copyArr(labels);
				value=uniqueVals[key];
				myTree[bestFeatLabel][value]=this.createTree(this.splitDataSet(dataSet,bestFeat,value),subLabels);
			}
			return myTree;
		}

		__proto.classify=function(inputTree,featLabels,testVec){
			var firstStr;
			firstStr=MatrixTools.getKeys(inputTree)[0];
			var secondDic;
			secondDic=inputTree[firstStr];
			var featIndex=0;
			featIndex=featLabels.indexOf(firstStr);
			var key;
			key=testVec[featIndex];
			var valueOfFeat;
			valueOfFeat=secondDic[key];
			var classLabel;
			if ((typeof valueOfFeat=='object')){
				classLabel=this.classify(valueOfFeat,featLabels,testVec);
				}else{
				classLabel=valueOfFeat;
			}
			return classLabel;
		}

		return DecisionTree;
	})()



	new Test();

})(window,document,Laya);
