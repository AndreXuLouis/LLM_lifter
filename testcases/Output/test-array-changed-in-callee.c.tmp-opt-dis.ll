; ModuleID = '/home/hxa/test/openai/testcases/Output/test-array-changed-in-callee.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/test-array-changed-in-callee.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [369 x i8] c"\01\00\02\00arr[0] = %d, arr[1] = %d, arr[2] = %d, arr[3] = %d, arr[4] = %d\0A\00arr1[0] = %u, arr1[1] = %u, arr1[2] = %u, arr1[3] = %u, arr1[4] = %u\0A\00arr2[0] = %hd, arr2[1] = %hd, arr2[2] = %hd, arr2[3] = %hd, arr2[4] = %hd\0A\00arr3[0] = %hhd, arr3[1] = %hhd, arr3[2] = %hhd, arr3[3] = %hhd, arr3[4] = %hhd\0A\00arr4[0] = %ld, arr4[1] = %ld, arr4[2] = %ld, arr4[3] = %ld, arr4[4] = %ld\0A\00", align 4, !ROData_SecInfo !0

define dso_local i32 @foo(i64 %arg1, i64 %arg2, i64 %arg3, i64 %arg4, i64 %arg5, i32 %arg6) {
entry:
  %stktop_4 = alloca i8, i32 56, align 1
  %tos = ptrtoint ptr %stktop_4 to i64
  %0 = add i64 %tos, 12
  %RBP_N.44 = inttoptr i64 %0 to ptr
  %1 = add i64 %tos, 16
  %RBP_N.40 = inttoptr i64 %1 to ptr
  %2 = add i64 %tos, 24
  %RBP_N.32 = inttoptr i64 %2 to ptr
  %3 = add i64 %tos, 32
  %RBP_N.24 = inttoptr i64 %3 to ptr
  %4 = add i64 %tos, 40
  %RBP_N.16 = inttoptr i64 %4 to ptr
  %5 = add i64 %tos, 48
  %RBP_N.8 = inttoptr i64 %5 to ptr
  %6 = add i64 %tos, 0
  %RSP_P.0 = inttoptr i64 %6 to ptr
  store i64 3735928559, ptr %RSP_P.0, align 8
  %RBP = ptrtoint ptr %RSP_P.0 to i64
  store i64 %arg1, ptr %RBP_N.8, align 1
  store i64 %arg2, ptr %RBP_N.16, align 1
  store i64 %arg3, ptr %RBP_N.24, align 1
  store i64 %arg4, ptr %RBP_N.32, align 1
  store i64 %arg5, ptr %RBP_N.40, align 1
  store i32 %arg6, ptr %RBP_N.44, align 1
  store i32 0, ptr %stktop_4, align 1
  br label %bb.1

bb.1:                                             ; preds = %entry, %bb.2
  %memload = load i32, ptr %stktop_4, align 1
  %7 = load i32, ptr %RBP_N.44, align 1
  %8 = sub i32 %memload, %7
  %9 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload, i32 %7)
  %CF = extractvalue { i32, i1 } %9, 1
  %ZF = icmp eq i32 %8, 0
  %highbit = and i32 -2147483648, %8
  %SF = icmp ne i32 %highbit, 0
  %10 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload, i32 %7)
  %OF = extractvalue { i32, i1 } %10, 1
  %11 = and i32 %8, 255
  %12 = call i32 @llvm.ctpop.i32(i32 %11)
  %13 = and i32 %12, 1
  %PF = icmp eq i32 %13, 0
  %CmpSFOF_JGE = icmp eq i1 %SF, %OF
  br i1 %CmpSFOF_JGE, label %bb.3, label %bb.2

