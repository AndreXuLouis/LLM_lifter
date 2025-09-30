; ModuleID = '/home/hxa/test/openai/testcases/Output/test-stack-promoted-val-user-replacement.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/test-stack-promoted-val-user-replacement.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [369 x i8] c"\01\00\02\00arr[0] = %d, arr[1] = %d, arr[2] = %d, arr[3] = %d, arr[4] = %d\0A\00arr1[0] = %u, arr1[1] = %u, arr1[2] = %u, arr1[3] = %u, arr1[4] = %u\0A\00arr2[0] = %hd, arr2[1] = %hd, arr2[2] = %hd, arr2[3] = %hd, arr2[4] = %hd\0A\00arr3[0] = %hhd, arr3[1] = %hhd, arr3[2] = %hhd, arr3[3] = %hhd, arr3[4] = %hhd\0A\00arr4[0] = %ld, arr4[1] = %ld, arr4[2] = %ld, arr4[3] = %ld, arr4[4] = %ld\0A\00", align 4, !ROData_SecInfo !0

define dso_local i32 @foo(i64 %arg1, i64 %arg2, i64 %arg3, i64 %arg4, i64 %arg5, i32 %arg6) {
entry:
  %R10D-SKT-LOC = alloca i64, align 8
  %EAX-SKT-LOC = alloca i64, align 8
  %stktop_8 = alloca i8, i32 8, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  store i64 3735928559, ptr %stktop_8, align 8
  %0 = and i32 %arg6, %arg6
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
  br i1 %ZFOrSF_JLE, label %bb.3, label %bb.1

bb.1:                                             ; preds = %entry
  %4 = zext i32 0 to i64
  store i64 %4, ptr %EAX-SKT-LOC, align 1
  %5 = zext i32 -1 to i64
  store i64 %5, ptr %R10D-SKT-LOC, align 1
  br label %bb.2

bb.2:                                             ; preds = %bb.1, %bb.2
  %6 = load i64, ptr %EAX-SKT-LOC, align 1
  %EAX = trunc i64 %6 to i32
  %EBX = xor i32 %EAX, 2147483647
  %7 = and i32 %EBX, 255
  %8 = call i32 @llvm.ctpop.i32(i32 %7)
  %9 = and i32 %8, 1
  %PF1 = icmp eq i32 %9, 0
  %ZF2 = icmp eq i32 %EBX, 0
  %highbit3 = and i32 -2147483648, %EBX
  %SF4 = icmp ne i32 %highbit3, 0
  %10 = zext i32 %EAX to i64
  %memref-idxreg = mul i64 4, %10
  %memref-basereg = add i64 %arg1, %memref-idxreg
  %11 = inttoptr i64 %memref-basereg to ptr
  store i32 %EBX, ptr %11, align 1
  %12 = zext i32 %EAX to i64
  %memref-idxreg5 = mul i64 4, %12
  %memref-basereg6 = add i64 %arg2, %memref-idxreg5
  %13 = load i64, ptr %R10D-SKT-LOC, align 1
  %R10D = trunc i64 %13 to i32
  %14 = inttoptr i64 %memref-basereg6 to ptr
  store i32 %R10D, ptr %14, align 1
  %memref-disp = add i32 %EAX, -32768
  %15 = zext i32 %EAX to i64
  %memref-idxreg7 = mul i64 2, %15
  %memref-basereg8 = add i64 %arg3, %memref-idxreg7
  %16 = trunc i32 %memref-disp to i16
  %17 = inttoptr i64 %memref-basereg8 to ptr
  store i16 %16, ptr %17, align 1
  %memref-disp9 = add i32 %EAX, -128
  %18 = zext i32 %EAX to i64
  %memref-basereg10 = add i64 %arg4, %18
  %19 = trunc i32 %memref-disp9 to i8
  %20 = inttoptr i64 %memref-basereg10 to ptr
  store i8 %19, ptr %20, align 1
  %RBX = zext i32 %EAX to i64
  %RBX15 = or i64 %RBX, -9223372036854775808
  %highbit11 = and i64 -9223372036854775808, %RBX15
  %SF12 = icmp ne i64 %highbit11, 0
  %ZF13 = icmp eq i64 %RBX15, 0
  %21 = and i64 %RBX15, 255
  %22 = call i64 @llvm.ctpop.i64(i64 %21)
  %23 = and i64 %22, 1
  %PF14 = icmp eq i64 %23, 0
  %24 = zext i32 %EAX to i64
  %memref-idxreg16 = mul i64 8, %24
  %memref-basereg17 = add i64 %arg5, %memref-idxreg16
  %25 = inttoptr i64 %memref-basereg17 to ptr
  store i64 %RBX15, ptr %25, align 1
  %26 = zext i32 %EAX to i64
  %RAX = add i64 %26, 1
  %27 = and i64 %RAX, 255
  %28 = call i64 @llvm.ctpop.i64(i64 %27)
  %29 = and i64 %28, 1
  %PF18 = icmp eq i64 %29, 0
  %ZF19 = icmp eq i64 %RAX, 0
  %highbit20 = and i64 -9223372036854775808, %RAX
  %SF21 = icmp ne i64 %highbit20, 0
  %R10D26 = sub i32 %R10D, 1
  %30 = and i32 %R10D26, 255
  %31 = call i32 @llvm.ctpop.i32(i32 %30)
  %32 = and i32 %31, 1
  %PF22 = icmp eq i32 %32, 0
  %ZF23 = icmp eq i32 %R10D26, 0
  %highbit24 = and i32 -2147483648, %R10D26
  %SF25 = icmp ne i32 %highbit24, 0
  %33 = zext i32 %arg6 to i64
  %34 = sub i64 %33, %RAX
  %35 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %33, i64 %RAX)
  %CF = extractvalue { i64, i1 } %35, 1
  %ZF27 = icmp eq i64 %34, 0
  %highbit28 = and i64 -9223372036854775808, %34
  %SF29 = icmp ne i64 %highbit28, 0
  %36 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %33, i64 %RAX)
  %OF = extractvalue { i64, i1 } %36, 1
  %37 = and i64 %34, 255
  %38 = call i64 @llvm.ctpop.i64(i64 %37)
  %39 = and i64 %38, 1
  %PF30 = icmp eq i64 %39, 0
  %CmpZF_JNE = icmp eq i1 %ZF27, false
  store i64 %RAX, ptr %EAX-SKT-LOC, align 1
  %40 = zext i32 %R10D26 to i64
  store i64 %40, ptr %R10D-SKT-LOC, align 1
  br i1 %CmpZF_JNE, label %bb.2, label %bb.3

