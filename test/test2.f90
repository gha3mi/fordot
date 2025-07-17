program test_dot2

   use kinds
   use fordot, only: fdot_product => dot_product ! rename dot_product to fdot_product to avoid overloading
   use forunittest, only: unit_test

   implicit none

   real(rk), allocatable :: u(:), v(:)
   real(rk)              :: a_ref, a
   integer               :: m, im
   type(unit_test)       :: ut

#if defined(USE_COARRAY)
   im = this_image()
#else
   im = 1
#endif

   ! a = u(m).v(n)
   m = 500

   allocate(u(m),v(m))
   call random_number(u)
   call random_number(v)
   u = u*100.0_rk
   v = v*100.0_rk

   a_ref = dot_product(u,v)

   a = fdot_product(u,v, coarray=.true., option='m1')
   if (im==1) call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot2.1')

   a = fdot_product(u,v, coarray=.true., option='m2')
   if (im==1) call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot2.2')

   a = fdot_product(u,v, coarray=.true., option='m3')
   if (im==1) call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot2.3')

   a = fdot_product(u,v, coarray=.true., option='m4')
   if (im==1) call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot2.4')

end program test_dot2

