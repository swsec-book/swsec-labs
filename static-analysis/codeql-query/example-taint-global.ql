/** 
 * @kind path-problem
 * @id java/my-taint-propagation
 * @precision high
 * @security-severity 9.9
 * @problem.severity error
**/

import java
import semmle.code.java.dataflow.TaintTracking

module MyTaintConfig implements DataFlow::ConfigSig {

	predicate isSource(DataFlow::Node source) {
		exists(MethodCall a | 
			a.getMethod().getName() = "mySource" and
			a.getMethod().getDeclaringType().getName() = "MyClassA" and
			source.asExpr() = a
		)
	}

	predicate isSink(DataFlow::Node sink) {
		exists(MethodCall b, VarAccess arg |
			b.getMethod().getName() = "mySink" and
			b.getMethod().getDeclaringType().getName() = "MyClassB" and
			arg = b.getAnArgument() and
			sink.asExpr() = arg
		)
	}
  
}

module MyTaint = TaintTracking::Global<MyTaintConfig>;

import MyTaint::PathGraph

from MyTaint::PathNode source, MyTaint::PathNode sink
where MyTaint::flowPath(source, sink) 
select sink.getNode(), source, sink, "Taint propagation found"