bb.2:                                             ; preds = %bb.1
  %14 = load i32, ptr %stktop_4, align 1
  %EDX = sub i32 2147483647, %14
  %15 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 2147483647, i32 %14)
  %CF1 = extractvalue { i32, i1 } %15, 1
  %ZF2 = icmp eq i32 %EDX, 0
  %highbit3 = and i32 -2147483648, %EDX
  %SF4 = icmp ne i32 %highbit3, 0
  %16 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 2147483647, i32 %14)
  %OF5 = extractvalue { i32, i1 } %16, 1
  %17 = and i32 %EDX, 255
  %18 = call i32 @llvm.ctpop.i32(i32 %17)
  %19 = and i32 %18, 1
  %PF6 = icmp eq i32 %19, 0
  %memload7 = load i64, ptr %RBP_N.8, align 1
  %memload8 = load i64, ptr %stktop_4, align 1
  %20 = trunc i64 %memload8 to i32
  %RCX = sext i32 %20 to i64
  %memref-idxreg = mul i64 4, %RCX
  %memref-basereg = add i64 %memload7, %memref-idxreg
  %21 = inttoptr i64 %memref-basereg to ptr
  store i32 %EDX, ptr %21, align 1
  %22 = load i32, ptr %stktop_4, align 1
  %EDX9 = sub i32 -1, %22
  %23 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 -1, i32 %22)
  %CF10 = extractvalue { i32, i1 } %23, 1
  %ZF11 = icmp eq i32 %EDX9, 0
  %highbit12 = and i32 -2147483648, %EDX9
  %SF13 = icmp ne i32 %highbit12, 0
  %24 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 -1, i32 %22)
  %OF14 = extractvalue { i32, i1 } %24, 1
  %25 = and i32 %EDX9, 255
  %26 = call i32 @llvm.ctpop.i32(i32 %25)
  %27 = and i32 %26, 1
  %PF15 = icmp eq i32 %27, 0
  %memload16 = load i64, ptr %RBP_N.16, align 1
  %memload17 = load i64, ptr %stktop_4, align 1
  %28 = trunc i64 %memload17 to i32
  %RCX18 = sext i32 %28 to i64
  %memref-idxreg19 = mul i64 4, %RCX18
  %memref-basereg20 = add i64 %memload16, %memref-idxreg19
  %29 = inttoptr i64 %memref-basereg20 to ptr
  store i32 %EDX9, ptr %29, align 1
  %memload21 = load i32, ptr %stktop_4, align 1
  %EAX = add i32 %memload21, -32768
  %30 = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 %memload21, i32 -32768)
  %CF22 = extractvalue { i32, i1 } %30, 1
  %31 = and i32 %EAX, 255
  %32 = call i32 @llvm.ctpop.i32(i32 %31)
  %33 = and i32 %32, 1
  %PF23 = icmp eq i32 %33, 0
  %ZF24 = icmp eq i32 %EAX, 0
  %highbit25 = and i32 -2147483648, %EAX
  %SF26 = icmp ne i32 %highbit25, 0
  %34 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %memload21, i32 -32768)
  %OF27 = extractvalue { i32, i1 } %34, 1
  %DX = trunc i32 %EAX to i16
  %memload28 = load i64, ptr %RBP_N.24, align 1
  %memload29 = load i64, ptr %stktop_4, align 1
  %35 = trunc i64 %memload29 to i32
  %RCX30 = sext i32 %35 to i64
  %memref-idxreg31 = mul i64 2, %RCX30
  %memref-basereg32 = add i64 %memload28, %memref-idxreg31
  %36 = inttoptr i64 %memref-basereg32 to ptr
  store i16 %DX, ptr %36, align 1
  %memload33 = load i32, ptr %stktop_4, align 1
  %EAX40 = add i32 %memload33, -128
  %37 = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 %memload33, i32 -128)
  %CF34 = extractvalue { i32, i1 } %37, 1
  %38 = and i32 %EAX40, 255
  %39 = call i32 @llvm.ctpop.i32(i32 %38)
  %40 = and i32 %39, 1
  %PF35 = icmp eq i32 %40, 0
  %ZF36 = icmp eq i32 %EAX40, 0
  %highbit37 = and i32 -2147483648, %EAX40
  %SF38 = icmp ne i32 %highbit37, 0
  %41 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %memload33, i32 -128)
  %OF39 = extractvalue { i32, i1 } %41, 1
  %DL = trunc i32 %EAX40 to i8
  %memload41 = load i64, ptr %RBP_N.32, align 1
  %memload42 = load i64, ptr %stktop_4, align 1
  %42 = trunc i64 %memload42 to i32
  %RCX43 = sext i32 %42 to i64
  %memref-basereg44 = add i64 %memload41, %RCX43
  %43 = inttoptr i64 %memref-basereg44 to ptr
  store i8 %DL, ptr %43, align 1
  %memload45 = load i64, ptr %stktop_4, align 1
  %44 = trunc i64 %memload45 to i32
  %RDX = sext i32 %44 to i64
  %RDX49 = add nsw i64 %RDX, -9223372036854775808
  %highbit46 = and i64 -9223372036854775808, %RDX49
  %SF47 = icmp ne i64 %highbit46, 0
  %ZF48 = icmp eq i64 %RDX49, 0
  %memload50 = load i64, ptr %RBP_N.40, align 1
  %memload51 = load i64, ptr %stktop_4, align 1
  %45 = trunc i64 %memload51 to i32
  %RCX52 = sext i32 %45 to i64
  %memref-idxreg53 = mul i64 8, %RCX52
  %memref-basereg54 = add i64 %memload50, %memref-idxreg53
  %46 = inttoptr i64 %memref-basereg54 to ptr
  store i64 %RDX49, ptr %46, align 1
  %memload55 = load i32, ptr %stktop_4, align 1
  %EAX62 = add i32 %memload55, 1
  %47 = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 %memload55, i32 1)
  %CF56 = extractvalue { i32, i1 } %47, 1
  %48 = and i32 %EAX62, 255
  %49 = call i32 @llvm.ctpop.i32(i32 %48)
  %50 = and i32 %49, 1
  %PF57 = icmp eq i32 %50, 0
  %ZF58 = icmp eq i32 %EAX62, 0
  %highbit59 = and i32 -2147483648, %EAX62
  %SF60 = icmp ne i32 %highbit59, 0
  %51 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %memload55, i32 1)
  %OF61 = extractvalue { i32, i1 } %51, 1
  store i32 %EAX62, ptr %stktop_4, align 1
  br label %bb.1

