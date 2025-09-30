; ModuleID = '/home/hxa/test/openai/testcases/Output/retain-spill-stack-slot.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/retain-spill-stack-slot.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [176 x i8] c"\01\00\02\00a[0] = %d, a[1] = %d, a[2] = %d, a[3] = %d, a[4] = %d\0A\00arr[0] = %d\0A\00arr[1] = %d\0A\00arr[2] = %d\0A\00arr[3] = %d\0A\00arr[0] = %d, arr[1] = %d, arr[2] = %d, arr[3] = %d, arr[4] = %d\0A\00", align 4, !ROData_SecInfo !0

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @foo(i64 %arg1) {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %0 = inttoptr i64 %arg1 to ptr
  store i64 21474836484, ptr %0, align 1
  %memref-disp = add i64 %arg1, 8
  %1 = inttoptr i64 %memref-disp to ptr
  store i64 30064771078, ptr %1, align 1
  %memref-disp1 = add i64 %arg1, 16
  %2 = inttoptr i64 %memref-disp1 to ptr
  store i32 8, ptr %2, align 1
  %EAX = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([176 x i8], ptr @rodata_14, i32 0, i32 4), i32 4, i32 5, i32 6, i32 7, i32 8)
  ret i32 0
}

define dso_local i32 @main() {
entry:
  %stktop_8 = alloca i8, i32 52, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  %0 = add i64 %tos, 0
  %RSP_P.0 = inttoptr i64 %0 to ptr
  %1 = add i64 %tos, 8
  %RSP_P.8 = inttoptr i64 %1 to ptr
  %2 = add i64 %tos, 16
  %RSP_P.16 = inttoptr i64 %2 to ptr
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i32 0, ptr %RSP_P.16, align 1
  %3 = sext i32 0 to i64
  store i64 %3, ptr %RSP_P.8, align 1
  %4 = sext i32 0 to i64
  store i64 %4, ptr %stktop_8, align 1
  %RDI = ptrtoint ptr %stktop_8 to i64
  %EAX = call i32 @foo(i64 %RDI)
  %memload = load i32, ptr %stktop_8, align 1
  %5 = sub i32 %memload, 4
  %6 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload, i32 4)
  %CF = extractvalue { i32, i1 } %6, 1
  %ZF = icmp eq i32 %5, 0
  %highbit = and i32 -2147483648, %5
  %SF = icmp ne i32 %highbit, 0
  %7 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload, i32 4)
  %OF = extractvalue { i32, i1 } %7, 1
  %8 = and i32 %5, 255
  %9 = call i32 @llvm.ctpop.i32(i32 %8)
  %10 = and i32 %9, 1
  %PF = icmp eq i32 %10, 0
  %SFAndOF_JL = icmp ne i1 %SF, %OF
  br i1 %SFAndOF_JL, label %bb.2, label %bb.1

bb.1:                                             ; preds = %entry
  %EAX1 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([176 x i8], ptr @rodata_14, i32 0, i32 59), i32 %memload)
  br label %bb.2

bb.2:                                             ; preds = %bb.1, %entry
  %11 = getelementptr i8, ptr %RSP_P.0, i64 4
  %memload2 = load i32, ptr %11, align 1
  %12 = sub i32 %memload2, 5
  %13 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload2, i32 5)
  %CF3 = extractvalue { i32, i1 } %13, 1
  %ZF4 = icmp eq i32 %12, 0
  %highbit5 = and i32 -2147483648, %12
  %SF6 = icmp ne i32 %highbit5, 0
  %14 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload2, i32 5)
  %OF7 = extractvalue { i32, i1 } %14, 1
  %15 = and i32 %12, 255
  %16 = call i32 @llvm.ctpop.i32(i32 %15)
  %17 = and i32 %16, 1
  %PF8 = icmp eq i32 %17, 0
  %SFAndOF_JL35 = icmp ne i1 %SF6, %OF7
  br i1 %SFAndOF_JL35, label %bb.4, label %bb.3

