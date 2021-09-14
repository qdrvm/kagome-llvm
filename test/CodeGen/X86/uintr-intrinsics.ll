; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+uintr | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-linux-gnux32 -mattr=+uintr | FileCheck %s --check-prefix=X32

define i8 @test_uintr(i64 %arg) {
; X64-LABEL: test_uintr:
; X64:       # %bb.0: # %entry
; X64-NEXT:    clui
; X64-NEXT:    stui
; X64-NEXT:    senduipi %rdi
; X64-NEXT:    testui
; X64-NEXT:    setb %al
; X64-NEXT:    retq

; X32-LABEL: test_uintr:
; X32:       # %bb.0: # %entry
; X32-NEXT:    clui
; X32-NEXT:    stui
; X32-NEXT:    senduipi %rdi
; X32-NEXT:    testui
; X32-NEXT:    setb %al
; X32-NEXT:    retq
entry:
  call void @llvm.x86.clui()
  call void @llvm.x86.stui()
  call void @llvm.x86.senduipi(i64 %arg)
  %0 = call i8 @llvm.x86.testui()
  ret i8 %0
}

declare void @llvm.x86.clui()
declare void @llvm.x86.stui()
declare i8 @llvm.x86.testui()
declare void @llvm.x86.senduipi(i64 %arg)
