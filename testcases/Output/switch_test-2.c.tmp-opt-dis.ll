; ModuleID = '/home/hxa/test/openai/testcases/Output/switch_test-2.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/switch_test-2.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [351 x i8] c"\01\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\C8\05@\00\00\00\00\00\C8\05@\00\00\00\00\00\C8\05@\00\00\00\00\00\DD\05@\00\00\00\00\00\DD\05@\00\00\00\00\00\C0\05@\00\00\00\00\00\C0\05@\00\00\00\00\00\E7\05@\00\00\00\00\00J\08@\00\00\00\00\00O\08@\00\00\00\00\00T\08@\00\00\00\00\00Y\08@\00\00\00\00\00^\08@\00\00\00\00\00g\08@\00\00\00\00\00p\08@\00\00\00\00\00y\08@\00\00\00\00\00\82\08@\00\00\00\00\00\8B\08@\00\00\00\00\00\94\08@\00\00\00\00\00\9D\08@\00\00\00\00\00\A6\08@\00\00\00\00\00\AF\08@\00\00\00\00\00\B8\08@\00\00\00\00\00\C1\08@\00\00\00\00\00buf = %x\0A\005012\001234\00-874\00+122\0035.54400\00.1234500\00-110.700\00+0.64400\005.500e+3\00-.123e-2\00-87e+832\00+0.6e-12\00T0.3e-1F\00-T.T++Tq\001T3.4e4z\0034.0e-T^\00Test\00", align 16, !ROData_SecInfo !0
@Dpat = internal global [4 x ptr] [ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 310), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 319), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 328), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 337)], align 16
@Cpat = internal global [4 x ptr] [ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 274), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 283), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 292), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 301)], align 16
@Bpat = internal global [4 x ptr] [ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 238), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 247), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 256), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 265)], align 16
@Apat = internal global [4 x ptr] [ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 218), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 223), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 228), ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 233)], align 16

declare dso_local ptr @malloc(i64)

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @call_func(i32 %arg1, i32 %arg2) {
entry:
  %R14-SKT-LOC = alloca i64, align 8
  %RSI-SKT-LOC41 = alloca i32, align 4
  %RSI-SKT-LOC = alloca i64, align 8
  %EAX-SKT-LOC = alloca i32, align 4
  %EDI-SKT-LOC = alloca i64, align 8
  %stktop_8 = alloca i8, i32 8, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  %0 = zext i32 4 to i64
  %1 = call ptr @malloc(i64 %0)
  %RAX = ptrtoint ptr %1 to i64
  %2 = sub i32 %arg1, 2
  %3 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %arg1, i32 2)
  %CF = extractvalue { i32, i1 } %3, 1
  %ZF = icmp eq i32 %2, 0
  %highbit = and i32 -2147483648, %2
  %SF = icmp ne i32 %highbit, 0
  %4 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %arg1, i32 2)
  %OF = extractvalue { i32, i1 } %4, 1
  %5 = and i32 %2, 255
  %6 = call i32 @llvm.ctpop.i32(i32 %5)
  %7 = and i32 %6, 1
  %PF = icmp eq i32 %7, 0
  %CmpCF_JB = icmp eq i1 %CF, true
  br i1 %CmpCF_JB, label %bb.7, label %bb.1

