; ModuleID = '/home/hxa/test/openai/testcases/Output/test-clock-call.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/test-clock-call.c.tmp-opt"

@start_time_val = common dso_local global i64 0, align 8
@rodata_14 = private unnamed_addr constant [19 x i8] c"\01\00\02\00time_val: %ld\0A\00", align 4, !ROData_SecInfo !0

define dso_local i64 @time_in_secs(i32 %arg1) {
entry:
  %0 = zext i32 %arg1 to i64
  %RAX = mul i64 %0, 1125899907
  %1 = call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %0, i64 1125899907)
  %OF = extractvalue { i64, i1 } %1, 1
  %RAX1 = lshr i64 %RAX, 50
  %ZF = icmp eq i64 %RAX1, 0
  %highbit = and i64 -9223372036854775808, %RAX1
  %SF = icmp ne i64 %highbit, 0
  ret i64 %RAX1
}

declare dso_local i64 @clock()

define dso_local i64 @start_time() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %RAX = call i64 @clock()
  store i64 %RAX, ptr @start_time_val, align 1
  ret i64 %RAX
}

define dso_local i64 @stop_time() {
entry:
  %RAX = tail call i64 @clock()
  ret i64 %RAX
}

declare dso_local i32 @sleep(i32)

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @main() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %RAX = call i64 @clock()
  store i64 %RAX, ptr @start_time_val, align 1
  %EAX = call i32 @sleep(i32 1)
  %RAX1 = call i64 @clock()
  %0 = load i64, ptr @start_time_val, align 8
  %RAX2 = sub i64 %RAX1, %0
  %1 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %RAX1, i64 %0)
  %CF = extractvalue { i64, i1 } %1, 1
  %ZF = icmp eq i64 %RAX2, 0
  %highbit = and i64 -9223372036854775808, %RAX2
  %SF = icmp ne i64 %highbit, 0
  %2 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %RAX1, i64 %0)
  %OF = extractvalue { i64, i1 } %2, 1
  %3 = and i64 %RAX2, 255
  %4 = call i64 @llvm.ctpop.i64(i64 %3)
  %5 = and i64 %4, 1
  %PF = icmp eq i64 %5, 0
  %EAX3 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([19 x i8], ptr @rodata_14, i32 0, i32 4), i64 %RAX2)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.usub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.ctpop.i64(i64) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4195920}
