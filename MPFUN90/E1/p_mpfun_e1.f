module p_mpfun_e1 ! Модуль рассчета E_1 на многократной точности
use mpmodule      ! Пожключение модуля многократной точности
implicit none

contains

type (mp_real) function e141_mp(x)             
use mpmodule                          ! Функция e141(x) вычисляет для
implicit none                         ! аргумента (x) значение первой 
type (mp_real) x,w,g                  ! интегрально-показательной 
                                      ! функции E1(x).

call mpinit (500) ! Инициализатор параметров MPFUN (таких как точность)
                  ! Подробнее смотри в руководстве или в файле mpmod90.f

! Многократная точность позволяет уточнить постоянную Эйлера. Для сравнения с результатами
! четверной точности можно положить g таким, каким оно было задано в файле p_e1.f
 g = MPREAL('0.5772156649015328606065120900824024310421593359399235988')
!g = MPREAL('0.57721566490153286061')

! Процедура MPREAL преобразует число типа REAL в переменную типа MP_REAL
! Процедуры EXP и LOG расширены для работы с переменными типа MP_REAL
! Подробнее смотри в руководстве или в файле mpmod90.f

if (x .ge. MPREAL('5.0')) then           ! Расчёт ведется на основе известных
        w=e141c_mp(x)/x*EXP(-x)          ! разложений E1(x) в ряд по полиномам
else                                     ! Чебышева (см. книгу Люка: 
        if (x .gt. MPREAL('0.0')) then   ! Специальные математические 
                w=e141a_mp(x)-g-LOG(x)   ! функции и их аппроксимации.
        else                             ! Издательство "МИР". Москва, 1980.
        w = MPREAL('1.0')                ! стр. 112-113 (таблица 4.1).    
        endif
endif 
e141_mp=w
end function e141_mp

   
type (mp_real) function e141a_mp(x)     ! Функция e141a(x) вычисляет для заданного аргумента
use mpmodule                            ! ( 0 <= x <= 8 ) значение E1(x)+gamma+ln(x) через
implicit none                           ! разложение в ряд по смещенным полиномам Чебышева.
type (mp_real) x                        ! Коэффициенты разложения взяты из книги  Ю.Люка
type (mp_real) a(0:24)                  ! Специальные математические функции и их
type (mp_real) w,z                      ! аппроксимации. Издательство "МИР". Москва, 1980.
type (mp_real) b0, b1, b2               !                          стр. 112 (таблица 4.1).
integer  i                       

call mpinit (500)

a(0)  = MPREAL(' 1.67391435474272057853')
a(1)  = MPREAL(' 1.22849447854715595018') 
a(2)  = MPREAL('-0.31786989829837361369')          ! Здесь:
a(3)  = MPREAL(' 0.09274603919729219112')          !     E1(x) - первая интегрально-
a(4)  = MPREAL('-0.02602736316900119930')          !             показательная
a(5)  = MPREAL(' 0.00674815309464228057')          !             функция;
a(6)  = MPREAL('-0.00159897068934225285')          ! gamma - постоянная Эйлера
a(7)  = MPREAL(' 0.00034594453880095403')
a(8)  = MPREAL('-0.00006853652682011094')          
a(9)  = MPREAL(' 0.00001248593239173701')
a(10) = MPREAL('-0.00000210134463871704')
a(11) = MPREAL(' 0.00000032818447981081')
a(12) = MPREAL('-0.00000004776878645154')
a(13) = MPREAL(' 0.00000000650581688192')
a(14) = MPREAL('-0.00000000083210193692')
a(15) = MPREAL(' 0.00000000010028101125')
a(16) = MPREAL('-0.00000000001142229304')
a(17) = MPREAL(' 0.00000000000123307945')
a(18) = MPREAL('-0.00000000000012648523')
a(19) = MPREAL(' 0.00000000000001235706')
a(20) = MPREAL('-0.00000000000000115226')
a(21) = MPREAL(' 0.00000000000000010276')
a(22) = MPREAL('-0.00000000000000000878')
a(23) = MPREAL(' 0.00000000000000000072')
a(24) = MPREAL('-0.00000000000000000006')

w=MPREAL('0.125')*x
z=MPREAL('4.0')*w-MPREAL('2.0')
b0=MPREAL('0.0')
b1=MPREAL('0.0')

do i=24, 0, -1
        b2=b1
        b1=b0
        b0=z*b1-b2+a(i)
enddo

e141a_mp=b0-b1*z/MPREAL('2.0')

end function e141a_mp


type (mp_real) function e141c_mp(x)  ! Функция e141c(x) вычисляет для заданного аргумента
use mpmodule                         ! ( x >= 5 ) значение выражения E1(x)*exp(x)*x через
implicit none                        ! его разложение в ряд по смещённым полиномам Чебышева.
type (mp_real) x                     ! Коэффициенты разложения взяты из книги 
type (mp_real) c(0:30)               ! Ю.Люка  Специальные математические функции и их
type (mp_real) w,z                   ! аппроксимации. Издательство "МИР". Москва, 1980.
type (mp_real) b0,b1,b2              !                          стр. 112-113 (таблица 4.1 (c)). 
integer i                           

call mpinit (500)

c(0)  = MPREAL(' 0.92078514445389391645')
c(1)  = MPREAL('-0.07343411783162128775')
c(2)  = MPREAL(' 0.00520981196727232977')
c(3)  = MPREAL('-0.00050214071989599012')
c(4)  = MPREAL(' 0.00005920796937926337')
c(5)  = MPREAL('-0.00000808564513097880')
c(6)  = MPREAL(' 0.00000123720385647926')
c(7)  = MPREAL('-0.00000020750176860703')
c(8)  = MPREAL(' 0.00000003756005474022')
c(9)  = MPREAL('-0.00000000725410976004')
c(10) = MPREAL(' 0.00000000148181601182')
c(11) = MPREAL('-0.00000000031795682863')
c(12) = MPREAL(' 0.00000000007126935828')
c(13) = MPREAL('-0.00000000001661231319')
c(14) = MPREAL(' 0.00000000000401155069')
c(15) = MPREAL('-0.00000000000100038792')
c(16) = MPREAL(' 0.00000000000025693341')
c(17) = MPREAL('-0.00000000000006780374')
c(18) = MPREAL(' 0.00000000000001834785')
c(19) = MPREAL('-0.00000000000000508209')
c(20) = MPREAL(' 0.00000000000000143861')
c(21) = MPREAL('-0.00000000000000041560')
c(22) = MPREAL(' 0.00000000000000012238')
c(23) = MPREAL('-0.00000000000000003669')
c(24) = MPREAL(' 0.00000000000000001119')
c(25) = MPREAL('-0.00000000000000000347')
c(26) = MPREAL(' 0.00000000000000000109')
c(27) = MPREAL('-0.00000000000000000035')
c(28) = MPREAL(' 0.00000000000000000011')
c(29) = MPREAL('-0.00000000000000000004')
c(30) = MPREAL(' 0.00000000000000000001')
 
w=MPREAL('5.0')/x
z=MPREAL('4.0')*w-MPREAL('2.0')
b0=MPREAL('0.0')
b1=MPREAL('0.0')

do i=30, 0, -1
        b2=b1
        b1=b0
        b0=z*b1-b2+c(i)
enddo

e141c_mp=b0-b1*z/MPREAL('2.0')

end function e141c_mp

end module p_mpfun_e1