bb.1:                                             ; preds = %entry
  %8 = trunc i32 %arg2 to i16
  %EAX = zext i16 %8 to i32
  %ESI = and i32 %EAX, 7
  %9 = and i32 %ESI, 255
  %10 = call i32 @llvm.ctpop.i32(i32 %9)
  %11 = and i32 %10, 1
  %PF1 = icmp eq i32 %11, 0
  %ZF2 = icmp eq i32 %ESI, 0
  %highbit3 = and i32 -2147483648, %ESI
  %SF4 = icmp ne i32 %highbit3, 0
  %EAX8 = lshr i32 %EAX, 3
  %ZF5 = icmp eq i32 %EAX8, 0
  %highbit6 = and i32 -2147483648, %EAX8
  %SF7 = icmp ne i32 %highbit6, 0
  %EAX13 = and i32 %EAX8, 3
  %12 = and i32 %EAX13, 255
  %13 = call i32 @llvm.ctpop.i32(i32 %12)
  %14 = and i32 %13, 1
  %PF9 = icmp eq i32 %14, 0
  %ZF10 = icmp eq i32 %EAX13, 0
  %highbit11 = and i32 -2147483648, %EAX13
  %SF12 = icmp ne i32 %highbit11, 0
  %15 = zext i32 %EAX13 to i64
  %memref-idxreg = mul i64 8, %15
  %16 = bitcast ptr @Dpat to ptr
  %17 = getelementptr inbounds [0 x i64], ptr %16, i32 0, i32 0
  %18 = bitcast ptr %16 to ptr
  %19 = getelementptr inbounds [0 x i8], ptr %18, i32 0, i32 0
  %20 = ptrtoint ptr %19 to i64
  %memref-disp = add i64 %memref-idxreg, %20
  %21 = zext i32 %EAX13 to i64
  %memref-idxreg14 = mul i64 8, %21
  %22 = bitcast ptr @Cpat to ptr
  %23 = getelementptr inbounds [0 x i64], ptr %22, i32 0, i32 0
  %24 = bitcast ptr %22 to ptr
  %25 = getelementptr inbounds [0 x i8], ptr %24, i32 0, i32 0
  %26 = ptrtoint ptr %25 to i64
  %memref-disp15 = add i64 %memref-idxreg14, %26
  %27 = zext i32 %EAX13 to i64
  %memref-idxreg16 = mul i64 8, %27
  %28 = bitcast ptr @Bpat to ptr
  %29 = getelementptr inbounds [0 x i64], ptr %28, i32 0, i32 0
  %30 = bitcast ptr %28 to ptr
  %31 = getelementptr inbounds [0 x i8], ptr %30, i32 0, i32 0
  %32 = ptrtoint ptr %31 to i64
  %memref-disp17 = add i64 %memref-idxreg16, %32
  %33 = zext i32 %EAX13 to i64
  %memref-idxreg18 = mul i64 8, %33
  %34 = bitcast ptr @Apat to ptr
  %35 = getelementptr inbounds [0 x i64], ptr %34, i32 0, i32 0
  %36 = bitcast ptr %34 to ptr
  %37 = getelementptr inbounds [0 x i8], ptr %36, i32 0, i32 0
  %38 = ptrtoint ptr %37 to i64
  %memref-disp19 = add i64 %memref-idxreg18, %38
  %39 = zext i32 %ESI to i64
  %memref-idxreg20 = mul i64 8, %39
  %40 = ptrtoint ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 16) to i64, !ROData_Index !1
  %memref-disp21 = add i64 %memref-idxreg20, %40, !ROData_Index !1
  %41 = inttoptr i64 %memref-disp21 to ptr, !ROData_Index !1
  %memload = load i64, ptr %41, align 1, !ROData_Content !2
  %42 = zext i32 0 to i64
  store i64 %42, ptr %EDI-SKT-LOC, align 1
  br label %bb.4

bb.4:                                             ; preds = %bb.3, %bb.1
  store i32 4, ptr %EAX-SKT-LOC, align 1
  store i64 %memref-disp19, ptr %RSI-SKT-LOC, align 1
  switch i32 %arg2, label %bb.3 [
    i32 0, label %bb.3
    i32 1, label %bb.3
    i32 2, label %bb.3
    i32 3, label %bb.5
    i32 4, label %bb.5
    i32 5, label %bb.2
    i32 6, label %bb.2
    i32 7, label %bb.6
  ]

bb.6:                                             ; preds = %bb.4
  store i32 8, ptr %EAX-SKT-LOC, align 1
  store i64 %memref-disp, ptr %RSI-SKT-LOC, align 1
  br label %bb.3

bb.2:                                             ; preds = %bb.4, %bb.4
  store i32 8, ptr %EAX-SKT-LOC, align 1
  store i64 %memref-disp15, ptr %RSI-SKT-LOC, align 1
  br label %bb.3

bb.5:                                             ; preds = %bb.4, %bb.4
  store i32 8, ptr %EAX-SKT-LOC, align 1
  store i64 %memref-disp17, ptr %RSI-SKT-LOC, align 1
  br label %bb.3

