; ModuleID = '/home/hxa/test/openai/testcases/Output/compute-stack-stride.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/compute-stack-stride.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [148 x i8] c"\01\00\02\00arr3[0] = %hhd\0A\00arr3[1] = %hhd\0A\00arr3[2] = %hhd\0A\00arr3[3] = %hhd\0A\00arr3[0] = %hhd, arr3[1] = %hhd, arr3[2] = %hhd, arr3[3] = %hhd, arr3[4] = %hhd\0A\00", align 4, !ROData_SecInfo !0

define dso_local i32 @foo(i64 %arg1, i32 %arg2) {
entry:
  %RDX-SKT-LOC = alloca i64, align 8
  %RCX-SKT-LOC44 = alloca i64, align 8
  %RCX-SKT-LOC = alloca i64, align 8
  %0 = and i32 %arg2, %arg2
  %highbit = and i32 -2147483648, %0
  %SF = icmp ne i32 %highbit, 0
  %ZF = icmp eq i32 %0, 0
  %1 = and i32 %0, 255
  %2 = call i32 @llvm.ctpop.i32(i32 %1)
  %3 = and i32 %2, 1
  %PF = icmp eq i32 %3, 0
  %CmpZF_JLE = icmp eq i1 %ZF, true
  %CmpOF_JLE = icmp ne i1 %SF, false
  %ZFOrSF_JLE = or i1 %CmpZF_JLE, %CmpOF_JLE
  br i1 %ZFOrSF_JLE, label %bb.8, label %bb.1

bb.1:                                             ; preds = %entry
  %memref-disp = add i32 %arg2, -1
  %RCX = zext i32 %memref-disp to i64
  %EAX = and i32 %arg2, 3
  %4 = and i32 %EAX, 255
  %5 = call i32 @llvm.ctpop.i32(i32 %4)
  %6 = and i32 %5, 1
  %PF1 = icmp eq i32 %6, 0
  %ZF2 = icmp eq i32 %EAX, 0
  %highbit3 = and i32 -2147483648, %EAX
  %SF4 = icmp ne i32 %highbit3, 0
  %7 = sub i64 %RCX, 3
  %8 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %RCX, i64 3)
  %CF = extractvalue { i64, i1 } %8, 1
  %ZF5 = icmp eq i64 %7, 0
  %highbit6 = and i64 -9223372036854775808, %7
  %SF7 = icmp ne i64 %highbit6, 0
  %9 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %RCX, i64 3)
  %OF = extractvalue { i64, i1 } %9, 1
  %10 = and i64 %7, 255
  %11 = call i64 @llvm.ctpop.i64(i64 %10)
  %12 = and i64 %11, 1
  %PF8 = icmp eq i64 %12, 0
  %CFCmp_JAE = icmp eq i1 %CF, false
  br i1 %CFCmp_JAE, label %bb.3, label %bb.2

bb.2:                                             ; preds = %bb.1
  %13 = zext i32 0 to i64
  store i64 %13, ptr %RCX-SKT-LOC44, align 1
  br label %bb.5

bb.3:                                             ; preds = %bb.1
  %EDX = and i32 %arg2, -4
  %14 = and i32 %EDX, 255
  %15 = call i32 @llvm.ctpop.i32(i32 %14)
  %16 = and i32 %15, 1
  %PF9 = icmp eq i32 %16, 0
  %ZF10 = icmp eq i32 %EDX, 0
  %highbit11 = and i32 -2147483648, %EDX
  %SF12 = icmp ne i32 %highbit11, 0
  %17 = zext i32 0 to i64
  store i64 %17, ptr %RCX-SKT-LOC, align 1
  br label %bb.4

