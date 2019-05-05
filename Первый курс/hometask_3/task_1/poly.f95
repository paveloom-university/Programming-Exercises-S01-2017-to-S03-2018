module poly
implicit none
contains
subroutine pol(x,p,n,w3)
integer n,i
real p(0:n),x,w3,w1,w2,x2
i=2;w1=p(0); x2=x*x;
 if (n.eq.0) then; w3=p(0); return; endif
 if (n.eq.1) then; w3=p(1)+p(0)*x; return; endif
 if (n>1) then
    do while (i<=n)
             w1=w1*x2+p(i)
             i=i+2
    enddo
 w2=p(1); i=3;
    do while (i<=n)
             w2=w2*x2+p(i)
             i=i+2
    enddo
    if (mod(n,2).eq.0) then; w3=w1+x*w2;
                       else; w3=w1*x+w2;
    endif
    endif
end subroutine
end module
