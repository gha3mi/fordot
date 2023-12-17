module fordot_opts

   use iso_fortran_env, only: ik => int32, rk => real64

   implicit none

   private
   public :: dot_opts

   interface dot_opts
      procedure :: dot_R0R1R1_rel_opts
   end interface

contains

   !> author: Seyed Ali Ghasemi
   pure function dot_R0R1R1_rel_opts(u,v, option) result(a)
      real(rk), dimension(:), intent(in), contiguous  :: u, v
      character(*),           intent(in)              :: option
      real(rk)                                        :: a

      select case (option)
       case ('m1')
         a = dot_product(u,v)
       case ('m2')
         a = md_2(u,v)
       case ('m3')
         a = md_3(u,v)
       case default
         a = dot_product(u,v)
      end select
   end function dot_R0R1R1_rel_opts

   !> author: Seyed Ali Ghasemi
   pure function md_2(u,v) result(a)
      real(rk), dimension(:), intent(in), contiguous :: u, v
      real(rk)                                       :: a

      interface
         pure function ddot(f_n, f_dx, f_incx, f_dy, f_incy) result(f_a)
            import rk
            integer, intent(in) :: f_incx, f_incy, f_n
            real(rk), intent(in) :: f_dx(f_n), f_dy(f_n)
            real(rk) :: f_a
         end function ddot
      end interface

      a = ddot(size(u),u,1,v,1)
   end function md_2

   !> author: Seyed Ali Ghasemi
   pure function md_3(u,v) result(a)
      real(rk), dimension(:), intent(in), contiguous :: u, v
      real(rk) :: a
      integer :: i

      do i = 1, size(u)
         a = a + u(i)*v(i)
      end do
   end function md_3

end module fordot_opts
