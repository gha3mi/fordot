program benchmark1

   use kinds,                         only: rk
   use fortime,                       only: timer
   use fordot,                  only: dot_product
   use fordot_benchmark,        only: start_benchmark, stop_benchmark, write_benchmark
   use, intrinsic :: iso_fortran_env, only: compiler_version, compiler_options

   implicit none

   real(rk), allocatable         :: u(:)
   real(rk), allocatable         :: v(:)
   real(rk)         :: a_ref, a
#if defined(USE_COARRAY)
   type(timer)                   :: t[*]
#else
   type(timer)                   :: t
#endif
   integer                       :: m, n, i ,nloops, p, unit_num, im, nim
   character(len=:), allocatable :: file_name
   character(len=1000)           :: im_chr

   nloops = 10

#if defined(USE_COARRAY)
   im  = this_image()
   nim = num_images()

   write (im_chr, '(i0)') im

   file_name = "benchmark/benchmark1_im"//trim(im_chr)//".data"
#else
   file_name = "benchmark/benchmark1.data"
#endif

   open (newunit = unit_num, file = file_name)
   write(unit_num,'(a)') 'Fordot_product'
   write(unit_num,'(a)') compiler_version()
   write(unit_num,'(a)') compiler_options()
#if defined(USE_COARRAY)
   write(unit_num,"(g0,' ',g0)") im, nim
#endif
   close(unit_num)

   do p = 500000,5000000,500000

      ! a(n,m) = dot_product(u(m,n))
      m = p

      if (allocated(u))      deallocate(u)
      if (allocated(v))     deallocate(v)
      allocate(u(m))
      allocate(v(m))
      call random_number(u)
      call random_number(v)

#if defined(USE_COARRAY)
      call start_benchmark(t[im],m,1,1,"a_ref = dot_product(u,v)")
      do i = 1,nloops
         a_ref = dot_product(u,v)
      end do
      call stop_benchmark(t[im],m,1,1,nloops,a_ref,a_ref,'dot_product',file_name)
#else
      call start_benchmark(t,m,1,1,"a_ref = dot_product(u,v)")
      do i = 1,nloops
         a_ref = dot_product(u,v)
      end do
      call stop_benchmark(t,m,1,1,nloops,a_ref,a_ref,'dot_product',file_name)
#endif

#if defined(USE_COARRAY)
      call start_benchmark(t[im],m,1,1,"a = dot_product(u,v,'coarray','m1')")
      do i = 1,nloops
         a = dot_product(u,v,'coarray','m1')
      end do
      call stop_benchmark(t[im],m,1,1,nloops,a,a_ref,'coarray_dot_product',file_name)
#else
      call start_benchmark(t,m,1,1,"a = dot_product(u,v,'default','m1')")
      do i = 1,nloops
         a = dot_product(u,v,'default','m1')
      end do
      call stop_benchmark(t,m,1,1,nloops,a,a_ref,'default_dot_product',file_name)
#endif

#if defined(USE_COARRAY)
      call start_benchmark(t[im],m,1,1,"a = dot_product(u,v,'coarray','m2')")
      do i = 1,nloops
         a = dot_product(u,v,'coarray','m2')
      end do
      call stop_benchmark(t[im],m,1,1,nloops,a,a_ref,'coarray_m2',file_name)
#else
      call start_benchmark(t,m,1,1,"a = dot_product(u,v,'default','m2')")
      do i = 1,nloops
         a = dot_product(u,v,'default','m2')
      end do
      call stop_benchmark(t,m,1,1,nloops,a,a_ref,'default_m2',file_name)
#endif

#if defined(USE_COARRAY)
      call start_benchmark(t[im],m,1,1,"a = dot_product(u,v,'coarray','m3')")
      do i = 1,nloops
         a = dot_product(u,v,'coarray','m3')
      end do
      call stop_benchmark(t[im],m,1,1,nloops,a,a_ref,'coarray_m3',file_name)
#else
      call start_benchmark(t,m,1,1,"a = dot_product(u,v,'default','m3')")
      do i = 1,nloops
         a = dot_product(u,v,'default','m3')
      end do
      call stop_benchmark(t,m,1,1,nloops,a,a_ref,'default_m3',file_name)
#endif

   end do

end program benchmark1