bb.3:                                             ; preds = %bb.2
  %EAX9 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([176 x i8], ptr @rodata_14, i32 0, i32 72), i32 %memload2)
  br label %bb.4

bb.4:                                             ; preds = %bb.3, %bb.2
  %memload10 = load i32, ptr %RSP_P.8, align 1
  %18 = sub i32 %memload10, 6
  %19 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload10, i32 6)
  %CF11 = extractvalue { i32, i1 } %19, 1
  %ZF12 = icmp eq i32 %18, 0
  %highbit13 = and i32 -2147483648, %18
  %SF14 = icmp ne i32 %highbit13, 0
  %20 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload10, i32 6)
  %OF15 = extractvalue { i32, i1 } %20, 1
  %21 = and i32 %18, 255
  %22 = call i32 @llvm.ctpop.i32(i32 %21)
  %23 = and i32 %22, 1
  %PF16 = icmp eq i32 %23, 0
  %SFAndOF_JL36 = icmp ne i1 %SF14, %OF15
  br i1 %SFAndOF_JL36, label %bb.6, label %bb.5

bb.5:                                             ; preds = %bb.4
  %EAX17 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([176 x i8], ptr @rodata_14, i32 0, i32 85), i32 %memload10)
  br label %bb.6

bb.6:                                             ; preds = %bb.5, %bb.4
  %24 = getelementptr i8, ptr %RSP_P.8, i64 4
  %memload18 = load i32, ptr %24, align 1
  %25 = sub i32 %memload18, 7
  %26 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload18, i32 7)
  %CF19 = extractvalue { i32, i1 } %26, 1
  %ZF20 = icmp eq i32 %25, 0
  %highbit21 = and i32 -2147483648, %25
  %SF22 = icmp ne i32 %highbit21, 0
  %27 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload18, i32 7)
  %OF23 = extractvalue { i32, i1 } %27, 1
  %28 = and i32 %25, 255
  %29 = call i32 @llvm.ctpop.i32(i32 %28)
  %30 = and i32 %29, 1
  %PF24 = icmp eq i32 %30, 0
  %SFAndOF_JL37 = icmp ne i1 %SF22, %OF23
  br i1 %SFAndOF_JL37, label %bb.8, label %bb.7

bb.7:                                             ; preds = %bb.6
  %EAX25 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([176 x i8], ptr @rodata_14, i32 0, i32 98), i32 %memload18)
  br label %bb.8

bb.8:                                             ; preds = %bb.7, %bb.6
  %memload26 = load i32, ptr %RSP_P.16, align 1
  %31 = sub i32 %memload26, 8
  %32 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload26, i32 8)
  %CF27 = extractvalue { i32, i1 } %32, 1
  %ZF28 = icmp eq i32 %31, 0
  %highbit29 = and i32 -2147483648, %31
  %SF30 = icmp ne i32 %highbit29, 0
  %33 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload26, i32 8)
  %OF31 = extractvalue { i32, i1 } %33, 1
  %34 = and i32 %31, 255
  %35 = call i32 @llvm.ctpop.i32(i32 %34)
  %36 = and i32 %35, 1
  %PF32 = icmp eq i32 %36, 0
  %SFAndOF_JL38 = icmp ne i1 %SF30, %OF31
  br i1 %SFAndOF_JL38, label %bb.10, label %bb.9

bb.9:                                             ; preds = %bb.8
  %EAX33 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([176 x i8], ptr @rodata_14, i32 0, i32 163), i32 %memload26)
  br label %bb.10

bb.10:                                            ; preds = %bb.9, %bb.8
  %EAX34 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([176 x i8], ptr @rodata_14, i32 0, i32 111), i32 %memload, i32 %memload2, i32 %memload10, i32 %memload18, i32 %memload26)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4195968}