bb.4:                                             ; preds = %bb.3, %bb.4
  %RCX13 = load i64, ptr %RCX-SKT-LOC, align 1
  %memref-disp14 = add i64 %RCX13, -128
  %ESI = trunc i64 %memref-disp14 to i32
  %memref-basereg = add i64 %arg1, %RCX13
  %18 = trunc i32 %ESI to i8
  %19 = inttoptr i64 %memref-basereg to ptr
  store i8 %18, ptr %19, align 1
  %memref-disp15 = add i64 %RCX13, -127
  %ESI16 = trunc i64 %memref-disp15 to i32
  %memref-basereg17 = add i64 %arg1, %RCX13
  %memref-disp18 = add i64 %memref-basereg17, 1
  %20 = trunc i32 %ESI16 to i8
  %21 = inttoptr i64 %memref-disp18 to ptr
  store i8 %20, ptr %21, align 1
  %memref-disp19 = add i64 %RCX13, -126
  %ESI20 = trunc i64 %memref-disp19 to i32
  %memref-basereg21 = add i64 %arg1, %RCX13
  %memref-disp22 = add i64 %memref-basereg21, 2
  %22 = trunc i32 %ESI20 to i8
  %23 = inttoptr i64 %memref-disp22 to ptr
  store i8 %22, ptr %23, align 1
  %memref-disp23 = add i64 %RCX13, -125
  %ESI24 = trunc i64 %memref-disp23 to i32
  %memref-basereg25 = add i64 %arg1, %RCX13
  %memref-disp26 = add i64 %memref-basereg25, 3
  %24 = trunc i32 %ESI24 to i8
  %25 = inttoptr i64 %memref-disp26 to ptr
  store i8 %24, ptr %25, align 1
  %RCX33 = add i64 %RCX13, 4
  %26 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %RCX13, i64 4)
  %CF27 = extractvalue { i64, i1 } %26, 1
  %27 = and i64 %RCX33, 255
  %28 = call i64 @llvm.ctpop.i64(i64 %27)
  %29 = and i64 %28, 1
  %PF28 = icmp eq i64 %29, 0
  %ZF29 = icmp eq i64 %RCX33, 0
  %highbit30 = and i64 -9223372036854775808, %RCX33
  %SF31 = icmp ne i64 %highbit30, 0
  %30 = call { i64, i1 } @llvm.sadd.with.overflow.i64(i64 %RCX13, i64 4)
  %OF32 = extractvalue { i64, i1 } %30, 1
  %31 = zext i32 %EDX to i64
  %32 = sub i64 %31, %RCX33
  %33 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %31, i64 %RCX33)
  %CF34 = extractvalue { i64, i1 } %33, 1
  %ZF35 = icmp eq i64 %32, 0
  %highbit36 = and i64 -9223372036854775808, %32
  %SF37 = icmp ne i64 %highbit36, 0
  %34 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %31, i64 %RCX33)
  %OF38 = extractvalue { i64, i1 } %34, 1
  %35 = and i64 %32, 255
  %36 = call i64 @llvm.ctpop.i64(i64 %35)
  %37 = and i64 %36, 1
  %PF39 = icmp eq i64 %37, 0
  store i64 %RCX33, ptr %RCX-SKT-LOC44, align 1
  %CmpZF_JNE = icmp eq i1 %ZF35, false
  store i64 %RCX33, ptr %RCX-SKT-LOC, align 1
  br i1 %CmpZF_JNE, label %bb.4, label %bb.5

bb.5:                                             ; preds = %bb.4, %bb.2
  %38 = zext i32 %EAX to i64
  %39 = zext i32 %EAX to i64
  %40 = and i64 %38, %39
  %highbit40 = and i64 -9223372036854775808, %40
  %SF41 = icmp ne i64 %highbit40, 0
  %ZF42 = icmp eq i64 %40, 0
  %41 = and i64 %40, 255
  %42 = call i64 @llvm.ctpop.i64(i64 %41)
  %43 = and i64 %42, 1
  %PF43 = icmp eq i64 %43, 0
  %CmpZF_JE = icmp eq i1 %ZF42, true
  br i1 %CmpZF_JE, label %bb.8, label %bb.6

bb.6:                                             ; preds = %bb.5
  %RCX45 = load i64, ptr %RCX-SKT-LOC44, align 1
  %RDI = add nsw i64 %arg1, %RCX45
  %highbit46 = and i64 -9223372036854775808, %RDI
  %SF47 = icmp ne i64 %highbit46, 0
  %ZF48 = icmp eq i64 %RDI, 0
  %44 = trunc i64 %RCX45 to i8
  %CL = add i8 %44, -128
  %45 = call { i8, i1 } @llvm.uadd.with.overflow.i8(i8 %44, i8 -128)
  %CF49 = extractvalue { i8, i1 } %45, 1
  %46 = call i8 @llvm.ctpop.i8(i8 %CL)
  %47 = and i8 %46, 1
  %PF50 = icmp eq i8 %47, 0
  %ZF51 = icmp eq i8 %CL, 0
  %highbit52 = and i8 -128, %CL
  %SF53 = icmp ne i8 %highbit52, 0
  %48 = call { i8, i1 } @llvm.sadd.with.overflow.i8(i8 %44, i8 -128)
  %OF54 = extractvalue { i8, i1 } %48, 1
  %ECX = zext i8 %CL to i32
  %49 = zext i32 0 to i64
  store i64 %49, ptr %RDX-SKT-LOC, align 1
  br label %bb.7