bb.3:                                             ; preds = %bb.2, %bb.5, %bb.6, %bb.4, %bb.4, %bb.4, %bb.4
  %43 = load i64, ptr %EDI-SKT-LOC, align 1
  %EDI = trunc i64 %43 to i32
  %EAX22 = load i32, ptr %EAX-SKT-LOC, align 1
  %EDI26 = add nsw i32 %EDI, %EAX22
  %highbit23 = and i32 -2147483648, %EDI26
  %SF24 = icmp ne i32 %highbit23, 0
  %ZF25 = icmp eq i32 %EDI26, 0
  %EAX31 = or i32 %EDI26, 1
  %44 = and i32 %EAX31, 255
  %45 = call i32 @llvm.ctpop.i32(i32 %44)
  %46 = and i32 %45, 1
  %PF27 = icmp eq i32 %46, 0
  %ZF28 = icmp eq i32 %EAX31, 0
  %highbit29 = and i32 -2147483648, %EAX31
  %SF30 = icmp ne i32 %highbit29, 0
  %47 = sub i32 %EAX31, %arg1
  %48 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %EAX31, i32 %arg1)
  %CF32 = extractvalue { i32, i1 } %48, 1
  %ZF33 = icmp eq i32 %47, 0
  %highbit34 = and i32 -2147483648, %47
  %SF35 = icmp ne i32 %highbit34, 0
  %49 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %EAX31, i32 %arg1)
  %OF36 = extractvalue { i32, i1 } %49, 1
  %50 = and i32 %47, 255
  %51 = call i32 @llvm.ctpop.i32(i32 %50)
  %52 = and i32 %51, 1
  %PF37 = icmp eq i32 %52, 0
  %CFCmp_JAE = icmp eq i1 %CF32, false
  %53 = zext i32 %EDI26 to i64
  store i64 %53, ptr %EDI-SKT-LOC, align 1
  br i1 %CFCmp_JAE, label %bb.8, label %bb.4

bb.8:                                             ; preds = %bb.3
  %RSI = load i64, ptr %RSI-SKT-LOC, align 1
  %54 = inttoptr i64 %RSI to ptr
  %memload38 = load i64, ptr %54, align 1
  %55 = inttoptr i64 %memload38 to ptr
  %memload39 = load i32, ptr %55, align 1
  %56 = trunc i32 %memload39 to i8
  %ESI40 = zext i8 %56 to i32
  store i32 %ESI40, ptr %RSI-SKT-LOC41, align 1
  store i64 %memload38, ptr %R14-SKT-LOC, align 1
  br label %bb.9

bb.7:                                             ; preds = %entry
  store i32 0, ptr %RSI-SKT-LOC41, align 1
  store i64 %RAX, ptr %R14-SKT-LOC, align 1
  br label %bb.9

bb.9:                                             ; preds = %bb.8, %bb.7
  %57 = load i32, ptr %RSI-SKT-LOC41, align 1
  %RSI42 = zext i32 %57 to i64
  %EAX43 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 208), i64 %RSI42)
  %R14 = load i64, ptr %R14-SKT-LOC, align 1
  %memref-disp44 = add i64 %R14, 1
  %58 = inttoptr i64 %memref-disp44 to ptr
  %memload45 = load i32, ptr %58, align 1
  %59 = trunc i32 %memload45 to i8
  %ESI46 = zext i8 %59 to i32
  %EAX47 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI46)
  %memref-disp48 = add i64 %R14, 2
  %60 = inttoptr i64 %memref-disp48 to ptr
  %memload49 = load i32, ptr %60, align 1
  %61 = trunc i32 %memload49 to i8
  %ESI50 = zext i8 %61 to i32
  %EAX51 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI50)
  %memref-disp52 = add i64 %R14, 3
  %62 = inttoptr i64 %memref-disp52 to ptr
  %memload53 = load i32, ptr %62, align 1
  %63 = trunc i32 %memload53 to i8
  %ESI54 = zext i8 %63 to i32
  %EAX55 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI54)
  ret i32 1
}

declare dso_local i32 @puts(ptr)

define dso_local i32 @main() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %EAX = call i32 @call_func(i32 66, i32 0)
  %EAX1 = call i32 @call_func(i32 66, i32 1)
  %EAX2 = call i32 @call_func(i32 66, i32 2)
  %EAX3 = call i32 @call_func(i32 66, i32 3)
  %EAX4 = call i32 @call_func(i32 66, i32 4)
  %EAX5 = call i32 @call_func(i32 66, i32 5)
  %EAX6 = call i32 @call_func(i32 66, i32 6)
  %EAX7 = call i32 @call_func(i32 66, i32 7)
  %EAX8 = call i32 @call_func(i32 66, i32 8)
  %EAX9 = call i32 @puts(ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 346))
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4196208}
!1 = !{ptr getelementptr inbounds ([351 x i8], ptr @rodata_14, i32 0, i32 16)}
!2 = !{!1}