bb.3:                                             ; preds = %bb.1
  ret i32 0
}

declare dso_local ptr @calloc(i64, i64)

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @main() {
entry:
  %stktop_8 = alloca i8, i32 56, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  %0 = add i64 %tos, 16
  %RBP_N.40 = inttoptr i64 %0 to ptr
  %1 = add i64 %tos, 24
  %RBP_N.32 = inttoptr i64 %1 to ptr
  %2 = add i64 %tos, 32
  %RBP_N.24 = inttoptr i64 %2 to ptr
  %3 = add i64 %tos, 40
  %RBP_N.16 = inttoptr i64 %3 to ptr
  %4 = add i64 %tos, 48
  %RBP_N.8 = inttoptr i64 %4 to ptr
  %5 = add i64 %tos, 52
  %RBP_N.4 = inttoptr i64 %5 to ptr
  %6 = add i64 %tos, 0
  %RSP_P.0 = inttoptr i64 %6 to ptr
  store i64 3735928559, ptr %RSP_P.0, align 8
  %RBP = ptrtoint ptr %RSP_P.0 to i64
  store i32 0, ptr %RBP_N.4, align 1
  store i32 5, ptr %RBP_N.8, align 1
  %7 = zext i32 5 to i64
  %8 = zext i32 4 to i64
  %9 = call ptr @calloc(i64 %7, i64 %8)
  %RAX = ptrtoint ptr %9 to i64
  store i64 %RAX, ptr %RBP_N.16, align 1
  %10 = zext i32 5 to i64
  %11 = zext i32 4 to i64
  %12 = call ptr @calloc(i64 %10, i64 %11)
  %RAX1 = ptrtoint ptr %12 to i64
  store i64 %RAX1, ptr %RBP_N.24, align 1
  %13 = zext i32 5 to i64
  %14 = zext i32 2 to i64
  %15 = call ptr @calloc(i64 %13, i64 %14)
  %RAX2 = ptrtoint ptr %15 to i64
  store i64 %RAX2, ptr %RBP_N.32, align 1
  %16 = zext i32 5 to i64
  %17 = zext i32 1 to i64
  %18 = call ptr @calloc(i64 %16, i64 %17)
  %RAX3 = ptrtoint ptr %18 to i64
  store i64 %RAX3, ptr %RBP_N.40, align 1
  %19 = zext i32 5 to i64
  %20 = zext i32 8 to i64
  %21 = call ptr @calloc(i64 %19, i64 %20)
  %RAX4 = ptrtoint ptr %21 to i64
  store i64 %RAX4, ptr %stktop_8, align 1
  %memload = load i64, ptr %RBP_N.16, align 1
  %memload5 = load i64, ptr %RBP_N.24, align 1
  %memload6 = load i64, ptr %RBP_N.32, align 1
  %memload7 = load i64, ptr %RBP_N.40, align 1
  %memload8 = load i64, ptr %stktop_8, align 1
  %EAX = call i32 @foo(i64 %memload, i64 %memload5, i64 %memload6, i64 %memload7, i64 %memload8, i32 5)
  %memload9 = load i64, ptr %RBP_N.16, align 1
  %22 = inttoptr i64 %memload9 to ptr
  %23 = load i32, ptr %22, align 1
  %24 = zext i32 %23 to i64
  %25 = zext i32 10 to i64
  %26 = sub i64 %24, %25
  %27 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %24, i64 %25)
  %CF = extractvalue { i64, i1 } %27, 1
  %ZF = icmp eq i64 %26, 0
  %highbit = and i64 -9223372036854775808, %26
  %SF = icmp ne i64 %highbit, 0
  %28 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %24, i64 %25)
  %OF = extractvalue { i64, i1 } %28, 1
  %29 = and i64 %26, 255
  %30 = call i64 @llvm.ctpop.i64(i64 %29)
  %31 = and i64 %30, 1
  %PF = icmp eq i64 %31, 0
  %CmpZF_JLE = icmp eq i1 %ZF, true
  %CmpOF_JLE = icmp ne i1 %SF, %OF
  %ZFOrSF_JLE = or i1 %CmpZF_JLE, %CmpOF_JLE
  br i1 %ZFOrSF_JLE, label %bb.2, label %bb.1

