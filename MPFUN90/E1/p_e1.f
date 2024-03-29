module p_e1      ! Модуль рассчёта E_1 на четверной точности
implicit none

contains

real(16) function e141_r16(x)           ! Функция e141(x) вычисляет для 
implicit none                           ! аргумента (x) значение первой 
real(16) x,w,g                          ! интегрально-показательной 
data g /.57721566490153286061_16 /      ! функции E1(x).
if (x .ge. 5.0_16) then                 ! Расчёт ведется на основе известных
        w=e141c_r16(x)/x*exp(-x)        ! разложений E1(x) в ряд по полиномам
else                                    ! Чебышева (см. книгу Люка: 
        if (x .gt. 0.0_16) then         ! Специальные математические 
                w=e141a_r16(x)-g-log(x) !  функции и их аппроксимации.
        else                            ! Издательство "МИР". Москва, 1980.
        w=1.0_16                        ! стр. 112-113 (таблица 4.1).    
        endif
endif 
e141_r16=w
end function e141_r16

real(16) function e141a_r16(x)        ! Функция e141a(x) вычисляет для заданного аргумента
implicit none                         ! ( 0 <= x <= 8 ) значение E1(x)+gamma+ln(x) через
real(16) x                            ! разложение в ряд по смещенным полиномам Чебышева.
real(16) a(0:24)                      ! Коэффициенты разложения взяты из книги  Ю.Люка
real(16) w,z                          ! Специальные математические функции и их
real(16) b0, b1, b2                   ! аппроксимации. Издательство "МИР". Москва, 1980.
integer  i                            !                          стр. 112 (таблица 4.1).

data a / 1.67391435474272057853_16, &
      &  1.22849447854715595018_16, & ! Здесь:
      & -0.31786989829837361369_16, & !     E1(x) - первая интегрально-
      &  0.09274603919729219112_16, & !             показательная     
      & -0.02602736316900119930_16, & !             функция;
      &  0.00674815309464228057_16, &
      & -0.00159897068934225285_16, & ! gamma=0.57721566490153286061 
      &  0.00034594453880095403_16, & ! (постоянная Эйлера)
      & -0.00006853652682011094_16, &
      &  0.00001248593239173701_16, &
      & -0.00000210134463871704_16, &
      &  0.00000032818447981081_16, &
      & -0.00000004776878645154_16, &
      &  0.00000000650581688192_16, &
      & -0.00000000083210193692_16, &
      &  0.00000000010028101125_16, &
      & -0.00000000001142229304_16, &
      &  0.00000000000123307945_16, &
      & -0.00000000000012648523_16, &
      &  0.00000000000001235706_16, &
      & -0.00000000000000115226_16, &
      &  0.00000000000000010276_16, &
      & -0.00000000000000000878_16, &
      &  0.00000000000000000072_16, &
      & -0.00000000000000000006_16 /

w=0.125_16*x
z=4.0_16*w-2.0_16
b0=0.0_16
b1=0.0_16

do i=24, 0, -1
        b2=b1
        b1=b0
        b0=z*b1-b2+a(i)
enddo

e141a_r16=b0-b1*z/2.0_16

end function e141a_r16

real(16) function e141c_r16(x)        ! Функция e141c(x) вычисляет для заданного аргумента
implicit none                         ! ( x >= 5 ) значение выражения E1(x)*exp(x)*x через
real(16) x                            ! его разложение в ряд по смещённым полиномам Чебышева.
real(16) c(0:30)                      ! Коэффициенты разложения взяты из книги 
real(16) w,z                          ! Ю.Люка  Специальные математические функции и их
real(16) b0,b1,b2                     ! аппроксимации. Издательство "МИР". Москва, 1980.
integer i                             !                          стр. 112-113 (таблица 4.1 (c)).
 
data c / 0.92078514445389391645_16, &
      & -0.07343411783162128775_16, &
      &  0.00520981196727232977_16, &
      & -0.00050214071989599012_16, &
      &  0.00005920796937926337_16, &
      & -0.00000808564513097880_16, &
      &  0.00000123720385647926_16, &
      & -0.00000020750176860703_16, &
      &  0.00000003756005474022_16, &
      & -0.00000000725410976004_16, &
      &  0.00000000148181601182_16, &
      & -0.00000000031795682863_16, &
      &  0.00000000007126935828_16, &
      & -0.00000000001661231319_16, &
      &  0.00000000000401155069_16, &
      & -0.00000000000100038792_16, &
      &  0.00000000000025693341_16, &
      & -0.00000000000006780374_16, &
      &  0.00000000000001834785_16, &
      & -0.00000000000000508209_16, &
      &  0.00000000000000143861_16, &
      & -0.00000000000000041560_16, &
      &  0.00000000000000012238_16, &
      & -0.00000000000000003669_16, &
      &  0.00000000000000001119_16, &
      & -0.00000000000000000347_16, &
      &  0.00000000000000000109_16, &
      & -0.00000000000000000035_16, &
      &  0.00000000000000000011_16, &
      & -0.00000000000000000004_16, &
      &  0.00000000000000000001_16 /
 
w=5.0_16/x
z=4.0_16*w-2.0_16
b0=0.0_16
b1=0.0_16

do i=30, 0, -1
        b2=b1
        b1=b0
        b0=z*b1-b2+c(i)
enddo

e141c_r16=b0-b1*z/2.0_16

end function e141c_r16

end module p_e1