bb.7:                                             ; preds = %bb.6, %bb.7
  %RDX = load i64, ptr %RDX-SKT-LOC, align 1
  %50 = zext i32 %ECX to i64
  %memref-basereg55 = add i64 %50, %RDX
  %ESI56 = trunc i64 %memref-basereg55 to i32
  %memref-basereg57 = add i64 %RDI, %RDX
  %51 = trunc i32 %ESI56 to i8
  %52 = inttoptr i64 %memref-basereg57 to ptr
  store i8 %51, ptr %52, align 1
  %RDX62 = add i64 %RDX, 1
  %53 = and i64 %RDX62, 255
  %54 = call i64 @llvm.ctpop.i64(i64 %53)
  %55 = and i64 %54, 1
  %PF58 = icmp eq i64 %55, 0
  %ZF59 = icmp eq i64 %RDX62, 0
  %highbit60 = and i64 -9223372036854775808, %RDX62
  %SF61 = icmp ne i64 %highbit60, 0
  %56 = zext i32 %EAX to i64
  %57 = sub i64 %56, %RDX62
  %58 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %56, i64 %RDX62)
  %CF63 = extractvalue { i64, i1 } %58, 1
  %ZF64 = icmp eq i64 %57, 0
  %highbit65 = and i64 -9223372036854775808, %57
  %SF66 = icmp ne i64 %highbit65, 0
  %59 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %56, i64 %RDX62)
  %OF67 = extractvalue { i64, i1 } %59, 1
  %60 = and i64 %57, 255
  %61 = call i64 @llvm.ctpop.i64(i64 %60)
  %62 = and i64 %61, 1
  %PF68 = icmp eq i64 %62, 0
  %CmpZF_JNE69 = icmp eq i1 %ZF64, false
  store i64 %RDX62, ptr %RDX-SKT-LOC, align 1
  br i1 %CmpZF_JNE69, label %bb.7, label %bb.8

bb.8:                                             ; preds = %bb.7, %bb.5, %entry
  ret i32 0
}

declare dso_local ptr @calloc(i64, i64)

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @main() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  %0 = zext i32 5 to i64
  %1 = zext i32 4 to i64
  %2 = call ptr @calloc(i64 %0, i64 %1)
  %RAX = ptrtoint ptr %2 to i64
  %EAX = call i32 @foo(i64 %RAX, i32 5)
  %memload = load i32, ptr %2, align 1
  %3 = trunc i32 %memload to i8
  %R15D = zext i8 %3 to i32
  %4 = trunc i32 %R15D to i8
  %5 = trunc i32 %R15D to i8
  %6 = and i8 %4, %5
  %highbit = and i8 -128, %6
  %SF = icmp ne i8 %highbit, 0
  %ZF = icmp eq i8 %6, 0
  %7 = call i8 @llvm.ctpop.i8(i8 %6)
  %8 = and i8 %7, 1
  %PF = icmp eq i8 %8, 0
  %CmpZF_JLE = icmp eq i1 %ZF, true
  %CmpOF_JLE = icmp ne i1 %SF, false
  %ZFOrSF_JLE = or i1 %CmpZF_JLE, %CmpOF_JLE
  br i1 %ZFOrSF_JLE, label %bb.2, label %bb.1

bb.1:                                             ; preds = %entry
  %EAX1 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([148 x i8], ptr @rodata_14, i32 0, i32 4), i32 %R15D)
  br label %bb.2

bb.2:                                             ; preds = %bb.1, %entry
  %memref-disp = add i64 %RAX, 1
  %9 = inttoptr i64 %memref-disp to ptr
  %memload2 = load i32, ptr %9, align 1
  %10 = trunc i32 %memload2 to i8
  %R14D = sext i8 %10 to i32
  %EAX3 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([148 x i8], ptr @rodata_14, i32 0, i32 20), i32 %R14D)
  %memref-disp4 = add i64 %RAX, 2
  %11 = inttoptr i64 %memref-disp4 to ptr
  %memload5 = load i32, ptr %11, align 1
  %12 = trunc i32 %memload5 to i8
  %R12D = sext i8 %12 to i32
  %EAX6 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([148 x i8], ptr @rodata_14, i32 0, i32 36), i32 %R12D)
  %memref-disp7 = add i64 %RAX, 3
  %13 = inttoptr i64 %memref-disp7 to ptr
  %memload8 = load i32, ptr %13, align 1
  %14 = trunc i32 %memload8 to i8
  %EBP = sext i8 %14 to i32
  %EAX9 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([148 x i8], ptr @rodata_14, i32 0, i32 52), i32 %EBP)
  %memref-disp10 = add i64 %RAX, 4
  %15 = inttoptr i64 %memref-disp10 to ptr
  %memload11 = load i32, ptr %15, align 1
  %16 = trunc i32 %memload11 to i8
  %EBX = sext i8 %16 to i32
  %EAX12 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([148 x i8], ptr @rodata_14, i32 0, i32 132), i32 %EBX)
  %17 = trunc i32 %R15D to i8
  %ESI = sext i8 %17 to i32
  %EAX13 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([148 x i8], ptr @rodata_14, i32 0, i32 68), i32 %ESI, i32 %R14D, i32 %R12D, i32 %EBP, i32 %EBX)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.usub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.sadd.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i8, i1 } @llvm.uadd.with.overflow.i8(i8, i8) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i8 @llvm.ctpop.i8(i8) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i8, i1 } @llvm.sadd.with.overflow.i8(i8, i8) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4196064}