bb.1:                                             ; preds = %entry
  %memload10 = load i64, ptr %RBP_N.16, align 1
  %32 = inttoptr i64 %memload10 to ptr
  %memload11 = load i32, ptr %32, align 1
  %memload12 = load i64, ptr %RBP_N.16, align 1
  %memref-disp = add i64 %memload12, 4
  %33 = inttoptr i64 %memref-disp to ptr
  %memload13 = load i32, ptr %33, align 1
  %memload14 = load i64, ptr %RBP_N.16, align 1
  %memref-disp15 = add i64 %memload14, 8
  %34 = inttoptr i64 %memref-disp15 to ptr
  %memload16 = load i32, ptr %34, align 1
  %memload17 = load i64, ptr %RBP_N.16, align 1
  %memref-disp18 = add i64 %memload17, 12
  %35 = inttoptr i64 %memref-disp18 to ptr
  %memload19 = load i32, ptr %35, align 1
  %memload20 = load i64, ptr %RBP_N.16, align 1
  %memref-disp21 = add i64 %memload20, 16
  %36 = inttoptr i64 %memref-disp21 to ptr
  %memload22 = load i32, ptr %36, align 1
  %EAX23 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 4), i32 %memload11, i32 %memload13, i32 %memload16, i32 %memload19, i32 %memload22)
  br label %bb.2

