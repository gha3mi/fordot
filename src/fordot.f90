module fordot

   use kinds
   use fordot_opts, only: dot_opts

   implicit none

   private
   public :: dot_product

   interface dot_product
      procedure :: dot_R0R1R1_rel
      procedure :: dot_R0R1R1_rel_block
      procedure :: dot_R0R1R1_rel_coarray
   end interface

contains

   !> author: Seyed Ali Ghasemi
   pure function dot_R0R1R1_rel(u,v,option) result(a)
      real(rk),     intent(in), contiguous :: u(:)
      real(rk),     intent(in), contiguous :: v(:)
      character(*), intent(in)             :: option
      real(rk)                             :: a
      a = dot_opts(u, v, option)
   end function dot_R0R1R1_rel



   !> author: Seyed Ali Ghasemi
   pure function dot_R0R1R1_rel_block(u,v,option,nblock) result(a)
      real(rk),     intent(in), contiguous :: u(:)
      real(rk),     intent(in), contiguous :: v(:)
      character(*), intent(in)             :: option
      integer,      intent(in)             :: nblock
      real(rk)                             :: a
      integer                              :: im
      integer                              :: block_size(nblock), start_elem(nblock), end_elem(nblock)

      call compute_block_ranges(size(u), nblock, block_size, start_elem, end_elem)
      a = 0.0_rk
      do im = 1, nblock
         a = a + dot_product(u(start_elem(im):end_elem(im)),v(start_elem(im):end_elem(im)),option)
      end do
      
   end function dot_R0R1R1_rel_block



   !> author: Seyed Ali Ghasemi
   impure function dot_R0R1R1_rel_coarray(u,v,option,coarray) result(a)
      real(rk),     intent(in) :: u(:)
      real(rk),     intent(in) :: v(:)
      character(*), intent(in)             :: option
      real(rk)                             :: a
      logical,      intent(in)             :: coarray
#if defined(USE_COARRAY)
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
      ! call co_sum(a_block, result_image=1)
      ! a = a_block[1]
      sync all
      if (im == 1) then
         a = 0.0_rk
         do i = 1, nimg
            a = a + a_block[i]
         end do
      end if
#else
      a = dot_product(u, v, option)
#endif

   end function dot_R0R1R1_rel_coarray



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
      if (minval(block_size) <= 0) error stop 'ForDot: reduce the number of images of coarray.'
   end subroutine compute_block_ranges

end module fordot
