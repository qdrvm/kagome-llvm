; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -filetype=obj -o /dev/null < %s
; RUN: llc -filetype=asm %s -o - | FileCheck %s

; ModuleID = 'bugpoint-reduced-simplified.bc'
source_filename = "bugpoint-output-39ed676.bc"
target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv8m.base-arm-none-eabi"

@crc32_tab = external unnamed_addr global [256 x i32], align 4
@g_566 = external global i32**, align 4

define void @main() {
; CHECK-LABEL: main:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    movw r0, :lower16:g_566
; CHECK-NEXT:    movt r0, :upper16:g_566
; CHECK-NEXT:    ldr r0, [r0]
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:    cmp r0, #0
; CHECK-NEXT:    beq .LBB0_8
; CHECK-NEXT:  @ %bb.1: @ %for.cond7.preheader.i.lr.ph.i.i
; CHECK-NEXT:    bne .LBB0_8
; CHECK-NEXT:  .LBB0_2: @ %for.cond14.preheader.us.i.i.i
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    cbnz r0, .LBB0_6
; CHECK-NEXT:  @ %bb.3: @ %for.cond14.preheader.us.i.i.i
; CHECK-NEXT:    @ in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    lsls r1, r0, #2
; CHECK-NEXT:    adr r2, .LJTI0_0
; CHECK-NEXT:    adds r1, r2, r1
; CHECK-NEXT:    mov pc, r1
; CHECK-NEXT:  @ %bb.4:
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  .LJTI0_0:
; CHECK-NEXT:    b.w .LBB0_5
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_7
; CHECK-NEXT:    b.w .LBB0_8
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_6
; CHECK-NEXT:    b.w .LBB0_5
; CHECK-NEXT:  .LBB0_5: @ %for.cond14.preheader.us.i.i.i
; CHECK-NEXT:    @ in Loop: Header=BB0_2 Depth=1
; CHECK-NEXT:    b .LBB0_2
; CHECK-NEXT:  .LBB0_6: @ %func_1.exit.loopexit
; CHECK-NEXT:  .LBB0_7: @ %lbl_1394.i.i.i.loopexit
; CHECK-NEXT:  .LBB0_8: @ %for.end476.i.i.i.loopexit
entry:
  %0 = load volatile i32**, i32*** @g_566, align 4
  br label %func_16.exit.i.i.i

lbl_1394.i.i.i.loopexit:                          ; preds = %for.cond14.preheader.us.i.i.i
  unreachable

func_16.exit.i.i.i:                               ; preds = %entry
  br i1 undef, label %for.cond7.preheader.i.lr.ph.i.i, label %for.end476.i.i.i.loopexit

for.cond7.preheader.i.lr.ph.i.i:                  ; preds = %func_16.exit.i.i.i
  br i1 undef, label %for.end476.i.i.i.loopexit, label %for.cond7.preheader.i.i.preheader.i

for.cond7.preheader.i.i.preheader.i:              ; preds = %for.cond7.preheader.i.lr.ph.i.i
  br label %for.cond14.preheader.us.i.i.i

for.cond7.preheader.i.us.i.i:                     ; preds = %for.cond7.preheader.i.lr.ph.i.i
  unreachable

for.cond14.preheader.us.i.i.i:                    ; preds = %for.inc459.us.i.i.i, %for.cond7.preheader.i.i.preheader.i
  switch i4 undef, label %func_1.exit.loopexit [
    i4 0, label %for.inc459.us.i.i.i
    i4 -5, label %for.inc459.us.i.i.i
    i4 2, label %lbl_1394.i.i.i.loopexit
    i4 3, label %for.end476.i.i.i.loopexit
  ]

for.inc459.us.i.i.i:                              ; preds = %for.cond14.preheader.us.i.i.i, %for.cond14.preheader.us.i.i.i
  br label %for.cond14.preheader.us.i.i.i

for.end476.i.i.i.loopexit:                        ; preds = %for.cond14.preheader.us.i.i.i
  unreachable

func_1.exit.loopexit:                             ; preds = %for.cond14.preheader.us.i.i.i
  %arrayidx.i63.i.i5252 = getelementptr inbounds [256 x i32], [256 x i32]* @crc32_tab, i32 0, i32 undef
  unreachable
}
