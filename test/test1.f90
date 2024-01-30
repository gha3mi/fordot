program test_dot1

   use kinds
   use fordot, only: fdot_product => dot_product ! rename dot_product to fdot_product to avoid overloading
   use forunittest

   implicit none

   real(rk), allocatable :: u(:), v(:)
   real(rk)              :: a_ref, a
   integer               :: m
   type(unit_test)       :: ut

   ! a = u(m).v(m)
   m = 300

   allocate(u(m),v(m))
   call random_number(u)
   call random_number(v)
   u = u*100.0_rk
   v = v*100.0_rk

   a_ref = dot_product(u,v)

   a = fdot_product(u,v, option='m1')
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.1')

   a = fdot_product(u,v, option='m2')
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.2')

   a = fdot_product(u,v, option='m3')
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.3')

   a = fdot_product(u,v, option='m4')
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.4')

   a = fdot_product(u,v, option='m1b', nblock=16)
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.5')

   a = fdot_product(u,v, option='m2b', nblock=16)
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.6')

   a = fdot_product(u,v, option='m3b', nblock=16)
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.7')

   a = fdot_product(u,v, option='m4b', nblock=16)
   call ut%check(a, a_ref, tol=1e-5_rk, msg='test_dot1.8')

end program test_dot1

