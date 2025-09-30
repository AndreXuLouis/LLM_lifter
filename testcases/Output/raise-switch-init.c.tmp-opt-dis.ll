; ModuleID = '/home/hxa/test/openai/testcases/Output/raise-switch-init.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/raise-switch-init.c.tmp-opt"

@rodata_14 = private unnamed_addr constant [384 x i8] c"\01\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\8A\07@\00\00\00\00\00\8F\07@\00\00\00\00\00\94\07@\00\00\00\00\00\99\07@\00\00\00\00\00\9E\07@\00\00\00\00\00\A7\07@\00\00\00\00\00\B0\07@\00\00\00\00\00\B9\07@\00\00\00\00\00\C2\07@\00\00\00\00\00\CB\07@\00\00\00\00\00\D4\07@\00\00\00\00\00\DD\07@\00\00\00\00\00\E6\07@\00\00\00\00\00\EF\07@\00\00\00\00\00\F8\07@\00\00\00\00\00\01\08@\00\00\00\00\00\C0\06@\00\00\00\00\00\C0\06@\00\00\00\00\00\C0\06@\00\00\00\00\00\E0\06@\00\00\00\00\00\E0\06@\00\00\00\00\00\00\07@\00\00\00\00\00\00\07@\00\00\00\00\00 \07@\00\00\00\00\00buf = %x\0A\005012\001234\00-874\00+122\0035.54400\00.1234500\00-110.700\00+0.64400\005.500e+3\00-.123e-2\00-87e+832\00+0.6e-12\00T0.3e-1F\00-T.T++Tq\001T3.4e4z\0034.0e-T^\00Test\00\00\04\00\00\00\04\00\00\00\04\00\00\00\08\00\00\00\08\00\00\00\08\00\00\00\08\00\00\00\08\00\00\00", align 16, !ROData_SecInfo !0

