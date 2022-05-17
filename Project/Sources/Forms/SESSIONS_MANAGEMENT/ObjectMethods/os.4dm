var $order : Integer
var $o : Object

$order:=OBJECT Get value:C1743("osHeader")
$order:=$order=2 ? 1 : 1+Num:C11($order#0)
Form:C1466.sessions:=Form:C1466.sessions.orderBy("device.os "+($order=1 ? "asc" : "desc"))

For each ($o; Form:C1466.sorts)
	
	OBJECT SET VALUE:C1742($o.header; $order*Num:C11($o.header="osHeader"))
	
End for each 

return -1