bb.2:                                             ; preds = %bb.1, %entry
  %memload24 = load i64, ptr %RBP_N.24, align 1
  %37 = inttoptr i64 %memload24 to ptr
  %memload25 = load i32, ptr %37, align 1
  %memload26 = load i64, ptr %RBP_N.24, align 1
  %memref-disp27 = add i64 %memload26, 4
  %38 = inttoptr i64 %memref-disp27 to ptr
  %memload28 = load i32, ptr %38, align 1
  %memload29 = load i64, ptr %RBP_N.24, align 1
  %memref-disp30 = add i64 %memload29, 8
  %39 = inttoptr i64 %memref-disp30 to ptr
  %memload31 = load i32, ptr %39, align 1
  %memload32 = load i64, ptr %RBP_N.24, align 1
  %memref-disp33 = add i64 %memload32, 12
  %40 = inttoptr i64 %memref-disp33 to ptr
  %memload34 = load i32, ptr %40, align 1
  %memload35 = load i64, ptr %RBP_N.24, align 1
  %memref-disp36 = add i64 %memload35, 16
  %41 = inttoptr i64 %memref-disp36 to ptr
  %memload37 = load i32, ptr %41, align 1
  %EAX38 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 69), i32 %memload25, i32 %memload28, i32 %memload31, i32 %memload34, i32 %memload37)
  %memload39 = load i64, ptr %RBP_N.32, align 1
  %42 = inttoptr i64 %memload39 to ptr
  %memload40 = load i32, ptr %42, align 1
  %43 = trunc i32 %memload40 to i16
  %ESI = sext i16 %43 to i32
  %memload41 = load i64, ptr %RBP_N.32, align 1
  %memref-disp42 = add i64 %memload41, 2
  %44 = inttoptr i64 %memref-disp42 to ptr
  %memload43 = load i32, ptr %44, align 1
  %45 = trunc i32 %memload43 to i16
  %EDX = sext i16 %45 to i32
  %memload44 = load i64, ptr %RBP_N.32, align 1
  %memref-disp45 = add i64 %memload44, 4
  %46 = inttoptr i64 %memref-disp45 to ptr
  %memload46 = load i32, ptr %46, align 1
  %47 = trunc i32 %memload46 to i16
  %ECX = sext i16 %47 to i32
  %memload47 = load i64, ptr %RBP_N.32, align 1
  %memref-disp48 = add i64 %memload47, 6
  %48 = inttoptr i64 %memref-disp48 to ptr
  %memload49 = load i32, ptr %48, align 1
  %49 = trunc i32 %memload49 to i16
  %R8D = sext i16 %49 to i32
  %memload50 = load i64, ptr %RBP_N.32, align 1
  %memref-disp51 = add i64 %memload50, 8
  %50 = inttoptr i64 %memref-disp51 to ptr
  %memload52 = load i32, ptr %50, align 1
  %51 = trunc i32 %memload52 to i16
  %R9D = sext i16 %51 to i32
  %EAX53 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 139), i32 %ESI, i32 %EDX, i32 %ECX, i32 %R8D, i32 %R9D)
  %memload54 = load i64, ptr %RBP_N.40, align 1
  %52 = inttoptr i64 %memload54 to ptr
  %memload55 = load i32, ptr %52, align 1
  %53 = trunc i32 %memload55 to i8
  %ESI56 = sext i8 %53 to i32
  %memload57 = load i64, ptr %RBP_N.40, align 1
  %memref-disp58 = add i64 %memload57, 1
  %54 = inttoptr i64 %memref-disp58 to ptr
  %memload59 = load i32, ptr %54, align 1
  %55 = trunc i32 %memload59 to i8
  %EDX60 = sext i8 %55 to i32
  %memload61 = load i64, ptr %RBP_N.40, align 1
  %memref-disp62 = add i64 %memload61, 2
  %56 = inttoptr i64 %memref-disp62 to ptr
  %memload63 = load i32, ptr %56, align 1
  %57 = trunc i32 %memload63 to i8
  %ECX64 = sext i8 %57 to i32
  %memload65 = load i64, ptr %RBP_N.40, align 1
  %memref-disp66 = add i64 %memload65, 3
  %58 = inttoptr i64 %memref-disp66 to ptr
  %memload67 = load i32, ptr %58, align 1
  %59 = trunc i32 %memload67 to i8
  %R8D68 = sext i8 %59 to i32
  %memload69 = load i64, ptr %RBP_N.40, align 1
  %memref-disp70 = add i64 %memload69, 4
  %60 = inttoptr i64 %memref-disp70 to ptr
  %memload71 = load i32, ptr %60, align 1
  %61 = trunc i32 %memload71 to i8
  %R9D72 = sext i8 %61 to i32
  %EAX73 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 214), i32 %ESI56, i32 %EDX60, i32 %ECX64, i32 %R8D68, i32 %R9D72)
  %memload74 = load i64, ptr %stktop_8, align 1
  %62 = inttoptr i64 %memload74 to ptr
  %memload75 = load i64, ptr %62, align 1
  %memload76 = load i64, ptr %stktop_8, align 1
  %memref-disp77 = add i64 %memload76, 8
  %63 = inttoptr i64 %memref-disp77 to ptr
  %memload78 = load i64, ptr %63, align 1
  %memload79 = load i64, ptr %stktop_8, align 1
  %memref-disp80 = add i64 %memload79, 16
  %64 = inttoptr i64 %memref-disp80 to ptr
  %memload81 = load i64, ptr %64, align 1
  %memload82 = load i64, ptr %stktop_8, align 1
  %memref-disp83 = add i64 %memload82, 24
  %65 = inttoptr i64 %memref-disp83 to ptr
  %memload84 = load i64, ptr %65, align 1
  %memload85 = load i64, ptr %stktop_8, align 1
  %memref-disp86 = add i64 %memload85, 32
  %66 = inttoptr i64 %memref-disp86 to ptr
  %memload87 = load i64, ptr %66, align 1
  %EAX88 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([369 x i8], ptr @rodata_14, i32 0, i32 294), i64 %memload75, i64 %memload78, i64 %memload81, i64 %memload84, i64 %memload87)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.uadd.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.usub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4196368}
