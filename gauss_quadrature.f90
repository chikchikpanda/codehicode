program quad
implicit none
integer::n,i
real::a,b,integral,func,int_g
real,dimension(:),allocatable::w
real,dimension(:),allocatable::x
write(*,*)"lower limit"
read(*,*)a
write(*,*)"upper limit"
read(*,*)b
write(*,*)"n-point?"
read(*,*)n
integral=0
select case(n)
case(1)
    allocate(w(n),x(n))
    w=(/2.00/)
    x=(/0.00/)
case(2)
     allocate(w(n),x(n))
     w=(/1.000,1.000/)
     x=(/-0.577,0.577/)
case(3)
     allocate(w(n),x(n))
     w=(/0.888,0.555,0.555/)
     x=(/0.000,-0.774,0.774/)
case(4)
     allocate(w(n),x(n))
     w=(/0.652,0.652,0.347,0.347/)
     x=(/-0.339,0.339,-0.861,0.861/)
end select
do i=1,n
integral=integral+w(i)*func((b-a)*0.5*x(i)+0.5*(a+b))
end do
int_g=(b-a)*0.5*integral
write(*,*)int_g
end program quad


real function func(x1)
implicit none
real::x1
func=1/(2+x1**2)
end function func