declare dso_local ptr @malloc(i64)

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @foo(i32 %arg1, i32 %arg2) {
entry:
  %R14-SKT-LOC = alloca i64, align 8, !ROData_Content !1
  %RSI-SKT-LOC = alloca i32, align 4, !ROData_Content !1
  %BX-SKT-LOC = alloca i64, align 8
  %EAX-SKT-LOC = alloca i64, align 8
  %ECX-SKT-LOC = alloca i64, align 8
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
  %8 = ptrtoint ptr %RSI-SKT-LOC to i64, !ROData_Content !1
  %9 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate60 = call i64 @getRuntimeSectionOffset(i64 %8, i64 4196016, i64 384, i64 %9)
  %10 = ptrtoint ptr %RSI-SKT-LOC to i64, !ROData_Content !1
  %rodata-rebase61 = add i64 %10, %rodata-translate60
  %11 = inttoptr i64 %rodata-rebase61 to ptr
  %12 = ptrtoint ptr %R14-SKT-LOC to i64, !ROData_Content !1
  %13 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate64 = call i64 @getRuntimeSectionOffset(i64 %12, i64 4196016, i64 384, i64 %13)
  %14 = ptrtoint ptr %R14-SKT-LOC to i64, !ROData_Content !1
  %rodata-rebase65 = add i64 %14, %rodata-translate64
  %15 = inttoptr i64 %rodata-rebase65 to ptr
  %CmpCF_JB = icmp eq i1 %CF, true
  br i1 %CmpCF_JB, label %bb.4, label %bb.1

bb.1:                                             ; preds = %entry
  %EBX = add i32 %arg2, 1
  %16 = and i32 %EBX, 255
  %17 = call i32 @llvm.ctpop.i32(i32 %16)
  %18 = and i32 %17, 1
  %PF1 = icmp eq i32 %18, 0
  %ZF2 = icmp eq i32 %EBX, 0
  %highbit3 = and i32 -2147483648, %EBX
  %SF4 = icmp ne i32 %highbit3, 0
  %19 = zext i32 0 to i64
  store i64 %19, ptr %ECX-SKT-LOC, align 1
  %20 = zext i32 0 to i64
  store i64 %20, ptr %EAX-SKT-LOC, align 1
  %21 = zext i32 %EBX to i64
  store i64 %21, ptr %BX-SKT-LOC, align 1
  br label %bb.2

bb.2:                                             ; preds = %bb.1, %bb.2
  %22 = load i64, ptr %ECX-SKT-LOC, align 1
  %ECX = trunc i64 %22 to i32
  %EDX = or i32 %ECX, 1
  %23 = and i32 %EDX, 255
  %24 = call i32 @llvm.ctpop.i32(i32 %23)
  %25 = and i32 %24, 1
  %PF5 = icmp eq i32 %25, 0
  %ZF6 = icmp eq i32 %EDX, 0
  %highbit7 = and i32 -2147483648, %EDX
  %SF8 = icmp ne i32 %highbit7, 0
  %26 = and i32 %ECX, %ECX
  %highbit9 = and i32 -2147483648, %26
  %SF10 = icmp ne i32 %highbit9, 0
  %ZF11 = icmp eq i32 %26, 0
  %27 = and i32 %26, 255
  %28 = call i32 @llvm.ctpop.i32(i32 %27)
  %29 = and i32 %28, 1
  %PF12 = icmp eq i32 %29, 0
  %Cond_CMOVE = icmp eq i1 %ZF11, true
  %CMOV = select i1 %Cond_CMOVE, i32 %ECX, i32 %EDX
  %30 = load i64, ptr %EAX-SKT-LOC, align 1
  %EAX = trunc i64 %30 to i32
  %EAX16 = add nsw i32 %EAX, %CMOV
  %highbit13 = and i32 -2147483648, %EAX16
  %SF14 = icmp ne i32 %highbit13, 0
  %ZF15 = icmp eq i32 %EAX16, 0
  %31 = load i64, ptr %BX-SKT-LOC, align 1
  %BX = trunc i64 %31 to i16
  %EDX17 = zext i16 %BX to i32
  %ESI = and i32 %EDX17, 7
  %32 = and i32 %ESI, 255
  %33 = call i32 @llvm.ctpop.i32(i32 %32)
  %34 = and i32 %33, 1
  %PF18 = icmp eq i32 %34, 0
  %ZF19 = icmp eq i32 %ESI, 0
  %highbit20 = and i32 -2147483648, %ESI
  %SF21 = icmp ne i32 %highbit20, 0
  %35 = zext i32 %ESI to i64
  %memref-idxreg = mul i64 4, %35
  %36 = ptrtoint ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 352) to i64, !ROData_Index !3
  %memref-disp = add i64 %memref-idxreg, %36, !ROData_Index !3
  %37 = inttoptr i64 %memref-disp to ptr, !ROData_Index !3
  %memload = load i32, ptr %37, align 1, !ROData_Content !4
  %ECX23 = add i32 %ECX, %memload, !ROData_Content !4
  %38 = and i32 %ECX23, 255
  %39 = call i32 @llvm.ctpop.i32(i32 %38)
  %40 = and i32 %39, 1
  %PF22 = icmp eq i32 %40, 0
  %EDI = or i32 %ECX23, 1, !ROData_Content !4
  %41 = and i32 %EDI, 255
  %42 = call i32 @llvm.ctpop.i32(i32 %41)
  %43 = and i32 %42, 1
  %PF24 = icmp eq i32 %43, 0
  %ZF25 = icmp eq i32 %EDI, 0
  %highbit26 = and i32 -2147483648, %EDI
  %SF27 = icmp ne i32 %highbit26, 0
  %EDI31 = add nsw i32 %EDI, %EAX16, !ROData_Content !4
  %highbit28 = and i32 -2147483648, %EDI31
  %SF29 = icmp ne i32 %highbit28, 0
  %ZF30 = icmp eq i32 %EDI31, 0
  %44 = zext i16 %BX to i32
  %EBX36 = add i32 %44, 1
  %45 = and i32 %EBX36, 255
  %46 = call i32 @llvm.ctpop.i32(i32 %45)
  %47 = and i32 %46, 1
  %PF32 = icmp eq i32 %47, 0
  %ZF33 = icmp eq i32 %EBX36, 0
  %highbit34 = and i32 -2147483648, %EBX36
  %SF35 = icmp ne i32 %highbit34, 0
  %48 = sub i32 %EDI31, %arg1
  %49 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %EDI31, i32 %arg1)
  %CF37 = extractvalue { i32, i1 } %49, 1
  %ZF38 = icmp eq i32 %48, 0
  %highbit39 = and i32 -2147483648, %48
  %SF40 = icmp ne i32 %highbit39, 0
  %50 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %EDI31, i32 %arg1)
  %OF41 = extractvalue { i32, i1 } %50, 1
  %51 = and i32 %48, 255
  %52 = call i32 @llvm.ctpop.i32(i32 %51)
  %53 = and i32 %52, 1
  %PF42 = icmp eq i32 %53, 0
  %CmpCF_JB85 = icmp eq i1 %CF37, true
  %54 = zext i32 %EBX36 to i64
  store i64 %54, ptr %BX-SKT-LOC, align 1
  %55 = zext i32 %EAX16 to i64
  store i64 %55, ptr %EAX-SKT-LOC, align 1
  %56 = zext i32 %ECX23 to i64
  store i64 %56, ptr %ECX-SKT-LOC, align 1
  br i1 %CmpCF_JB85, label %bb.2, label %bb.3

