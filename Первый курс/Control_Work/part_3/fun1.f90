function fun1(x)
implicit none
real(16) fun1, x
fun1=1.0/(1.7**2.0+1.7*(1.7**3-x)**(1.0/3)+(1.7**3-x)**(2.0/3))
end
