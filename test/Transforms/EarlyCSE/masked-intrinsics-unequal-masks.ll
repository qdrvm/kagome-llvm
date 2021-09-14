; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -early-cse < %s | FileCheck %s

; Unequal mask check.

; Load-load: the second load can be removed if (assuming unequal masks) the
; second loaded value is a subset of the first loaded value considering the
; non-undef vector elements. In other words, if the second mask is a submask
; of the first one, and the through value of the second load is undef.

; Load-load, second mask is a submask of the first, second through is undef.
; Expect the second load to be removed.
define <4 x i32> @f3(<4 x i32>* %a0, <4 x i32> %a1) {
; CHECK-LABEL: @f3(
; CHECK-NEXT:    [[V0:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A0:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[V2:%.*]] = add <4 x i32> [[V0]], [[V0]]
; CHECK-NEXT:    ret <4 x i32> [[V2]]
;
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> %a1)
  %v1 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> undef)
  %v2 = add <4 x i32> %v0, %v1
  ret <4 x i32> %v2
}

; Load-load, second mask is a submask of the first, second through is not undef.
; Expect the second load to remain.
define <4 x i32> @f4(<4 x i32>* %a0, <4 x i32> %a1) {
; CHECK-LABEL: @f4(
; CHECK-NEXT:    [[V0:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A0:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[V1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A0]], i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> zeroinitializer)
; CHECK-NEXT:    [[V2:%.*]] = add <4 x i32> [[V0]], [[V1]]
; CHECK-NEXT:    ret <4 x i32> [[V2]]
;
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> %a1)
  %v1 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> zeroinitializer)
  %v2 = add <4 x i32> %v0, %v1
  ret <4 x i32> %v2
}

; Load-load, second mask is not a submask of the first, second through is undef.
; Expect the second load to remain.
define <4 x i32> @f5(<4 x i32>* %a0, <4 x i32> %a1) {
; CHECK-LABEL: @f5(
; CHECK-NEXT:    [[V0:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A0:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    [[V1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A0]], i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> zeroinitializer)
; CHECK-NEXT:    [[V2:%.*]] = add <4 x i32> [[V0]], [[V1]]
; CHECK-NEXT:    ret <4 x i32> [[V2]]
;
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> %a1)
  %v1 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> zeroinitializer)
  %v2 = add <4 x i32> %v0, %v1
  ret <4 x i32> %v2
}

; Store-store: the first store can be removed if the first; mask is a submask
; of the second mask.

; Store-store, first mask is a submask of the second.
; Expect the first store to be removed.
define void @f6(<4 x i32> %a0, <4 x i32>* %a1) {
; CHECK-LABEL: @f6(
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[A0:%.*]], <4 x i32>* [[A1:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
; CHECK-NEXT:    ret void
;
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %a0, <4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>)
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %a0, <4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
  ret void
}

; Store-store, first mask is not a submask of the second.
; Expect both stores to remain.
define void @f7(<4 x i32> %a0, <4 x i32>* %a1) {
; CHECK-LABEL: @f7(
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[A0:%.*]], <4 x i32>* [[A1:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[A0]], <4 x i32>* [[A1]], i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>)
; CHECK-NEXT:    ret void
;
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %a0, <4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %a0, <4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>)
  ret void
}

; Load-store: the store can be removed if the store's mask is a submask of the
; load's mask.

; Load-store, second mask is a submask of the first.
; Expect the store to be removed.
define <4 x i32> @f8(<4 x i32>* %a0, <4 x i32> %a1) {
; CHECK-LABEL: @f8(
; CHECK-NEXT:    [[V0:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A0:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    ret <4 x i32> [[V0]]
;
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> %a1)
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %v0, <4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>)
  ret <4 x i32> %v0
}

; Load-store, second mask is not a submask of the first.
; Expect the store to remain.
define <4 x i32> @f9(<4 x i32>* %a0, <4 x i32> %a1) {
; CHECK-LABEL: @f9(
; CHECK-NEXT:    [[V0:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A0:%.*]], i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> [[A1:%.*]])
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[V0]], <4 x i32>* [[A0]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
; CHECK-NEXT:    ret <4 x i32> [[V0]]
;
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> %a1)
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %v0, <4 x i32>* %a0, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
  ret <4 x i32> %v0
}

; Store-load: the load can be removed if load's mask is a submask of the
; store's mask, and the load's through value is undef.

; Store-load, load's mask is a submask of store's mask, thru is undef.
; Expect the load to be removed.
define <4 x i32> @fa(<4 x i32> %a0, <4 x i32>* %a1) {
; CHECK-LABEL: @fa(
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[A0:%.*]], <4 x i32>* [[A1:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
; CHECK-NEXT:    ret <4 x i32> [[A0]]
;
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %a0, <4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> undef)
  ret <4 x i32> %v0
}

; Store-load, load's mask is a submask of store's mask, thru is not undef.
; Expect the load to remain.
define <4 x i32> @fb(<4 x i32> %a0, <4 x i32>* %a1) {
; CHECK-LABEL: @fb(
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[A0:%.*]], <4 x i32>* [[A1:%.*]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
; CHECK-NEXT:    [[V0:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A1]], i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> zeroinitializer)
; CHECK-NEXT:    ret <4 x i32> [[V0]]
;
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %a0, <4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>)
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i32> zeroinitializer)
  ret <4 x i32> %v0
}

; Store-load, load's mask is not a submask of store's mask, thru is undef.
; Expect the load to remain.
define <4 x i32> @fc(<4 x i32> %a0, <4 x i32>* %a1) {
; CHECK-LABEL: @fc(
; CHECK-NEXT:    call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> [[A0:%.*]], <4 x i32>* [[A1:%.*]], i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>)
; CHECK-NEXT:    [[V0:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* [[A1]], i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> undef)
; CHECK-NEXT:    ret <4 x i32> [[V0]]
;
  call void @llvm.masked.store.v4i32.p0v4i32(<4 x i32> %a0, <4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 false, i1 false, i1 true>)
  %v0 = call <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>* %a1, i32 4, <4 x i1> <i1 true, i1 true, i1 false, i1 true>, <4 x i32> undef)
  ret <4 x i32> %v0
}

declare <4 x i32> @llvm.masked.load.v4i32.p0v4i32(<4 x i32>*, i32, <4 x i1>, <4 x i32>)
declare void @llvm.masked.store.v4i32.p0v4i32(<4 x i32>, <4 x i32>*, i32, <4 x i1>)
