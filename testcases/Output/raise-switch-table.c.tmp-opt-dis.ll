; ModuleID = '/home/hxa/test/openai/testcases/Output/raise-switch-table.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/raise-switch-table.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [363 x i8] c"\01\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\EB\06@\00\00\00\00\00\F0\06@\00\00\00\00\00\F5\06@\00\00\00\00\00\FA\06@\00\00\00\00\00\FF\06@\00\00\00\00\00\08\07@\00\00\00\00\00\11\07@\00\00\00\00\00\1A\07@\00\00\00\00\00#\07@\00\00\00\00\00,\07@\00\00\00\00\005\07@\00\00\00\00\00>\07@\00\00\00\00\00G\07@\00\00\00\00\00P\07@\00\00\00\00\00Y\07@\00\00\00\00\00b\07@\00\00\00\00\00\10\06@\00\00\00\00\00\10\06@\00\00\00\00\00\10\06@\00\00\00\00\000\06@\00\00\00\00\000\06@\00\00\00\00\00P\06@\00\00\00\00\00P\06@\00\00\00\00\00p\06@\00\00\00\00\00State Input: %hhu\0A\00ret %d\0A\005012\001234\00-874\00+122\0035.54400\00.1234500\00-110.700\00+0.64400\005.500e+3\00-.123e-2\00-87e+832\00+0.6e-12\00T0.3e-1F\00-T.T++Tq\001T3.4e4z\0034.0e-T^\00", align 16, !ROData_SecInfo !0

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @call_func(i16 %arg1) {
entry:
  %EBX-SKT-LOC = alloca i64, align 8
  %stktop_8 = alloca i8, i32 8, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  %0 = sub i16 %arg1, 7
  %1 = call { i16, i1 } @llvm.usub.with.overflow.i16(i16 %arg1, i16 7)
  %CF = extractvalue { i16, i1 } %1, 1
  %ZF = icmp eq i16 %0, 0
  %highbit = and i16 -32768, %0
  %SF = icmp ne i16 %highbit, 0
  %2 = call { i16, i1 } @llvm.ssub.with.overflow.i16(i16 %arg1, i16 7)
  %OF = extractvalue { i16, i1 } %2, 1
  %3 = and i16 %0, 255
  %4 = call i16 @llvm.ctpop.i16(i16 %3)
  %5 = and i16 %4, 1
  %PF = icmp eq i16 %5, 0
  %ZFCmp_JG = icmp eq i1 %ZF, false
  %SFOFCmp_JG = icmp eq i1 %SF, %OF
  %ZFAndSFOF_JG = and i1 %ZFCmp_JG, %SFOFCmp_JG
  br i1 %ZFAndSFOF_JG, label %bb.3, label %bb.1

bb.1:                                             ; preds = %entry
  %EBX = zext i16 %arg1 to i32
  %6 = zext i32 %EBX to i64
  store i64 %6, ptr %EBX-SKT-LOC, align 1
  br label %bb.2

bb.2:                                             ; preds = %bb.1, %bb.2
  %7 = load i64, ptr %EBX-SKT-LOC, align 1
  %EBX1 = trunc i64 %7 to i32
  %EAX = and i32 %EBX1, 7
  %8 = and i32 %EAX, 255
  %9 = call i32 @llvm.ctpop.i32(i32 %8)
  %10 = and i32 %9, 1
  %PF2 = icmp eq i32 %10, 0
  %ZF3 = icmp eq i32 %EAX, 0
  %highbit4 = and i32 -2147483648, %EAX
  %SF5 = icmp ne i32 %highbit4, 0
  %11 = zext i32 %EAX to i64
  %memref-idxreg = mul i64 8, %11
  %12 = ptrtoint ptr getelementptr inbounds ([363 x i8], ptr @rodata_14, i32 0, i32 144) to i64, !ROData_Index !1
  %memref-disp = add i64 %memref-idxreg, %12, !ROData_Index !1
  %13 = inttoptr i64 %memref-disp to ptr, !ROData_Index !1
  %memload = load i64, ptr %13, align 1, !ROData_Content !2
  %ECX = lshr i32 %EBX1, 3
  %ZF6 = icmp eq i32 %ECX, 0
  %highbit7 = and i32 -2147483648, %ECX
  %SF8 = icmp ne i32 %highbit7, 0
  %ECX13 = and i32 %ECX, 3
  %14 = and i32 %ECX13, 255
  %15 = call i32 @llvm.ctpop.i32(i32 %14)
  %16 = and i32 %15, 1
  %PF9 = icmp eq i32 %16, 0
  %ZF10 = icmp eq i32 %ECX13, 0
  %highbit11 = and i32 -2147483648, %ECX13
  %SF12 = icmp ne i32 %highbit11, 0
  %17 = zext i32 %ECX13 to i64
  %memref-idxreg14 = mul i64 8, %17
  %memref-basereg = add i64 %memload, %memref-idxreg14, !ROData_Content !2
  %18 = inttoptr i64 %memref-basereg to ptr, !ROData_Content !2
  %19 = ptrtoint ptr %18 to i64, !ROData_Content !2
  %20 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate = call i64 @getRuntimeSectionOffset(i64 %19, i64 4195840, i64 363, i64 %20)
  %21 = getelementptr i8, ptr %18, i64 %rodata-translate
  %rodata-reloc = load i64, ptr %21, align 1, !ROData_Content !2
  %22 = inttoptr i64 %rodata-reloc to ptr, !ROData_Content !2
  %23 = ptrtoint ptr %22 to i64, !ROData_Content !2
  %24 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate15 = call i64 @getRuntimeSectionOffset(i64 %23, i64 4195840, i64 363, i64 %24)
  %25 = getelementptr i8, ptr %22, i64 %rodata-translate15
  %rodata-reloc17 = load i32, ptr %25, align 1, !ROData_Content !2
  %26 = trunc i32 %rodata-reloc17 to i8, !ROData_Content !2
  %ESI = zext i8 %26 to i32, !ROData_Content !2
  %EAX18 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([363 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI)
  %memref-disp19 = add i64 %rodata-reloc, 1, !ROData_Content !2
  %27 = inttoptr i64 %memref-disp19 to ptr, !ROData_Content !2
  %28 = ptrtoint ptr %27 to i64, !ROData_Content !2
  %29 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate20 = call i64 @getRuntimeSectionOffset(i64 %28, i64 4195840, i64 363, i64 %29)
  %30 = getelementptr i8, ptr %27, i64 %rodata-translate20
  %rodata-reloc22 = load i32, ptr %30, align 1, !ROData_Content !2
  %31 = trunc i32 %rodata-reloc22 to i8, !ROData_Content !2
  %ESI23 = zext i8 %31 to i32, !ROData_Content !2
  %EAX24 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([363 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI23)
  %memref-disp25 = add i64 %rodata-reloc, 2, !ROData_Content !2
  %32 = inttoptr i64 %memref-disp25 to ptr, !ROData_Content !2
  %33 = ptrtoint ptr %32 to i64, !ROData_Content !2
  %34 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate26 = call i64 @getRuntimeSectionOffset(i64 %33, i64 4195840, i64 363, i64 %34)
  %35 = getelementptr i8, ptr %32, i64 %rodata-translate26
  %rodata-reloc28 = load i32, ptr %35, align 1, !ROData_Content !2
  %36 = trunc i32 %rodata-reloc28 to i8, !ROData_Content !2
  %ESI29 = zext i8 %36 to i32, !ROData_Content !2
  %EAX30 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([363 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI29)
  %memref-disp31 = add i64 %rodata-reloc, 3, !ROData_Content !2
  %37 = inttoptr i64 %memref-disp31 to ptr, !ROData_Content !2
  %38 = ptrtoint ptr %37 to i64, !ROData_Content !2
  %39 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate32 = call i64 @getRuntimeSectionOffset(i64 %38, i64 4195840, i64 363, i64 %39)
  %40 = getelementptr i8, ptr %37, i64 %rodata-translate32
  %rodata-reloc34 = load i32, ptr %40, align 1, !ROData_Content !2
  %41 = trunc i32 %rodata-reloc34 to i8, !ROData_Content !2
  %ESI35 = zext i8 %41 to i32, !ROData_Content !2
  %EAX36 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([363 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI35)
  %EBX41 = add i32 %EBX1, 1
  %42 = and i32 %EBX41, 255
  %43 = call i32 @llvm.ctpop.i32(i32 %42)
  %44 = and i32 %43, 1
  %PF37 = icmp eq i32 %44, 0
  %ZF38 = icmp eq i32 %EBX41, 0
  %highbit39 = and i32 -2147483648, %EBX41
  %SF40 = icmp ne i32 %highbit39, 0
  %45 = trunc i32 %EBX41 to i16
  %46 = trunc i32 8 to i16
  %47 = sub i16 %45, %46
  %48 = call { i16, i1 } @llvm.usub.with.overflow.i16(i16 %45, i16 %46)
  %CF42 = extractvalue { i16, i1 } %48, 1
  %ZF43 = icmp eq i16 %47, 0
  %highbit44 = and i16 -32768, %47
  %SF45 = icmp ne i16 %highbit44, 0
  %49 = call { i16, i1 } @llvm.ssub.with.overflow.i16(i16 %45, i16 %46)
  %OF46 = extractvalue { i16, i1 } %49, 1
  %50 = and i16 %47, 255
  %51 = call i16 @llvm.ctpop.i16(i16 %50)
  %52 = and i16 %51, 1
  %PF47 = icmp eq i16 %52, 0
  %CmpZF_JNE = icmp eq i1 %ZF43, false
  %53 = zext i32 %EBX41 to i64
  store i64 %53, ptr %EBX-SKT-LOC, align 1
  br i1 %CmpZF_JNE, label %bb.2, label %bb.3

bb.3:                                             ; preds = %bb.2, %entry
  ret i32 1
}

define dso_local i32 @main() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %0 = trunc i32 1 to i16
  %EAX = call i32 @call_func(i16 %0)
  %EAX1 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([363 x i8], ptr @rodata_14, i32 0, i32 227), i32 1)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i16, i1 } @llvm.usub.with.overflow.i16(i16, i16) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i16, i1 } @llvm.ssub.with.overflow.i16(i16, i16) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.ctpop.i16(i16) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #0

define i64 @getRuntimeSectionOffset(i64 %InAddr, i64 %SecBeg, i64 %SecSz, i64 %RTGV) {
entry:
  %rodata-cmp-begin = icmp uge i64 %InAddr, %SecBeg
  %rodata-sec-end = add i64 %SecSz, %SecBeg
  %rodata-cmp-end = icmp ule i64 %InAddr, %rodata-sec-end
  %rodata-cond = and i1 %rodata-cmp-begin, %rodata-cmp-end
  %rodata-offset = sub i64 %RTGV, %SecBeg
  %rodata-result = select i1 %rodata-cond, i64 %rodata-offset, i64 0
  ret i64 %rodata-result
}

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4195840}
!1 = !{ptr getelementptr inbounds ([363 x i8], ptr @rodata_14, i32 0, i32 144)}
!2 = !{!1}