bb.3:                                             ; preds = %bb.2
  %57 = zext i32 %ESI to i64
  %memref-idxreg43 = mul i64 8, %57
  %58 = ptrtoint ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 144) to i64, !ROData_Index !2
  %memref-disp44 = add i64 %memref-idxreg43, %58, !ROData_Index !2
  %59 = inttoptr i64 %memref-disp44 to ptr, !ROData_Index !2
  %memload45 = load i64, ptr %59, align 1, !ROData_Content !1
  %EDX49 = lshr i32 %EDX17, 3
  %ZF46 = icmp eq i32 %EDX49, 0
  %highbit47 = and i32 -2147483648, %EDX49
  %SF48 = icmp ne i32 %highbit47, 0
  %EDX54 = and i32 %EDX49, 3
  %60 = and i32 %EDX54, 255
  %61 = call i32 @llvm.ctpop.i32(i32 %60)
  %62 = and i32 %61, 1
  %PF50 = icmp eq i32 %62, 0
  %ZF51 = icmp eq i32 %EDX54, 0
  %highbit52 = and i32 -2147483648, %EDX54
  %SF53 = icmp ne i32 %highbit52, 0
  %63 = zext i32 %EDX54 to i64
  %memref-idxreg55 = mul i64 8, %63
  %memref-basereg = add i64 %memload45, %memref-idxreg55, !ROData_Content !1
  %64 = inttoptr i64 %memref-basereg to ptr, !ROData_Content !1
  %65 = ptrtoint ptr %64 to i64, !ROData_Content !1
  %66 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate = call i64 @getRuntimeSectionOffset(i64 %65, i64 4196016, i64 384, i64 %66)
  %67 = getelementptr i8, ptr %64, i64 %rodata-translate
  %rodata-reloc = load i64, ptr %67, align 1, !ROData_Content !1
  %68 = inttoptr i64 %rodata-reloc to ptr, !ROData_Content !1
  %69 = ptrtoint ptr %68 to i64, !ROData_Content !1
  %70 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate56 = call i64 @getRuntimeSectionOffset(i64 %69, i64 4196016, i64 384, i64 %70)
  %71 = getelementptr i8, ptr %68, i64 %rodata-translate56
  %rodata-reloc58 = load i32, ptr %71, align 1, !ROData_Content !1
  %72 = trunc i32 %rodata-reloc58 to i8, !ROData_Content !1
  %ESI59 = zext i8 %72 to i32, !ROData_Content !1
  store i32 %ESI59, ptr %RSI-SKT-LOC, align 1
  store i64 %rodata-reloc, ptr %R14-SKT-LOC, align 1
  br label %bb.5

