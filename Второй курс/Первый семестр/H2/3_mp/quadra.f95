module quadr
use real_type
implicit none

real(mp), private :: h, x, summa, summa_ch, summa_nech
integer, private :: i

contains

function quadra(fqua,f,a,b,n) result(i)
use real_type
implicit none
real(mp) fqua, i
real(mp), external :: f
integer n                                
real(mp) a, b

i=fqua(f,a,b,n)

end function quadra

function rectan(f,a,b,n) result(integral)
use real_type
implicit none
real(mp) f, a, b, integral
integer n  

h=(b-a)/n

summa=0
do i=1, n, 1
        x=a+(i-0.5)*h
        summa=summa+f(x)
enddo

integral=h*summa

end function rectan

!-----------

function trap(f,a,b,n) result(integral)
use real_type
implicit none
real(mp) f, a, b, integral
integer n

h=(b-a)/n

summa=(f(a)+f(b))/2
do i=2, n, 1
        x=a+(i-1)*h
        summa=summa+f(x)
enddo

integral=h*summa

end function trap

!-----------

function sim(f,a,b,n) result(integral)
use real_type
implicit none
real(mp) f, a, b, integral
integer n

h=(b-a)/n

summa_ch=0
do i=2, n, 2
        x=a+(i-1)*h
        summa_ch=summa_ch+f(x)
enddo

summa_nech=0
do i=3, n-1, 2
        x=a+(i-1)*h
        summa_nech=summa_nech+f(x)
enddo

summa=f(a)+f(b)+4*summa_ch+2*summa_nech

integral=(h/3)*summa

end function sim

end module quadr
