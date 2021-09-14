; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
;RUN: llc < %s -mtriple=i686-unknown -mattr=sse2 -relocation-model=pic | FileCheck %s

define void @f(<16 x i8>* %out, <16 x i8> %in, i1 %flag) {
; CHECK-LABEL: f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    calll .L0$pb
; CHECK-NEXT:    .cfi_adjust_cfa_offset 4
; CHECK-NEXT:  .L0$pb:
; CHECK-NEXT:    popl %eax
; CHECK-NEXT:    .cfi_adjust_cfa_offset -4
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    addl $_GLOBAL_OFFSET_TABLE_+(.Ltmp0-.L0$pb), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movb {{[0-9]+}}(%esp), %dl
; CHECK-NEXT:    notb %dl
; CHECK-NEXT:    andb $1, %dl
; CHECK-NEXT:    movzbl %dl, %edx
; CHECK-NEXT:    movd %edx, %xmm1
; CHECK-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; CHECK-NEXT:    pshuflw {{.*#+}} xmm1 = xmm1[0,0,0,0,4,5,6,7]
; CHECK-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,0,0,0]
; CHECK-NEXT:    paddb %xmm1, %xmm1
; CHECK-NEXT:    pxor %xmm0, %xmm1
; CHECK-NEXT:    pxor {{\.LCPI.*}}@GOTOFF(%eax), %xmm1
; CHECK-NEXT:    movdqa %xmm1, (%ecx)
; CHECK-NEXT:    retl
entry:
  %0 = select i1 %flag, i8 0, i8 2
  %1 = insertelement <16 x i8> undef, i8 %0, i32 0
  %2 = shufflevector <16 x i8> %1, <16 x i8> undef, <16 x i32> zeroinitializer
  %3 = xor <16 x i8> %2, %in
  %4 = xor <16 x i8> %3, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  store <16 x i8> %4, <16 x i8>* %out, align 16
  ret void
}