bb.4:                                             ; preds = %entry
  store i32 0, ptr %RSI-SKT-LOC, align 1
  store i64 %RAX, ptr %R14-SKT-LOC, align 1
  br label %bb.5

bb.5:                                             ; preds = %bb.4, %bb.3
  %rodata-reloc62 = load i32, ptr %11, align 1, !ROData_Content !1
  %RSI = zext i32 %rodata-reloc62 to i64
  %EAX63 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 208), i64 %RSI)
  %rodata-reloc66 = load i64, ptr %15, align 1, !ROData_Content !1
  %memref-disp67 = add i64 %rodata-reloc66, 1, !ROData_Content !1
  %73 = inttoptr i64 %memref-disp67 to ptr, !ROData_Content !1
  %74 = ptrtoint ptr %73 to i64, !ROData_Content !1
  %75 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate68 = call i64 @getRuntimeSectionOffset(i64 %74, i64 4196016, i64 384, i64 %75)
  %76 = getelementptr i8, ptr %73, i64 %rodata-translate68
  %rodata-reloc70 = load i32, ptr %76, align 1, !ROData_Content !1
  %77 = trunc i32 %rodata-reloc70 to i8, !ROData_Content !1
  %ESI71 = zext i8 %77 to i32, !ROData_Content !1
  %EAX72 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI71)
  %memref-disp73 = add i64 %rodata-reloc66, 2, !ROData_Content !1
  %78 = inttoptr i64 %memref-disp73 to ptr, !ROData_Content !1
  %79 = ptrtoint ptr %78 to i64, !ROData_Content !1
  %80 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate74 = call i64 @getRuntimeSectionOffset(i64 %79, i64 4196016, i64 384, i64 %80)
  %81 = getelementptr i8, ptr %78, i64 %rodata-translate74
  %rodata-reloc76 = load i32, ptr %81, align 1, !ROData_Content !1
  %82 = trunc i32 %rodata-reloc76 to i8, !ROData_Content !1
  %ESI77 = zext i8 %82 to i32, !ROData_Content !1
  %EAX78 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI77)
  %memref-disp79 = add i64 %rodata-reloc66, 3, !ROData_Content !1
  %83 = inttoptr i64 %memref-disp79 to ptr, !ROData_Content !1
  %84 = ptrtoint ptr %83 to i64, !ROData_Content !1
  %85 = ptrtoint ptr @rodata_14 to i64
  %rodata-translate80 = call i64 @getRuntimeSectionOffset(i64 %84, i64 4196016, i64 384, i64 %85)
  %86 = getelementptr i8, ptr %83, i64 %rodata-translate80
  %rodata-reloc82 = load i32, ptr %86, align 1, !ROData_Content !1
  %87 = trunc i32 %rodata-reloc82 to i8, !ROData_Content !1
  %ESI83 = zext i8 %87 to i32, !ROData_Content !1
  %EAX84 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 208), i32 %ESI83)
  ret i32 1
}

declare dso_local i32 @puts(ptr)

define dso_local i32 @main() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %EAX = call i32 @foo(i32 66, i32 8)
  %EAX1 = call i32 @puts(ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 346))
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #0

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

!0 = !{i64 4196016}
!1 = !{!2}
!2 = !{ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 144)}
!3 = !{ptr getelementptr inbounds ([384 x i8], ptr @rodata_14, i32 0, i32 352)}
!4 = !{!3}
