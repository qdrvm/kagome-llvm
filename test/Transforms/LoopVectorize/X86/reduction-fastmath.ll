; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -loop-vectorize < %s | FileCheck %s

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define float @reduction_sum_float_ieee(i32 %n, float* %array) {
; CHECK-LABEL: @reduction_sum_float_ieee(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ENTRY_COND:%.*]] = icmp ne i32 0, 4096
; CHECK-NEXT:    br i1 [[ENTRY_COND]], label [[LOOP_PREHEADER:%.*]], label [[LOOP_EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_INC:%.*]], [[LOOP]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi float [ [[SUM_INC:%.*]], [[LOOP]] ], [ 0.000000e+00, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[ADDRESS:%.*]] = getelementptr float, float* [[ARRAY:%.*]], i32 [[IDX]]
; CHECK-NEXT:    [[VALUE:%.*]] = load float, float* [[ADDRESS]], align 4
; CHECK-NEXT:    [[SUM_INC]] = fadd float [[SUM]], [[VALUE]]
; CHECK-NEXT:    [[IDX_INC]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[BE_COND:%.*]] = icmp ne i32 [[IDX_INC]], 4096
; CHECK-NEXT:    br i1 [[BE_COND]], label [[LOOP]], label [[LOOP_EXIT_LOOPEXIT:%.*]]
; CHECK:       loop.exit.loopexit:
; CHECK-NEXT:    [[SUM_INC_LCSSA:%.*]] = phi float [ [[SUM_INC]], [[LOOP]] ]
; CHECK-NEXT:    br label [[LOOP_EXIT]]
; CHECK:       loop.exit:
; CHECK-NEXT:    [[SUM_LCSSA:%.*]] = phi float [ 0.000000e+00, [[ENTRY:%.*]] ], [ [[SUM_INC_LCSSA]], [[LOOP_EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret float [[SUM_LCSSA]]
;
entry:
  %entry.cond = icmp ne i32 0, 4096
  br i1 %entry.cond, label %loop, label %loop.exit

loop:
  %idx = phi i32 [ 0, %entry ], [ %idx.inc, %loop ]
  %sum = phi float [ 0.000000e+00, %entry ], [ %sum.inc, %loop ]
  %address = getelementptr float, float* %array, i32 %idx
  %value = load float, float* %address
  %sum.inc = fadd float %sum, %value
  %idx.inc = add i32 %idx, 1
  %be.cond = icmp ne i32 %idx.inc, 4096
  br i1 %be.cond, label %loop, label %loop.exit

loop.exit:
  %sum.lcssa = phi float [ %sum.inc, %loop ], [ 0.000000e+00, %entry ]
  ret float %sum.lcssa
}

define float @reduction_sum_float_fastmath(i32 %n, float* %array) {
; CHECK-LABEL: @reduction_sum_float_fastmath(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ENTRY_COND:%.*]] = icmp ne i32 0, 4096
; CHECK-NEXT:    br i1 [[ENTRY_COND]], label [[LOOP_PREHEADER:%.*]], label [[LOOP_EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP8:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP9:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, float* [[ARRAY:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr float, float* [[ARRAY]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr float, float* [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast float* [[TMP4]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, <4 x float>* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr float, float* [[TMP2]], i32 4
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast float* [[TMP6]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x float>, <4 x float>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8]] = fadd fast <4 x float> [[VEC_PHI]], [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP9]] = fadd fast <4 x float> [[VEC_PHI1]], [[WIDE_LOAD2]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 8
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP0:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = fadd fast <4 x float> [[TMP9]], [[TMP8]]
; CHECK-NEXT:    [[TMP11:%.*]] = call fast float @llvm.vector.reduce.fadd.v4f32(float -0.000000e+00, <4 x float> [[BIN_RDX]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 4096, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOP_EXIT_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ 0.000000e+00, [[LOOP_PREHEADER]] ], [ [[TMP11]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_INC:%.*]], [[LOOP]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi float [ [[SUM_INC:%.*]], [[LOOP]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ADDRESS:%.*]] = getelementptr float, float* [[ARRAY]], i32 [[IDX]]
; CHECK-NEXT:    [[VALUE:%.*]] = load float, float* [[ADDRESS]], align 4
; CHECK-NEXT:    [[SUM_INC]] = fadd fast float [[SUM]], [[VALUE]]
; CHECK-NEXT:    [[IDX_INC]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[BE_COND:%.*]] = icmp ne i32 [[IDX_INC]], 4096
; CHECK-NEXT:    br i1 [[BE_COND]], label [[LOOP]], label [[LOOP_EXIT_LOOPEXIT]], [[LOOP2:!llvm.loop !.*]]
; CHECK:       loop.exit.loopexit:
; CHECK-NEXT:    [[SUM_INC_LCSSA:%.*]] = phi float [ [[SUM_INC]], [[LOOP]] ], [ [[TMP11]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP_EXIT]]
; CHECK:       loop.exit:
; CHECK-NEXT:    [[SUM_LCSSA:%.*]] = phi float [ 0.000000e+00, [[ENTRY:%.*]] ], [ [[SUM_INC_LCSSA]], [[LOOP_EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret float [[SUM_LCSSA]]
;
entry:
  %entry.cond = icmp ne i32 0, 4096
  br i1 %entry.cond, label %loop, label %loop.exit

loop:
  %idx = phi i32 [ 0, %entry ], [ %idx.inc, %loop ]
  %sum = phi float [ 0.000000e+00, %entry ], [ %sum.inc, %loop ]
  %address = getelementptr float, float* %array, i32 %idx
  %value = load float, float* %address
  %sum.inc = fadd fast float %sum, %value
  %idx.inc = add i32 %idx, 1
  %be.cond = icmp ne i32 %idx.inc, 4096
  br i1 %be.cond, label %loop, label %loop.exit

loop.exit:
  %sum.lcssa = phi float [ %sum.inc, %loop ], [ 0.000000e+00, %entry ]
  ret float %sum.lcssa
}

define float @reduction_sum_float_only_reassoc(i32 %n, float* %array) {
; CHECK-LABEL: @reduction_sum_float_only_reassoc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ENTRY_COND:%.*]] = icmp ne i32 0, 4096
; CHECK-NEXT:    br i1 [[ENTRY_COND]], label [[LOOP_PREHEADER:%.*]], label [[LOOP_EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP8:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP9:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, float* [[ARRAY:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr float, float* [[ARRAY]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr float, float* [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast float* [[TMP4]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, <4 x float>* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr float, float* [[TMP2]], i32 4
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast float* [[TMP6]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x float>, <4 x float>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8]] = fadd reassoc <4 x float> [[VEC_PHI]], [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP9]] = fadd reassoc <4 x float> [[VEC_PHI1]], [[WIDE_LOAD2]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 8
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP4:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = fadd reassoc <4 x float> [[TMP9]], [[TMP8]]
; CHECK-NEXT:    [[TMP11:%.*]] = call reassoc float @llvm.vector.reduce.fadd.v4f32(float -0.000000e+00, <4 x float> [[BIN_RDX]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 4096, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOP_EXIT_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ 0.000000e+00, [[LOOP_PREHEADER]] ], [ [[TMP11]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_INC:%.*]], [[LOOP]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi float [ [[SUM_INC:%.*]], [[LOOP]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ADDRESS:%.*]] = getelementptr float, float* [[ARRAY]], i32 [[IDX]]
; CHECK-NEXT:    [[VALUE:%.*]] = load float, float* [[ADDRESS]], align 4
; CHECK-NEXT:    [[SUM_INC]] = fadd reassoc float [[SUM]], [[VALUE]]
; CHECK-NEXT:    [[IDX_INC]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[BE_COND:%.*]] = icmp ne i32 [[IDX_INC]], 4096
; CHECK-NEXT:    br i1 [[BE_COND]], label [[LOOP]], label [[LOOP_EXIT_LOOPEXIT]], [[LOOP5:!llvm.loop !.*]]
; CHECK:       loop.exit.loopexit:
; CHECK-NEXT:    [[SUM_INC_LCSSA:%.*]] = phi float [ [[SUM_INC]], [[LOOP]] ], [ [[TMP11]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP_EXIT]]
; CHECK:       loop.exit:
; CHECK-NEXT:    [[SUM_LCSSA:%.*]] = phi float [ 0.000000e+00, [[ENTRY:%.*]] ], [ [[SUM_INC_LCSSA]], [[LOOP_EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret float [[SUM_LCSSA]]
;
entry:
  %entry.cond = icmp ne i32 0, 4096
  br i1 %entry.cond, label %loop, label %loop.exit

loop:
  %idx = phi i32 [ 0, %entry ], [ %idx.inc, %loop ]
  %sum = phi float [ 0.000000e+00, %entry ], [ %sum.inc, %loop ]
  %address = getelementptr float, float* %array, i32 %idx
  %value = load float, float* %address
  %sum.inc = fadd reassoc float %sum, %value
  %idx.inc = add i32 %idx, 1
  %be.cond = icmp ne i32 %idx.inc, 4096
  br i1 %be.cond, label %loop, label %loop.exit

loop.exit:
  %sum.lcssa = phi float [ %sum.inc, %loop ], [ 0.000000e+00, %entry ]
  ret float %sum.lcssa
}

define float @reduction_sum_float_only_reassoc_and_contract(i32 %n, float* %array) {
; CHECK-LABEL: @reduction_sum_float_only_reassoc_and_contract(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ENTRY_COND:%.*]] = icmp ne i32 0, 4096
; CHECK-NEXT:    br i1 [[ENTRY_COND]], label [[LOOP_PREHEADER:%.*]], label [[LOOP_EXIT:%.*]]
; CHECK:       loop.preheader:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP8:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP9:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr float, float* [[ARRAY:%.*]], i32 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr float, float* [[ARRAY]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr float, float* [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast float* [[TMP4]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, <4 x float>* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr float, float* [[TMP2]], i32 4
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast float* [[TMP6]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x float>, <4 x float>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8]] = fadd reassoc contract <4 x float> [[VEC_PHI]], [[WIDE_LOAD]]
; CHECK-NEXT:    [[TMP9]] = fadd reassoc contract <4 x float> [[VEC_PHI1]], [[WIDE_LOAD2]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 8
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i32 [[INDEX_NEXT]], 4096
; CHECK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP6:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[BIN_RDX:%.*]] = fadd reassoc contract <4 x float> [[TMP9]], [[TMP8]]
; CHECK-NEXT:    [[TMP11:%.*]] = call reassoc contract float @llvm.vector.reduce.fadd.v4f32(float -0.000000e+00, <4 x float> [[BIN_RDX]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 4096, 4096
; CHECK-NEXT:    br i1 [[CMP_N]], label [[LOOP_EXIT_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 4096, [[MIDDLE_BLOCK]] ], [ 0, [[LOOP_PREHEADER]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ 0.000000e+00, [[LOOP_PREHEADER]] ], [ [[TMP11]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IDX:%.*]] = phi i32 [ [[IDX_INC:%.*]], [[LOOP]] ], [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi float [ [[SUM_INC:%.*]], [[LOOP]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ADDRESS:%.*]] = getelementptr float, float* [[ARRAY]], i32 [[IDX]]
; CHECK-NEXT:    [[VALUE:%.*]] = load float, float* [[ADDRESS]], align 4
; CHECK-NEXT:    [[SUM_INC]] = fadd reassoc contract float [[SUM]], [[VALUE]]
; CHECK-NEXT:    [[IDX_INC]] = add i32 [[IDX]], 1
; CHECK-NEXT:    [[BE_COND:%.*]] = icmp ne i32 [[IDX_INC]], 4096
; CHECK-NEXT:    br i1 [[BE_COND]], label [[LOOP]], label [[LOOP_EXIT_LOOPEXIT]], [[LOOP7:!llvm.loop !.*]]
; CHECK:       loop.exit.loopexit:
; CHECK-NEXT:    [[SUM_INC_LCSSA:%.*]] = phi float [ [[SUM_INC]], [[LOOP]] ], [ [[TMP11]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[LOOP_EXIT]]
; CHECK:       loop.exit:
; CHECK-NEXT:    [[SUM_LCSSA:%.*]] = phi float [ 0.000000e+00, [[ENTRY:%.*]] ], [ [[SUM_INC_LCSSA]], [[LOOP_EXIT_LOOPEXIT]] ]
; CHECK-NEXT:    ret float [[SUM_LCSSA]]
;
entry:
  %entry.cond = icmp ne i32 0, 4096
  br i1 %entry.cond, label %loop, label %loop.exit

loop:
  %idx = phi i32 [ 0, %entry ], [ %idx.inc, %loop ]
  %sum = phi float [ 0.000000e+00, %entry ], [ %sum.inc, %loop ]
  %address = getelementptr float, float* %array, i32 %idx
  %value = load float, float* %address
  %sum.inc = fadd reassoc contract float %sum, %value
  %idx.inc = add i32 %idx, 1
  %be.cond = icmp ne i32 %idx.inc, 4096
  br i1 %be.cond, label %loop, label %loop.exit

loop.exit:
  %sum.lcssa = phi float [ %sum.inc, %loop ], [ 0.000000e+00, %entry ]
  ret float %sum.lcssa
}

; FIXME: Some fcmp are 'nnan ninf', some are 'fast', but the reduction is sequential?

define float @PR35538(float* nocapture readonly %a, i32 %N) #0 {
; CHECK-LABEL: @PR35538(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP12:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP12]], label [[FOR_BODY_LR_PH:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[WIDE_TRIP_COUNT]], 8
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[WIDE_TRIP_COUNT]], 8
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[WIDE_TRIP_COUNT]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>, [[VECTOR_PH]] ], [ [[TMP10:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x float> [ <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>, [[VECTOR_PH]] ], [ [[TMP11:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds float, float* [[A:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds float, float* [[A]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds float, float* [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast float* [[TMP4]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, <4 x float>* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds float, float* [[TMP2]], i32 4
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast float* [[TMP6]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x float>, <4 x float>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = fcmp nnan ninf oge <4 x float> [[WIDE_LOAD]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP9:%.*]] = fcmp nnan ninf oge <4 x float> [[WIDE_LOAD2]], [[VEC_PHI1]]
; CHECK-NEXT:    [[TMP10]] = select <4 x i1> [[TMP8]], <4 x float> [[WIDE_LOAD]], <4 x float> [[VEC_PHI]]
; CHECK-NEXT:    [[TMP11]] = select <4 x i1> [[TMP9]], <4 x float> [[WIDE_LOAD2]], <4 x float> [[VEC_PHI1]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP8:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[RDX_MINMAX_CMP:%.*]] = fcmp fast ogt <4 x float> [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[RDX_MINMAX_SELECT:%.*]] = select fast <4 x i1> [[RDX_MINMAX_CMP]], <4 x float> [[TMP10]], <4 x float> [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = call float @llvm.vector.reduce.fmax.v4f32(<4 x float> [[RDX_MINMAX_SELECT]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[WIDE_TRIP_COUNT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_LR_PH]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ -1.000000e+00, [[FOR_BODY_LR_PH]] ], [ [[TMP13]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    [[MAX_0__LCSSA:%.*]] = phi float [ [[MAX_0_:%.*]], [[FOR_BODY]] ], [ [[TMP13]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[MAX_0_LCSSA:%.*]] = phi float [ -1.000000e+00, [[ENTRY:%.*]] ], [ [[MAX_0__LCSSA]], [[FOR_COND_CLEANUP_LOOPEXIT]] ]
; CHECK-NEXT:    ret float [[MAX_0_LCSSA]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[MAX_013:%.*]] = phi float [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[MAX_0_]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, float* [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP14:%.*]] = load float, float* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[CMP1_INV:%.*]] = fcmp nnan ninf oge float [[TMP14]], [[MAX_013]]
; CHECK-NEXT:    [[MAX_0_]] = select i1 [[CMP1_INV]], float [[TMP14]], float [[MAX_013]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[FOR_BODY]], [[LOOP9:!llvm.loop !.*]]
;
entry:
  %cmp12 = icmp sgt i32 %N, 0
  br i1 %cmp12, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:
  %wide.trip.count = zext i32 %N to i64
  br label %for.body

for.cond.cleanup:
  %max.0.lcssa = phi float [ -1.000000e+00, %entry ], [ %max.0., %for.body ]
  ret float %max.0.lcssa

for.body:
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %max.013 = phi float [ -1.000000e+00, %for.body.lr.ph ], [ %max.0., %for.body ]
  %arrayidx = getelementptr inbounds float, float* %a, i64 %indvars.iv
  %0 = load float, float* %arrayidx, align 4
  %cmp1.inv = fcmp nnan ninf oge float %0, %max.013
  %max.0. = select i1 %cmp1.inv, float %0, float %max.013
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

define float @PR35538_more_FMF(float* nocapture readonly %a, i32 %N) #0 {
; CHECK-LABEL: @PR35538_more_FMF(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP12:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP12]], label [[FOR_BODY_LR_PH:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.lr.ph:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 [[WIDE_TRIP_COUNT]], 8
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[WIDE_TRIP_COUNT]], 8
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[WIDE_TRIP_COUNT]], [[N_MOD_VF]]
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>, [[VECTOR_PH]] ], [ [[TMP10:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI1:%.*]] = phi <4 x float> [ <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>, [[VECTOR_PH]] ], [ [[TMP11:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds float, float* [[A:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds float, float* [[A]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds float, float* [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = bitcast float* [[TMP4]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x float>, <4 x float>* [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds float, float* [[TMP2]], i32 4
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast float* [[TMP6]] to <4 x float>*
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <4 x float>, <4 x float>* [[TMP7]], align 4
; CHECK-NEXT:    [[TMP8:%.*]] = fcmp nnan ninf oge <4 x float> [[WIDE_LOAD]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP9:%.*]] = fcmp nnan ninf oge <4 x float> [[WIDE_LOAD2]], [[VEC_PHI1]]
; CHECK-NEXT:    [[TMP10]] = select <4 x i1> [[TMP8]], <4 x float> [[WIDE_LOAD]], <4 x float> [[VEC_PHI]]
; CHECK-NEXT:    [[TMP11]] = select <4 x i1> [[TMP9]], <4 x float> [[WIDE_LOAD2]], <4 x float> [[VEC_PHI1]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 8
; CHECK-NEXT:    [[TMP12:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP12]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], [[LOOP10:!llvm.loop !.*]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[RDX_MINMAX_CMP:%.*]] = fcmp fast ogt <4 x float> [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[RDX_MINMAX_SELECT:%.*]] = select fast <4 x i1> [[RDX_MINMAX_CMP]], <4 x float> [[TMP10]], <4 x float> [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = call nnan ninf float @llvm.vector.reduce.fmax.v4f32(<4 x float> [[RDX_MINMAX_SELECT]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 [[WIDE_TRIP_COUNT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[FOR_BODY_LR_PH]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi float [ -1.000000e+00, [[FOR_BODY_LR_PH]] ], [ [[TMP13]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    [[MAX_0__LCSSA:%.*]] = phi float [ [[MAX_0_:%.*]], [[FOR_BODY]] ], [ [[TMP13]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    [[MAX_0_LCSSA:%.*]] = phi float [ -1.000000e+00, [[ENTRY:%.*]] ], [ [[MAX_0__LCSSA]], [[FOR_COND_CLEANUP_LOOPEXIT]] ]
; CHECK-NEXT:    ret float [[MAX_0_LCSSA]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[MAX_013:%.*]] = phi float [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[MAX_0_]], [[FOR_BODY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, float* [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP14:%.*]] = load float, float* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[CMP1_INV:%.*]] = fcmp nnan ninf oge float [[TMP14]], [[MAX_013]]
; CHECK-NEXT:    [[MAX_0_]] = select nnan ninf i1 [[CMP1_INV]], float [[TMP14]], float [[MAX_013]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP_LOOPEXIT]], label [[FOR_BODY]], [[LOOP11:!llvm.loop !.*]]
;
entry:
  %cmp12 = icmp sgt i32 %N, 0
  br i1 %cmp12, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:
  %wide.trip.count = zext i32 %N to i64
  br label %for.body

for.cond.cleanup:
  %max.0.lcssa = phi float [ -1.000000e+00, %entry ], [ %max.0., %for.body ]
  ret float %max.0.lcssa

for.body:
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %max.013 = phi float [ -1.000000e+00, %for.body.lr.ph ], [ %max.0., %for.body ]
  %arrayidx = getelementptr inbounds float, float* %a, i64 %indvars.iv
  %0 = load float, float* %arrayidx, align 4
  %cmp1.inv = fcmp nnan ninf oge float %0, %max.013
  %max.0. = select nnan ninf i1 %cmp1.inv, float %0, float %max.013
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %for.cond.cleanup, label %for.body
}

attributes #0 = { "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="false" "unsafe-fp-math"="false" }