bb.3:                                             ; preds = %bb.2, %entry
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
  %3 = zext i32 5 to i64
  %4 = zext i32 4 to i64
  %5 = call ptr @calloc(i64 %3, i64 %4)
  %RAX1 = ptrtoint ptr %5 to i64
  %6 = zext i32 5 to i64
  %7 = zext i32 2 to i64
  %8 = call ptr @calloc(i64 %6, i64 %7)
  %RAX2 = ptrtoint ptr %8 to i64
  %9 = zext i32 5 to i64
  %10 = zext i32 1 to i64
  %11 = call ptr @calloc(i64 %9, i64 %10)
  %RAX3 = ptrtoint ptr %11 to i64
  %12 = zext i32 5 to i64
  %13 = zext i32 8 to i64
  %14 = call ptr @calloc(i64 %12, i64 %13)
  %RAX4 = ptrtoint ptr %14 to i64
  %EAX = call i32 @foo(i64 %RAX, i64 %RAX1, i64 %RAX2, i64 %RAX3, i64 %RAX4, i32 5)
  %memload = load i32, ptr %2, align 1
  %15 = sub i32 %memload, 11
  %16 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload, i32 11)
  %CF = extractvalue { i32, i1 } %16, 1
  %ZF = icmp eq i32 %15, 0
  %highbit = and i32 -2147483648, %15
  %SF = icmp ne i32 %highbit, 0
  %17 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload, i32 11)
  %OF = extractvalue { i32, i1 } %17, 1
  %18 = and i32 %15, 255
  %19 = call i32 @llvm.ctpop.i32(i32 %18)
  %20 = and i32 %19, 1
  %PF = icmp eq i32 %20, 0
  %SFAndOF_JL = icmp ne i1 %SF, %OF
  br i1 %SFAndOF_JL, label %bb.2, label %bb.1

bb.1:                                             ; preds = %entry
  %memref-disp = add i64 %RAX, 4
  %21 = inttoptr i64 %memref-disp to ptr
  %memload5 = load i32, ptr %21, align 1
  %memref-disp6 = add i64 %RAX, 8
  %22 = inttoptr i64 %memref-disp6 to ptr
  %memload7 = load i32, ptr %22, align 1
  %memref-disp8 = add i64 %RAX, 12
  %23 = inttoptr i64 %memref-disp8 to ptr
  %memload9 = load i32, ptr %23, align 1
  %memref-disp10 = add i64 %RAX, 16
  %24 = inttoptr i64 %memref-disp10 to ptr
  %memload11 = load i32, ptr %24, align 1
  %EAX12 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 4), i32 %memload, i32 %memload5, i32 %memload7, i32 %memload9, i32 %memload11)
  br label %bb.2

