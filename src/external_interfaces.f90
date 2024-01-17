module external_interfaces

   use kinds

   implicit none

   interface dot
#if defined(REAL64)
      pure function ddot(f_n, f_dx, f_incx, f_dy, f_incy) result(f_a)
         import rk
         integer, intent(in) :: f_incx, f_incy, f_n
         real(rk), intent(in) :: f_dx(f_n), f_dy(f_n)
         real(rk) :: f_a
      end function ddot
#elif defined(REAL32)
      pure function sdot(f_n, f_dx, f_incx, f_dy, f_incy) result(f_a)
         import rk
         integer, intent(in) :: f_incx, f_incy, f_n
         real(rk), intent(in) :: f_dx(f_n), f_dy(f_n)
         real(rk) :: f_a
      end function sdot
#else
      pure function ddot(f_n, f_dx, f_incx, f_dy, f_incy) result(f_a)
         import rk
         integer, intent(in) :: f_incx, f_incy, f_n
         real(rk), intent(in) :: f_dx(f_n), f_dy(f_n)
         real(rk) :: f_a
      end function ddot
#endif
   end interface

end module external_interfaces
