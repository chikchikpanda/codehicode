program lag_int
implicit none
integer::n,i,j
integer::ierror
real::sum_a,prodfunc,x,k
character(len=80)::msg
real,dimension(:),allocatable::f_a
real,dimension(:),allocatable::x_a
n=0
x=4.5
open(unit=15,file="inter_dat",status="old",action="read",iostat=ierror,iomsg=msg)
checking_a:if (ierror>0) then
write(*,*)"given file cannot be opened"
else
loop_a: do 
read(15,*,iostat=ierror)
if(ierror/=0) EXIT
n=n+1
end do loop_a
end if checking_a
close(15)
allocate(f_a(n),x_a(n))
open(unit=15,file="inter_dat",status="old",action="read",iostat=ierror,iomsg=msg)
do i=1,n
read(15,*,iostat=ierror)x_a(i),f_a(i)
end do
close(15)
sum_a=0
do i=1,n+1
  prodfunc=1
      do j=1,n+1
          if(j .ne. i)then
             k=(x-x_a(j))/(x_a(i)-x_a(j))
             prodfunc=prodfunc*k
          end if
      end do
  sum_a=sum_a+f_a(i)*prodfunc
end do  
write(*,*)"interpolated value at",x,"is",sum_a    
end program lag_int