bb.2:                                             ; preds = %bb.1, %entry
  %memload13 = load i32, ptr %5, align 1
  %memref-disp14 = add i64 %RAX1, 4
  %25 = inttoptr i64 %memref-disp14 to ptr
  %memload15 = load i32, ptr %25, align 1
  %memref-disp16 = add i64 %RAX1, 8
  %26 = inttoptr i64 %memref-disp16 to ptr
  %memload17 = load i32, ptr %26, align 1
  %memref-disp18 = add i64 %RAX1, 12
  %27 = inttoptr i64 %memref-disp18 to ptr
  %memload19 = load i32, ptr %27, align 1
  %memref-disp20 = add i64 %RAX1, 16
  %28 = inttoptr i64 %memref-disp20 to ptr
  %memload21 = load i32, ptr %28, align 1
  %EAX22 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 69), i32 %memload13, i32 %memload15, i32 %memload17, i32 %memload19, i32 %memload21)
  %memload23 = load i32, ptr %8, align 1
  %29 = trunc i32 %memload23 to i16
  %ESI = sext i16 %29 to i32
  %memref-disp24 = add i64 %RAX2, 2
  %30 = inttoptr i64 %memref-disp24 to ptr
  %memload25 = load i32, ptr %30, align 1
  %31 = trunc i32 %memload25 to i16
  %EDX = sext i16 %31 to i32
  %memref-disp26 = add i64 %RAX2, 4
  %32 = inttoptr i64 %memref-disp26 to ptr
  %memload27 = load i32, ptr %32, align 1
  %33 = trunc i32 %memload27 to i16
  %ECX = sext i16 %33 to i32
  %memref-disp28 = add i64 %RAX2, 6
  %34 = inttoptr i64 %memref-disp28 to ptr
  %memload29 = load i32, ptr %34, align 1
  %35 = trunc i32 %memload29 to i16
  %R8D = sext i16 %35 to i32
  %memref-disp30 = add i64 %RAX2, 8
  %36 = inttoptr i64 %memref-disp30 to ptr
  %memload31 = load i32, ptr %36, align 1
  %37 = trunc i32 %memload31 to i16
  %R9D = sext i16 %37 to i32
  %EAX32 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 139), i32 %ESI, i32 %EDX, i32 %ECX, i32 %R8D, i32 %R9D)
  %memload33 = load i32, ptr %11, align 1
  %38 = trunc i32 %memload33 to i8
  %ESI34 = sext i8 %38 to i32
  %memref-disp35 = add i64 %RAX3, 1
  %39 = inttoptr i64 %memref-disp35 to ptr
  %memload36 = load i32, ptr %39, align 1
  %40 = trunc i32 %memload36 to i8
  %EDX37 = sext i8 %40 to i32
  %memref-disp38 = add i64 %RAX3, 2
  %41 = inttoptr i64 %memref-disp38 to ptr
  %memload39 = load i32, ptr %41, align 1
  %42 = trunc i32 %memload39 to i8
  %ECX40 = sext i8 %42 to i32
  %memref-disp41 = add i64 %RAX3, 3
  %43 = inttoptr i64 %memref-disp41 to ptr
  %memload42 = load i32, ptr %43, align 1
  %44 = trunc i32 %memload42 to i8
  %R8D43 = sext i8 %44 to i32
  %memref-disp44 = add i64 %RAX3, 4
  %45 = inttoptr i64 %memref-disp44 to ptr
  %memload45 = load i32, ptr %45, align 1
  %46 = trunc i32 %memload45 to i8
  %R9D46 = sext i8 %46 to i32
  %EAX47 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 214), i32 %ESI34, i32 %EDX37, i32 %ECX40, i32 %R8D43, i32 %R9D46)
  %memload48 = load i64, ptr %14, align 1
  %memref-disp49 = add i64 %RAX4, 8
  %47 = inttoptr i64 %memref-disp49 to ptr
  %memload50 = load i64, ptr %47, align 1
  %memref-disp51 = add i64 %RAX4, 16
  %48 = inttoptr i64 %memref-disp51 to ptr
  %memload52 = load i64, ptr %48, align 1
  %memref-disp53 = add i64 %RAX4, 24
  %49 = inttoptr i64 %memref-disp53 to ptr
  %memload54 = load i64, ptr %49, align 1
  %memref-disp55 = add i64 %RAX4, 32
  %50 = inttoptr i64 %memref-disp55 to ptr
  %memload56 = load i64, ptr %50, align 1
  %EAX57 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 294), i64 %memload48, i64 %memload50, i64 %memload52, i64 %memload54, i64 %memload56)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.usub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4196160}
