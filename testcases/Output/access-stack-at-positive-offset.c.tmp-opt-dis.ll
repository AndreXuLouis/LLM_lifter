; ModuleID = '/home/hxa/test/openai/testcases/Output/access-stack-at-positive-offset.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/access-stack-at-positive-offset.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [181 x i8] c"\01\00\02\00a[0] = %d, a[1] = %d, a[2] = %d, a[3] = %d, a[4] = %d\0A\00arr[0] = %d, arr[1] = %d, arr[2] = %d, arr[3] = %d, arr[4] = %d\0A\00Help Print Info: i = %d, j = %d, k = %d, l = %d, m = %d\0A\00", align 4, !ROData_SecInfo !0

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
  %EAX = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([181 x i8], ptr @rodata_14, i32 0, i32 4), i32 4, i32 5, i32 6, i32 7, i32 8)
  ret i32 0
}

define dso_local i32 @main() {
entry:
  %stktop_8 = alloca i8, i32 44, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  %0 = add i64 %tos, 4
  %RSP_P.4 = inttoptr i64 %0 to ptr
  %1 = add i64 %tos, 8
  %RSP_P.8 = inttoptr i64 %1 to ptr
  %2 = add i64 %tos, 16
  %RSP_P.16 = inttoptr i64 %2 to ptr
  store i32 0, ptr %RSP_P.16, align 1
  %3 = sext i32 0 to i64
  store i64 %3, ptr %RSP_P.8, align 1
  %4 = sext i32 0 to i64
  store i64 %4, ptr %stktop_8, align 1
  %RDI = ptrtoint ptr %stktop_8 to i64
  %EAX = call i32 @foo(i64 %RDI)
  %memload = load i32, ptr %stktop_8, align 1
  %memload1 = load i32, ptr %RSP_P.4, align 1
  %memload2 = load i32, ptr %RSP_P.8, align 1
  %5 = getelementptr i8, ptr %RSP_P.8, i64 4
  %memload3 = load i32, ptr %5, align 1
  %memload4 = load i32, ptr %RSP_P.16, align 1
  %EAX5 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([181 x i8], ptr @rodata_14, i32 0, i32 59), i32 %memload, i32 %memload1, i32 %memload2, i32 %memload3, i32 %memload4)
  %EAX6 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([181 x i8], ptr @rodata_14, i32 0, i32 124), i32 10, i32 11, i32 12, i32 13, i32 13)
  ret i32 0
}

!0 = !{i64 4195872}
