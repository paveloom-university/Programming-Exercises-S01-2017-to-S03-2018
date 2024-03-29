program main
use mpmodule   ! Пожключение модуля многократной точности
use p_mpfun_e1 ! Подключение модуля рассчета E_1 на многократной точности
use p_e1       ! Подключение модуля рассчета E_1 на четверной точности
implicit none

interface e141 ! Объявление родового имени для функций из разных модулей
module procedure e141_mp, e141_r16
end interface

integer  i, n
real(16) a, b, x, h
real(16) t1, t2 ! Переменные времени

character(2)  i_holder  ! Строка-держатель i
character(10) x_holder  ! Строка-держатель x
character(58) mp_number ! Строка-держатель численной части вывода mpwrite
character(9)  mp_extent ! Строка-держатель степенной части вывода mpwrite
character(61) mp_out    ! Строка-держатель числа со степенной частью в стандартном формате

type (mp_real) x_mp ! Объявление переменной x для рассчета на многократной точности

call mpinit (500) ! Инициализатор параметров MPFUN (таких как точность)
                  ! Подробнее смотри в руководстве или в файле mpmod90.f

! Вывод заголовка программы
write(*,'(/,2x,a,/)') 'Сравнение результатов вычисления E_1(x) при &
&разложении в ряд по полиномам Чебышева на четверной точности и &
&на многократной точности'

read(*,*) a, b, n

h=(b-a)/n

! Вывод заголовка таблицы
write(*,'(2x,a,11x,a,35x,a,55x,a)') 'x', 'e1_r16', 'e1_mpfun', 'time'

open(7,file='mp_output'); open(8,file='mp_output_copy') ! Открытие выходного файла и файла-копии
do i=0, n, 1

write(i_holder,'(i2)') i+1 ! i_holder используется при копировании строки bash-командой sed (строка 52)

x=a+h*i

write(x_holder,'(e10.4)') x ! Передача вычисленного аргумента
x_mp=MPREAL(x_holder)       ! переменной x_mp типа mp_real

t1=second() ! Процедура second описана в файле second.f (поставляется вместе с библиотекой MPFUN)
call mpwrite(7,e141(x_mp)) ! Вывод результата, полученного на многократной точности
t2=second()

call system("sed -n "//i_holder//"p mp_output >> mp_output_copy")  ! Копирование полученной строки в файл-копию
! Это необходимо, поскольку по каким-то причинам процедура mpwrite не позволяет оператору read параллельно считывать из файла

! Считывание степенной и численной части полученной строки
read(8,'(12x,a2,4x,a58)') mp_extent, mp_number

mp_out = trim(mp_number)//'E'//mp_extent ! Формирование строки-результата

! Вывод строки таблицы
write(*,'(2x,e10.4,e41.33,2x,a,e15.7)') x, e141(x), mp_out, t2-t1

enddo

close(8); close(7)

write(*,*) ' '

end program
