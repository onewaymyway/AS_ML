package oneway.supervised.regression 
{
	import oneway.math.Matrix;
	
	/**
	 * ...
	 * @author ww
	 */
	public interface IRegularization 
	{
		function __call__(w:Matrix):*;
		function grad(w:Matrix):*;
	}
	
}