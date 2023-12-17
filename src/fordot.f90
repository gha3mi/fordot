module fordot

   use iso_fortran_env, only: ik => int32, rk => real64
   use fordot_opts, only: dot_opts

   implicit none

   private
   public :: dot_product

   interface dot_product
      procedure :: dot_R0R1R1_rel
   end interface

contains

   !> author: Seyed Ali Ghasemi
#if defined(USE_COARRAY)
   impure function dot_R0R1R1_rel(u,v,method,option) result(a)
#else
   pure function dot_R0R1R1_rel(u,v,method,option) result(a)
#endif
      real(rk),     intent(in), contiguous :: u(:)
      real(rk),     intent(in), contiguous :: v(:)
      character(*), intent(in)             :: method
      character(*), intent(in), optional   :: option
      real(rk)                             :: a

      select case (method)
#if defined(USE_COARRAY)
       case ('coarray')

         block
            integer               :: i, im, nimg, m
            integer               :: block_size(num_images()), start_elem(num_images()), end_elem(num_images())
            real(rk), allocatable :: a_block[:], u_block(:)[:], v_block(:)[:]
            im   = this_image()
            nimg = num_images()
            m    = size(u)
            call compute_block_ranges(size(u), nimg, block_size, start_elem, end_elem)
            allocate(u_block(block_size(im))[*], v_block(block_size(im))[*], a_block[*])
            u_block(:)[im] = u(start_elem(im):end_elem(im))
            v_block(:)[im] = v(start_elem(im):end_elem(im))
            a_block[im] = dot_opts(u_block(:)[im],v_block(:)[im],option)
            call co_sum(a_block, result_image=1)
            a = a_block[1]
            ! sync all
            ! if (im == 1) then
            !    a = 0.0_rk
            !    do i = 1, nimg
            !       a = a + a_block[i]
            !    end do
            ! end if
         end block

#endif
       case ('default')
         a = dot_opts(u, v, option)
      end select

   end function dot_R0R1R1_rel

   !> Calculate block sizes and ranges.
   !> author: Seyed Ali Ghasemi
   pure subroutine compute_block_ranges(d, nimg, block_size, start_elem, end_elem)
      integer, intent(in)  :: d, nimg
      integer, intent(out) :: block_size(nimg), start_elem(nimg), end_elem(nimg)
      integer              :: i, remainder
      block_size = d / nimg
      remainder = mod(d, nimg)
      block_size(1:remainder) = block_size(1:remainder) + 1
      start_elem(1) = 1
      end_elem(1) = block_size(1)
      do i = 2, nimg
         start_elem(i) = start_elem(i - 1) + block_size(i - 1)
         end_elem(i) = start_elem(i) + block_size(i) - 1
      end do
      ! Check if the block sizes are valid.
      if (minval(block_size) <= 0) error stop 'fordot: reduce the number of images of coarray.'
   end subroutine compute_block_ranges

end module fordot
