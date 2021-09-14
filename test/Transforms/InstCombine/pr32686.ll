; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine %s | FileCheck %s

@a = common global i8 0, align 1
@b = external global i32

define void @tinkywinky() {
; CHECK-LABEL: @tinkywinky(
; CHECK-NEXT:    [[PATATINO:%.*]] = load i8, i8* @a, align 1
; CHECK-NEXT:    [[TOBOOL:%.*]] = icmp eq i8 [[PATATINO]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = zext i1 [[TOBOOL]] to i32
; CHECK-NEXT:    [[OR1:%.*]] = or i32 [[TMP1]], or (i32 zext (i1 icmp ne (i32* bitcast (i8* @a to i32*), i32* @b) to i32), i32 2)
; CHECK-NEXT:    store i32 [[OR1]], i32* @b, align 4
; CHECK-NEXT:    ret void
;
  %patatino = load i8, i8* @a
  %tobool = icmp ne i8 %patatino, 0
  %lnot = xor i1 %tobool, true
  %lnot.ext = zext i1 %lnot to i32
  %or = or i32 xor (i32 zext (i1 icmp ne (i32* bitcast (i8* @a to i32*), i32* @b) to i32), i32 2), %lnot.ext
  store i32 %or, i32* @b, align 4
  ret void
}
