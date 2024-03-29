program tsfs2p18
use my_prec
implicit none

interface
function fun0(x); use my_prec; real(mp) fun0,x; end function fun0
function fun1(x); use my_prec; real(mp) fun1,x; end function fun1
end interface

character(60) sf1, sf2
character(7) sarr(4) / 'e15.7 )','e25.16)','       ','e41.34)'/
integer, parameter :: ninp=5, nres=6
integer n, i, kk
real(mp) t0, tn, ht, t, x
open(unit=ninp, file='input')
open(unit=nres, file='result', status='replace')
read(ninp,'(e15.7)') t0, tn
read(ninp,'(i15)') n; close(ninp)
write(nres, *) ' #  t0=',t0,'  tn=',tn,'   n=',n
sf1='(1x,i5,2x,e15.7,5x,e15.7,5x,'
!write(nres,*) (sarr(kk),kk=1,4)
kk=mp/4
sf2=trim(sf1)//sarr(kk)
!write(nres,*) sf2
ht=(tn-t0)/n
!write(nres,*)  ' ht=',ht
write(nres,1100)
do i=0, n
t=t0+i*ht; x=exp(-t*t); 
!write(nres,*) x; 
write(nres,trim(sf2)) i, t, fun0(x), fun1(x)
enddo
write(nres,*) fun1(0.0_mp)
close(nres)
1100 format(1x,' #',2x,'i',12x,'t',11x,'fun0',42x,'fun1')
1001 format(1x,i5,2x,e15.7,5x,e41.34,5x,e41.35)
end
