; ModuleID = '/home/hxa/test/openai/testcases/Output/test-return-value-type.c.tmp-opt'
source_filename = "/home/hxa/test/openai/testcases/Output/test-return-value-type.c.tmp-opt"

@C = common dso_local global [64 x i8] zeroinitializer, align 16
@A = dso_local global [8 x i32] [i32 65536, i32 196610, i32 327684, i32 458758, i32 589832, i32 720906, i32 851980, i32 983054], align 4
@B = dso_local global [8 x i32] [i32 131074, i32 131074, i32 131074, i32 131074, i32 131074, i32 131074, i32 131084, i32 131074], align 4
@rodata_14 = private unnamed_addr constant [12 x i8] c"\01\00\02\00ret %d\0A\00", align 4, !ROData_SecInfo !0

define dso_local i32 @bar(i32 %arg1, i32 %arg2) {
entry:
  %EAX = xor i32 %arg1, %arg2
  %highbit = and i32 -2147483648, %EAX
  %SF = icmp ne i32 %highbit, 0
  %ZF = icmp eq i32 %EAX, 0
  %0 = and i32 %EAX, 255
  %1 = call i32 @llvm.ctpop.i32(i32 %0)
  %2 = and i32 %1, 1
  %PF = icmp eq i32 %2, 0
  %3 = trunc i32 %arg1 to i8
  %CL = lshr i8 %3, 1
  %ZF1 = icmp eq i8 %CL, 0
  %highbit2 = and i8 -128, %CL
  %SF3 = icmp ne i8 %highbit2, 0
  %ESI = lshr i32 %arg2, 1
  %ZF4 = icmp eq i32 %ESI, 0
  %highbit5 = and i32 -2147483648, %ESI
  %SF6 = icmp ne i32 %highbit5, 0
  %EDX = xor i32 %ESI, -24575
  %4 = and i32 %EDX, 255
  %5 = call i32 @llvm.ctpop.i32(i32 %4)
  %6 = and i32 %5, 1
  %PF7 = icmp eq i32 %6, 0
  %ZF8 = icmp eq i32 %EDX, 0
  %highbit9 = and i32 -2147483648, %EDX
  %SF10 = icmp ne i32 %highbit9, 0
  %7 = trunc i32 %EAX to i8
  %8 = and i8 %7, 1
  %9 = call i8 @llvm.ctpop.i8(i8 %8)
  %10 = and i8 %9, 1
  %PF11 = icmp eq i8 %10, 0
  %ZF12 = icmp eq i8 %8, 0
  %highbit13 = and i8 -128, %8
  %SF14 = icmp ne i8 %highbit13, 0
  %Cond_CMOVE = icmp eq i1 %ZF12, true
  %CMOV = select i1 %Cond_CMOVE, i32 %ESI, i32 %EDX
  %11 = trunc i32 %CMOV to i16
  %EAX15 = zext i16 %11 to i32
  %12 = trunc i32 %CMOV to i8
  %DL = xor i8 %12, %CL
  %highbit16 = and i8 -128, %DL
  %SF17 = icmp ne i8 %highbit16, 0
  %ZF18 = icmp eq i8 %DL, 0
  %13 = call i8 @llvm.ctpop.i8(i8 %DL)
  %14 = and i8 %13, 1
  %PF19 = icmp eq i8 %14, 0
  %15 = trunc i32 %arg1 to i8
  %CL23 = lshr i8 %15, 2
  %ZF20 = icmp eq i8 %CL23, 0
  %highbit21 = and i8 -128, %CL23
  %SF22 = icmp ne i8 %highbit21, 0
  %EAX27 = lshr i32 %EAX15, 1
  %ZF24 = icmp eq i32 %EAX27, 0
  %highbit25 = and i32 -2147483648, %EAX27
  %SF26 = icmp ne i32 %highbit25, 0
  %ESI32 = xor i32 %EAX27, -24575
  %16 = and i32 %ESI32, 255
  %17 = call i32 @llvm.ctpop.i32(i32 %16)
  %18 = and i32 %17, 1
  %PF28 = icmp eq i32 %18, 0
  %ZF29 = icmp eq i32 %ESI32, 0
  %highbit30 = and i32 -2147483648, %ESI32
  %SF31 = icmp ne i32 %highbit30, 0
  %19 = and i8 %DL, 1
  %20 = call i8 @llvm.ctpop.i8(i8 %19)
  %21 = and i8 %20, 1
  %PF33 = icmp eq i8 %21, 0
  %ZF34 = icmp eq i8 %19, 0
  %highbit35 = and i8 -128, %19
  %SF36 = icmp ne i8 %highbit35, 0
  %Cond_CMOVE37 = icmp eq i1 %ZF34, true
  %CMOV38 = select i1 %Cond_CMOVE37, i32 %EAX27, i32 %ESI32
  %22 = trunc i32 %CMOV38 to i16
  %EAX39 = zext i16 %22 to i32
  %23 = trunc i32 %CMOV38 to i8
  %SIL = xor i8 %23, %CL23
  %highbit40 = and i8 -128, %SIL
  %SF41 = icmp ne i8 %highbit40, 0
  %ZF42 = icmp eq i8 %SIL, 0
  %24 = call i8 @llvm.ctpop.i8(i8 %SIL)
  %25 = and i8 %24, 1
  %PF43 = icmp eq i8 %25, 0
  %26 = trunc i32 %arg1 to i8
  %CL47 = lshr i8 %26, 3
  %ZF44 = icmp eq i8 %CL47, 0
  %highbit45 = and i8 -128, %CL47
  %SF46 = icmp ne i8 %highbit45, 0
  %EAX51 = lshr i32 %EAX39, 1
  %ZF48 = icmp eq i32 %EAX51, 0
  %highbit49 = and i32 -2147483648, %EAX51
  %SF50 = icmp ne i32 %highbit49, 0
  %EDX56 = xor i32 %EAX51, -24575
  %27 = and i32 %EDX56, 255
  %28 = call i32 @llvm.ctpop.i32(i32 %27)
  %29 = and i32 %28, 1
  %PF52 = icmp eq i32 %29, 0
  %ZF53 = icmp eq i32 %EDX56, 0
  %highbit54 = and i32 -2147483648, %EDX56
  %SF55 = icmp ne i32 %highbit54, 0
  %30 = and i8 %SIL, 1
  %31 = call i8 @llvm.ctpop.i8(i8 %30)
  %32 = and i8 %31, 1
  %PF57 = icmp eq i8 %32, 0
  %ZF58 = icmp eq i8 %30, 0
  %highbit59 = and i8 -128, %30
  %SF60 = icmp ne i8 %highbit59, 0
  %Cond_CMOVE61 = icmp eq i1 %ZF58, true
  %CMOV62 = select i1 %Cond_CMOVE61, i32 %EAX51, i32 %EDX56
  %33 = trunc i32 %CMOV62 to i16
  %EAX63 = zext i16 %33 to i32
  %34 = trunc i32 %CMOV62 to i8
  %DL68 = xor i8 %34, %CL47
  %highbit64 = and i8 -128, %DL68
  %SF65 = icmp ne i8 %highbit64, 0
  %ZF66 = icmp eq i8 %DL68, 0
  %35 = call i8 @llvm.ctpop.i8(i8 %DL68)
  %36 = and i8 %35, 1
  %PF67 = icmp eq i8 %36, 0
  %37 = trunc i32 %arg1 to i8
  %CL72 = lshr i8 %37, 4
  %ZF69 = icmp eq i8 %CL72, 0
  %highbit70 = and i8 -128, %CL72
  %SF71 = icmp ne i8 %highbit70, 0
  %EAX76 = lshr i32 %EAX63, 1
  %ZF73 = icmp eq i32 %EAX76, 0
  %highbit74 = and i32 -2147483648, %EAX76
  %SF75 = icmp ne i32 %highbit74, 0
  %ESI81 = xor i32 %EAX76, -24575
  %38 = and i32 %ESI81, 255
  %39 = call i32 @llvm.ctpop.i32(i32 %38)
  %40 = and i32 %39, 1
  %PF77 = icmp eq i32 %40, 0
  %ZF78 = icmp eq i32 %ESI81, 0
  %highbit79 = and i32 -2147483648, %ESI81
  %SF80 = icmp ne i32 %highbit79, 0
  %41 = and i8 %DL68, 1
  %42 = call i8 @llvm.ctpop.i8(i8 %41)
  %43 = and i8 %42, 1
  %PF82 = icmp eq i8 %43, 0
  %ZF83 = icmp eq i8 %41, 0
  %highbit84 = and i8 -128, %41
  %SF85 = icmp ne i8 %highbit84, 0
  %Cond_CMOVE86 = icmp eq i1 %ZF83, true
  %CMOV87 = select i1 %Cond_CMOVE86, i32 %EAX76, i32 %ESI81
  %44 = trunc i32 %CMOV87 to i16
  %EAX88 = zext i16 %44 to i32
  %45 = trunc i32 %CMOV87 to i8
  %SIL93 = xor i8 %45, %CL72
  %highbit89 = and i8 -128, %SIL93
  %SF90 = icmp ne i8 %highbit89, 0
  %ZF91 = icmp eq i8 %SIL93, 0
  %46 = call i8 @llvm.ctpop.i8(i8 %SIL93)
  %47 = and i8 %46, 1
  %PF92 = icmp eq i8 %47, 0
  %48 = trunc i32 %arg1 to i8
  %CL97 = lshr i8 %48, 5
  %ZF94 = icmp eq i8 %CL97, 0
  %highbit95 = and i8 -128, %CL97
  %SF96 = icmp ne i8 %highbit95, 0
  %EAX101 = lshr i32 %EAX88, 1
  %ZF98 = icmp eq i32 %EAX101, 0
  %highbit99 = and i32 -2147483648, %EAX101
  %SF100 = icmp ne i32 %highbit99, 0
  %EDX106 = xor i32 %EAX101, -24575
  %49 = and i32 %EDX106, 255
  %50 = call i32 @llvm.ctpop.i32(i32 %49)
  %51 = and i32 %50, 1
  %PF102 = icmp eq i32 %51, 0
  %ZF103 = icmp eq i32 %EDX106, 0
  %highbit104 = and i32 -2147483648, %EDX106
  %SF105 = icmp ne i32 %highbit104, 0
  %52 = and i8 %SIL93, 1
  %53 = call i8 @llvm.ctpop.i8(i8 %52)
  %54 = and i8 %53, 1
  %PF107 = icmp eq i8 %54, 0
  %ZF108 = icmp eq i8 %52, 0
  %highbit109 = and i8 -128, %52
  %SF110 = icmp ne i8 %highbit109, 0
  %Cond_CMOVE111 = icmp eq i1 %ZF108, true
  %CMOV112 = select i1 %Cond_CMOVE111, i32 %EAX101, i32 %EDX106
  %55 = trunc i32 %CMOV112 to i16
  %EAX113 = zext i16 %55 to i32
  %56 = trunc i32 %CMOV112 to i8
  %DL118 = xor i8 %56, %CL97
  %highbit114 = and i8 -128, %DL118
  %SF115 = icmp ne i8 %highbit114, 0
  %ZF116 = icmp eq i8 %DL118, 0
  %57 = call i8 @llvm.ctpop.i8(i8 %DL118)
  %58 = and i8 %57, 1
  %PF117 = icmp eq i8 %58, 0
  %59 = trunc i32 %arg1 to i8
  %CL122 = lshr i8 %59, 6
  %ZF119 = icmp eq i8 %CL122, 0
  %highbit120 = and i8 -128, %CL122
  %SF121 = icmp ne i8 %highbit120, 0
  %EAX126 = lshr i32 %EAX113, 1
  %ZF123 = icmp eq i32 %EAX126, 0
  %highbit124 = and i32 -2147483648, %EAX126
  %SF125 = icmp ne i32 %highbit124, 0
  %ESI131 = xor i32 %EAX126, -24575
  %60 = and i32 %ESI131, 255
  %61 = call i32 @llvm.ctpop.i32(i32 %60)
  %62 = and i32 %61, 1
  %PF127 = icmp eq i32 %62, 0
  %ZF128 = icmp eq i32 %ESI131, 0
  %highbit129 = and i32 -2147483648, %ESI131
  %SF130 = icmp ne i32 %highbit129, 0
  %63 = and i8 %DL118, 1
  %64 = call i8 @llvm.ctpop.i8(i8 %63)
  %65 = and i8 %64, 1
  %PF132 = icmp eq i8 %65, 0
  %ZF133 = icmp eq i8 %63, 0
  %highbit134 = and i8 -128, %63
  %SF135 = icmp ne i8 %highbit134, 0
  %Cond_CMOVE136 = icmp eq i1 %ZF133, true
  %CMOV137 = select i1 %Cond_CMOVE136, i32 %EAX126, i32 %ESI131
  %66 = trunc i32 %CMOV137 to i16
  %EAX138 = zext i16 %66 to i32
  %67 = trunc i32 %CMOV137 to i8
  %SIL143 = xor i8 %67, %CL122
  %highbit139 = and i8 -128, %SIL143
  %SF140 = icmp ne i8 %highbit139, 0
  %ZF141 = icmp eq i8 %SIL143, 0
  %68 = call i8 @llvm.ctpop.i8(i8 %SIL143)
  %69 = and i8 %68, 1
  %PF142 = icmp eq i8 %69, 0
  %70 = trunc i32 %arg1 to i8
  %DIL = lshr i8 %70, 7
  %ZF144 = icmp eq i8 %DIL, 0
  %highbit145 = and i8 -128, %DIL
  %SF146 = icmp ne i8 %highbit145, 0
  %EAX150 = lshr i32 %EAX138, 1
  %ZF147 = icmp eq i32 %EAX150, 0
  %highbit148 = and i32 -2147483648, %EAX150
  %SF149 = icmp ne i32 %highbit148, 0
  %ECX = xor i32 %EAX150, -24575
  %71 = and i32 %ECX, 255
  %72 = call i32 @llvm.ctpop.i32(i32 %71)
  %73 = and i32 %72, 1
  %PF151 = icmp eq i32 %73, 0
  %ZF152 = icmp eq i32 %ECX, 0
  %highbit153 = and i32 -2147483648, %ECX
  %SF154 = icmp ne i32 %highbit153, 0
  %74 = and i8 %SIL143, 1
  %75 = call i8 @llvm.ctpop.i8(i8 %74)
  %76 = and i8 %75, 1
  %PF155 = icmp eq i8 %76, 0
  %ZF156 = icmp eq i8 %74, 0
  %highbit157 = and i8 -128, %74
  %SF158 = icmp ne i8 %highbit157, 0
  %Cond_CMOVE159 = icmp eq i1 %ZF156, true
  %CMOV160 = select i1 %Cond_CMOVE159, i32 %EAX150, i32 %ECX
  %77 = trunc i32 %CMOV160 to i16
  %EDX161 = zext i16 %77 to i32
  %78 = trunc i32 %CMOV160 to i8
  %CL166 = and i8 %78, 1
  %79 = call i8 @llvm.ctpop.i8(i8 %CL166)
  %80 = and i8 %79, 1
  %PF162 = icmp eq i8 %80, 0
  %ZF163 = icmp eq i8 %CL166, 0
  %highbit164 = and i8 -128, %CL166
  %SF165 = icmp ne i8 %highbit164, 0
  %EDX170 = lshr i32 %EDX161, 1
  %ZF167 = icmp eq i32 %EDX170, 0
  %highbit168 = and i32 -2147483648, %EDX170
  %SF169 = icmp ne i32 %highbit168, 0
  %EAX175 = xor i32 %EDX170, -24575
  %81 = and i32 %EAX175, 255
  %82 = call i32 @llvm.ctpop.i32(i32 %81)
  %83 = and i32 %82, 1
  %PF171 = icmp eq i32 %83, 0
  %ZF172 = icmp eq i32 %EAX175, 0
  %highbit173 = and i32 -2147483648, %EAX175
  %SF174 = icmp ne i32 %highbit173, 0
  %84 = sub i8 %DIL, %CL166
  %85 = call { i8, i1 } @llvm.usub.with.overflow.i8(i8 %DIL, i8 %CL166)
  %CF = extractvalue { i8, i1 } %85, 1
  %ZF176 = icmp eq i8 %84, 0
  %highbit177 = and i8 -128, %84
  %SF178 = icmp ne i8 %highbit177, 0
  %86 = call { i8, i1 } @llvm.ssub.with.overflow.i8(i8 %DIL, i8 %CL166)
  %OF = extractvalue { i8, i1 } %86, 1
  %87 = call i8 @llvm.ctpop.i8(i8 %84)
  %88 = and i8 %87, 1
  %PF179 = icmp eq i8 %88, 0
  %Cond_CMOVE180 = icmp eq i1 %ZF176, true
  %CMOV181 = select i1 %Cond_CMOVE180, i32 %EDX170, i32 %EAX175
  ret i32 %CMOV181
}

define dso_local i32 @foo(i32 %arg1, i32 %arg2) {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %0 = trunc i32 %arg1 to i8
  %EDI = zext i8 %0 to i32
  %EAX = call i32 @bar(i32 %EDI, i32 %arg2)
  %EBX = lshr i32 %arg1, 8
  %ZF = icmp eq i32 %EBX, 0
  %highbit = and i32 -2147483648, %EBX
  %SF = icmp ne i32 %highbit, 0
  %1 = trunc i32 %EAX to i16
  %ESI = zext i16 %1 to i32
  %EAX1 = tail call i32 @bar(i32 %EBX, i32 %ESI)
  ret i32 %EAX1
}

define dso_local i32 @call(i16 %arg1, i32 %arg2) {
entry:
  %EDI = zext i16 %arg1 to i32
  %EAX = tail call i32 @foo(i32 %EDI, i32 %arg2)
  ret i32 %EAX
}

declare dso_local i32 @printf(ptr, ...)

define dso_local i32 @bench_call() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %0 = bitcast ptr @C to ptr
  %ESI = getelementptr inbounds [16 x i32], ptr %0, i32 0, i32 0
  %EDX = getelementptr inbounds [8 x i32], ptr @A, i32 0, i32 0
  %ECX = getelementptr inbounds [8 x i32], ptr @B, i32 0, i32 0
  %1 = ptrtoint ptr %ESI to i64
  %2 = ptrtoint ptr %EDX to i64
  %3 = ptrtoint ptr %ECX to i64
  %EAX = call i32 @call_test(i32 4, i64 %1, i64 %2, i64 %3, i32 2)
  %4 = trunc i32 %EAX to i16
  %EBX = sext i16 %4 to i32
  %EAX1 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([12 x i8], ptr @rodata_14, i32 0, i32 4), i32 %EBX)
  %5 = trunc i32 %EBX to i16
  %EAX2 = call i32 @call(i16 %5, i32 258)
  %6 = trunc i32 %EAX2 to i16
  %EAX3 = zext i16 %6 to i32
  ret i32 %EAX3
}

define dso_local i32 @call_test(i32 %arg1, i64 %arg2, i64 %arg3, i64 %arg4, i32 %arg5) {
entry:
  %stktop_8 = alloca i8, i32 48, align 1
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
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 %arg4, ptr %RSP_P.16, align 1
  store i64 %arg3, ptr %RSP_P.8, align 1
  %EBX = or i32 %arg5, 61440
  %3 = and i32 %EBX, 255
  %4 = call i32 @llvm.ctpop.i32(i32 %3)
  %5 = and i32 %4, 1
  %PF = icmp eq i32 %5, 0
  %ZF = icmp eq i32 %EBX, 0
  %highbit = and i32 -2147483648, %EBX
  %SF = icmp ne i32 %highbit, 0
  %6 = trunc i32 %arg5 to i16
  call void @call_mul_const(i32 %arg1, i64 %arg2, i64 %arg3, i16 %6)
  %7 = trunc i32 %EBX to i16
  %R13D = sext i16 %7 to i32
  %8 = trunc i32 %R13D to i16
  %EAX = call i32 @call_sum(i32 %arg1, i64 %arg2, i16 %8)
  %9 = trunc i32 %EAX to i16
  %EDI = sext i16 %9 to i32
  %10 = trunc i32 %EDI to i16
  %EAX1 = call i32 @call(i16 %10, i32 0)
  %memload = load i64, ptr %RSP_P.8, align 1
  %memload2 = load i64, ptr %RSP_P.16, align 1
  call void @call_mul_vect(i32 %arg1, i64 %arg2, i64 %memload, i64 %memload2)
  %11 = trunc i32 %R13D to i16
  %EAX3 = call i32 @call_sum(i32 %arg1, i64 %arg2, i16 %11)
  %12 = trunc i32 %EAX1 to i16
  %ESI = zext i16 %12 to i32
  %13 = trunc i32 %EAX3 to i16
  %EDI4 = sext i16 %13 to i32
  %14 = trunc i32 %EDI4 to i16
  %EAX5 = call i32 @call(i16 %14, i32 %ESI)
  %CF = icmp ne i32 0, 0
  %R15D = sub i32 0, %arg5
  %ZF6 = icmp eq i32 %R15D, 0
  %highbit7 = and i32 -2147483648, %R15D
  %SF8 = icmp ne i32 %highbit7, 0
  %15 = and i32 %R15D, 255
  %16 = call i32 @llvm.ctpop.i32(i32 %15)
  %17 = and i32 %16, 1
  %PF9 = icmp eq i32 %17, 0
  %18 = trunc i32 %R15D to i16
  %EDX = sext i16 %18 to i32
  %19 = trunc i32 %EDX to i16
  call void @call_add_const(i32 %arg1, i64 %memload, i16 %19)
  ret i32 %EAX5
}

define dso_local void @call_mul_const(i32 %arg1, i64 %arg2, i64 %arg3, i16 %arg4) {
entry:
  %R10D-SKT-LOC95 = alloca i64, align 8
  %R11D-SKT-LOC = alloca i64, align 8
  %RCX-SKT-LOC = alloca i64, align 8
  %EBX-SKT-LOC70 = alloca i64, align 8
  %R10D-SKT-LOC64 = alloca i64, align 8
  %EBX-SKT-LOC = alloca i64, align 8
  %RBX-SKT-LOC = alloca i64, align 8
  %ECX-SKT-LOC = alloca i64, align 8
  %R10D-SKT-LOC = alloca i64, align 8
  %stktop_8 = alloca i8, i32 8, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  %0 = and i32 %arg1, %arg1
  %highbit = and i32 -2147483648, %0
  %SF = icmp ne i32 %highbit, 0
  %ZF = icmp eq i32 %0, 0
  %1 = and i32 %0, 255
  %2 = call i32 @llvm.ctpop.i32(i32 %1)
  %3 = and i32 %2, 1
  %PF = icmp eq i32 %3, 0
  %CmpZF_JE = icmp eq i1 %ZF, true
  br i1 %CmpZF_JE, label %bb.13, label %bb.1

bb.1:                                             ; preds = %entry
  %R15D = sext i16 %arg4 to i32
  %memref-disp = add i32 %arg1, -1
  %R8 = zext i32 %memref-disp to i64
  %R9D = and i32 %arg1, 3
  %4 = and i32 %R9D, 255
  %5 = call i32 @llvm.ctpop.i32(i32 %4)
  %6 = and i32 %5, 1
  %PF1 = icmp eq i32 %6, 0
  %ZF2 = icmp eq i32 %R9D, 0
  %highbit3 = and i32 -2147483648, %R9D
  %SF4 = icmp ne i32 %highbit3, 0
  %R14D = and i32 %arg1, -4
  %7 = and i32 %R14D, 255
  %8 = call i32 @llvm.ctpop.i32(i32 %7)
  %9 = and i32 %8, 1
  %PF5 = icmp eq i32 %9, 0
  %ZF6 = icmp eq i32 %R14D, 0
  %highbit7 = and i32 -2147483648, %R14D
  %SF8 = icmp ne i32 %highbit7, 0
  %10 = zext i32 0 to i64
  store i64 %10, ptr %R10D-SKT-LOC, align 1
  %11 = zext i32 0 to i64
  store i64 %11, ptr %R10D-SKT-LOC64, align 1
  %12 = zext i32 0 to i64
  store i64 %12, ptr %R11D-SKT-LOC, align 1
  %13 = zext i32 0 to i64
  store i64 %13, ptr %R10D-SKT-LOC95, align 1
  br label %bb.4

bb.4:                                             ; preds = %bb.3, %bb.1
  %14 = sub i64 %R8, 3
  %15 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %R8, i64 3)
  %CF = extractvalue { i64, i1 } %15, 1
  %ZF9 = icmp eq i64 %14, 0
  %highbit10 = and i64 -9223372036854775808, %14
  %SF11 = icmp ne i64 %highbit10, 0
  %16 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %R8, i64 3)
  %OF = extractvalue { i64, i1 } %16, 1
  %17 = and i64 %14, 255
  %18 = call i64 @llvm.ctpop.i64(i64 %17)
  %19 = and i64 %18, 1
  %PF12 = icmp eq i64 %19, 0
  %CFCmp_JAE = icmp eq i1 %CF, false
  br i1 %CFCmp_JAE, label %bb.7, label %bb.5

bb.5:                                             ; preds = %bb.4
  %20 = zext i32 0 to i64
  store i64 %20, ptr %EBX-SKT-LOC, align 1
  br label %bb.9

bb.7:                                             ; preds = %bb.4
  %21 = load i64, ptr %R10D-SKT-LOC, align 1
  %R10D = trunc i64 %21 to i32
  %22 = zext i32 %R10D to i64
  store i64 %22, ptr %ECX-SKT-LOC, align 1
  %23 = zext i32 0 to i64
  store i64 %23, ptr %RBX-SKT-LOC, align 1
  %24 = zext i32 %R10D to i64
  store i64 %24, ptr %R10D-SKT-LOC64, align 1
  %25 = zext i32 %R10D to i64
  store i64 %25, ptr %R10D-SKT-LOC95, align 1
  br label %bb.8

bb.8:                                             ; preds = %bb.7, %bb.8
  %26 = load i64, ptr %ECX-SKT-LOC, align 1
  %ECX = trunc i64 %26 to i32
  %27 = zext i32 %ECX to i64
  %memref-idxreg = mul i64 2, %27
  %memref-basereg = add i64 %arg3, %memref-idxreg
  %28 = inttoptr i64 %memref-basereg to ptr
  %memload = load i32, ptr %28, align 1
  %29 = trunc i32 %memload to i16
  %EBP = sext i16 %29 to i32
  %EBP13 = mul nsw i32 %EBP, %R15D
  %30 = zext i32 %ECX to i64
  %memref-idxreg14 = mul i64 4, %30
  %memref-basereg15 = add i64 %arg2, %memref-idxreg14
  %31 = inttoptr i64 %memref-basereg15 to ptr
  store i32 %EBP13, ptr %31, align 1
  %memref-disp16 = add i32 %ECX, 1
  %32 = zext i32 %memref-disp16 to i64
  %memref-idxreg17 = mul i64 2, %32
  %memref-basereg18 = add i64 %arg3, %memref-idxreg17
  %33 = inttoptr i64 %memref-basereg18 to ptr
  %memload19 = load i32, ptr %33, align 1
  %34 = trunc i32 %memload19 to i16
  %EBP20 = sext i16 %34 to i32
  %EBP21 = mul nsw i32 %EBP20, %R15D
  %35 = zext i32 %memref-disp16 to i64
  %memref-idxreg22 = mul i64 4, %35
  %memref-basereg23 = add i64 %arg2, %memref-idxreg22
  %36 = inttoptr i64 %memref-basereg23 to ptr
  store i32 %EBP21, ptr %36, align 1
  %memref-disp24 = add i32 %ECX, 2
  %37 = zext i32 %memref-disp24 to i64
  %memref-idxreg25 = mul i64 2, %37
  %memref-basereg26 = add i64 %arg3, %memref-idxreg25
  %38 = inttoptr i64 %memref-basereg26 to ptr
  %memload27 = load i32, ptr %38, align 1
  %39 = trunc i32 %memload27 to i16
  %EBP28 = sext i16 %39 to i32
  %EBP29 = mul nsw i32 %EBP28, %R15D
  %40 = zext i32 %memref-disp24 to i64
  %memref-idxreg30 = mul i64 4, %40
  %memref-basereg31 = add i64 %arg2, %memref-idxreg30
  %41 = inttoptr i64 %memref-basereg31 to ptr
  store i32 %EBP29, ptr %41, align 1
  %memref-disp32 = add i32 %ECX, 3
  %42 = zext i32 %memref-disp32 to i64
  %memref-idxreg33 = mul i64 2, %42
  %memref-basereg34 = add i64 %arg3, %memref-idxreg33
  %43 = inttoptr i64 %memref-basereg34 to ptr
  %memload35 = load i32, ptr %43, align 1
  %44 = trunc i32 %memload35 to i16
  %EBP36 = sext i16 %44 to i32
  %EBP37 = mul nsw i32 %EBP36, %R15D
  %45 = zext i32 %memref-disp32 to i64
  %memref-idxreg38 = mul i64 4, %45
  %memref-basereg39 = add i64 %arg2, %memref-idxreg38
  %46 = inttoptr i64 %memref-basereg39 to ptr
  store i32 %EBP37, ptr %46, align 1
  %RBX = load i64, ptr %RBX-SKT-LOC, align 1
  %RBX46 = add i64 %RBX, 4
  %47 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %RBX, i64 4)
  %CF40 = extractvalue { i64, i1 } %47, 1
  %48 = and i64 %RBX46, 255
  %49 = call i64 @llvm.ctpop.i64(i64 %48)
  %50 = and i64 %49, 1
  %PF41 = icmp eq i64 %50, 0
  %ZF42 = icmp eq i64 %RBX46, 0
  %highbit43 = and i64 -9223372036854775808, %RBX46
  %SF44 = icmp ne i64 %highbit43, 0
  %51 = call { i64, i1 } @llvm.sadd.with.overflow.i64(i64 %RBX, i64 4)
  %OF45 = extractvalue { i64, i1 } %51, 1
  %ECX53 = add i32 %ECX, 4
  %52 = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 %ECX, i32 4)
  %CF47 = extractvalue { i32, i1 } %52, 1
  %53 = and i32 %ECX53, 255
  %54 = call i32 @llvm.ctpop.i32(i32 %53)
  %55 = and i32 %54, 1
  %PF48 = icmp eq i32 %55, 0
  %ZF49 = icmp eq i32 %ECX53, 0
  %highbit50 = and i32 -2147483648, %ECX53
  %SF51 = icmp ne i32 %highbit50, 0
  %56 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %ECX, i32 4)
  %OF52 = extractvalue { i32, i1 } %56, 1
  %57 = zext i32 %R14D to i64
  %58 = sub i64 %57, %RBX46
  %59 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %57, i64 %RBX46)
  %CF54 = extractvalue { i64, i1 } %59, 1
  %ZF55 = icmp eq i64 %58, 0
  %highbit56 = and i64 -9223372036854775808, %58
  %SF57 = icmp ne i64 %highbit56, 0
  %60 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %57, i64 %RBX46)
  %OF58 = extractvalue { i64, i1 } %60, 1
  %61 = and i64 %58, 255
  %62 = call i64 @llvm.ctpop.i64(i64 %61)
  %63 = and i64 %62, 1
  %PF59 = icmp eq i64 %63, 0
  store i64 %RBX46, ptr %EBX-SKT-LOC, align 1
  %CmpZF_JNE = icmp eq i1 %ZF55, false
  %64 = zext i32 %ECX53 to i64
  store i64 %64, ptr %ECX-SKT-LOC, align 1
  store i64 %RBX46, ptr %RBX-SKT-LOC, align 1
  br i1 %CmpZF_JNE, label %bb.8, label %bb.9

bb.9:                                             ; preds = %bb.8, %bb.5
  %65 = zext i32 %R9D to i64
  %66 = zext i32 %R9D to i64
  %67 = and i64 %65, %66
  %highbit60 = and i64 -9223372036854775808, %67
  %SF61 = icmp ne i64 %highbit60, 0
  %ZF62 = icmp eq i64 %67, 0
  %68 = and i64 %67, 255
  %69 = call i64 @llvm.ctpop.i64(i64 %68)
  %70 = and i64 %69, 1
  %PF63 = icmp eq i64 %70, 0
  %CmpZF_JE107 = icmp eq i1 %ZF62, true
  br i1 %CmpZF_JE107, label %bb.3, label %bb.10

bb.10:                                            ; preds = %bb.9
  %71 = load i64, ptr %EBX-SKT-LOC, align 1
  %EBX = trunc i64 %71 to i32
  %72 = load i64, ptr %R10D-SKT-LOC64, align 1
  %R10D65 = trunc i64 %72 to i32
  %EBX69 = add nsw i32 %EBX, %R10D65
  %highbit66 = and i32 -2147483648, %EBX69
  %SF67 = icmp ne i32 %highbit66, 0
  %ZF68 = icmp eq i32 %EBX69, 0
  %RCX = zext i32 %R9D to i64
  %73 = zext i32 %EBX69 to i64
  store i64 %73, ptr %EBX-SKT-LOC70, align 1
  store i64 %RCX, ptr %RCX-SKT-LOC, align 1
  %74 = zext i32 %R10D65 to i64
  store i64 %74, ptr %R10D-SKT-LOC95, align 1
  br label %bb.11

bb.11:                                            ; preds = %bb.10, %bb.11
  %75 = load i64, ptr %EBX-SKT-LOC70, align 1
  %EBX71 = trunc i64 %75 to i32
  %76 = zext i32 %EBX71 to i64
  %memref-idxreg72 = mul i64 2, %76
  %memref-basereg73 = add i64 %arg3, %memref-idxreg72
  %77 = inttoptr i64 %memref-basereg73 to ptr
  %memload74 = load i32, ptr %77, align 1
  %78 = trunc i32 %memload74 to i16
  %EBP75 = sext i16 %78 to i32
  %EBP76 = mul nsw i32 %EBP75, %R15D
  %79 = zext i32 %EBX71 to i64
  %memref-idxreg77 = mul i64 4, %79
  %memref-basereg78 = add i64 %arg2, %memref-idxreg77
  %80 = inttoptr i64 %memref-basereg78 to ptr
  store i32 %EBP76, ptr %80, align 1
  %EBX83 = add i32 %EBX71, 1
  %81 = and i32 %EBX83, 255
  %82 = call i32 @llvm.ctpop.i32(i32 %81)
  %83 = and i32 %82, 1
  %PF79 = icmp eq i32 %83, 0
  %ZF80 = icmp eq i32 %EBX83, 0
  %highbit81 = and i32 -2147483648, %EBX83
  %SF82 = icmp ne i32 %highbit81, 0
  %RCX84 = load i64, ptr %RCX-SKT-LOC, align 1
  %RCX89 = sub i64 %RCX84, 1
  %84 = and i64 %RCX89, 255
  %85 = call i64 @llvm.ctpop.i64(i64 %84)
  %86 = and i64 %85, 1
  %PF85 = icmp eq i64 %86, 0
  %ZF86 = icmp eq i64 %RCX89, 0
  %highbit87 = and i64 -9223372036854775808, %RCX89
  %SF88 = icmp ne i64 %highbit87, 0
  %CmpZF_JNE108 = icmp eq i1 %ZF86, false
  %87 = zext i32 %EBX83 to i64
  store i64 %87, ptr %EBX-SKT-LOC70, align 1
  store i64 %RCX89, ptr %RCX-SKT-LOC, align 1
  br i1 %CmpZF_JNE108, label %bb.11, label %bb.12

bb.12:                                            ; preds = %bb.11
  br label %bb.3

bb.3:                                             ; preds = %bb.12, %bb.9
  %88 = load i64, ptr %R11D-SKT-LOC, align 1
  %R11D = trunc i64 %88 to i32
  %R11D94 = add i32 %R11D, 1
  %89 = and i32 %R11D94, 255
  %90 = call i32 @llvm.ctpop.i32(i32 %89)
  %91 = and i32 %90, 1
  %PF90 = icmp eq i32 %91, 0
  %ZF91 = icmp eq i32 %R11D94, 0
  %highbit92 = and i32 -2147483648, %R11D94
  %SF93 = icmp ne i32 %highbit92, 0
  %92 = load i64, ptr %R10D-SKT-LOC95, align 1
  %R10D96 = trunc i64 %92 to i32
  %R10D100 = add nsw i32 %R10D96, %arg1
  %highbit97 = and i32 -2147483648, %R10D100
  %SF98 = icmp ne i32 %highbit97, 0
  %ZF99 = icmp eq i32 %R10D100, 0
  %93 = sub i32 %R11D94, %arg1
  %94 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %R11D94, i32 %arg1)
  %CF101 = extractvalue { i32, i1 } %94, 1
  %ZF102 = icmp eq i32 %93, 0
  %highbit103 = and i32 -2147483648, %93
  %SF104 = icmp ne i32 %highbit103, 0
  %95 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %R11D94, i32 %arg1)
  %OF105 = extractvalue { i32, i1 } %95, 1
  %96 = and i32 %93, 255
  %97 = call i32 @llvm.ctpop.i32(i32 %96)
  %98 = and i32 %97, 1
  %PF106 = icmp eq i32 %98, 0
  %CmpZF_JE109 = icmp eq i1 %ZF102, true
  %99 = zext i32 %R10D100 to i64
  store i64 %99, ptr %R10D-SKT-LOC64, align 1
  %100 = zext i32 %R10D100 to i64
  store i64 %100, ptr %R10D-SKT-LOC, align 1
  %101 = zext i32 %R10D100 to i64
  store i64 %101, ptr %R10D-SKT-LOC95, align 1
  %102 = zext i32 %R11D94 to i64
  store i64 %102, ptr %R11D-SKT-LOC, align 1
  br i1 %CmpZF_JE109, label %bb.13, label %bb.4

bb.13:                                            ; preds = %bb.3, %entry
  ret void
}

define dso_local i32 @call_sum(i32 %arg1, i64 %arg2, i16 %arg3) {
entry:
  %EAX-SKT-LOC159 = alloca i32, align 4
  %R10D-SKT-LOC147 = alloca i64, align 8
  %R14D-SKT-LOC140 = alloca i64, align 8
  %EAX-SKT-LOC134 = alloca i64, align 8
  %R13D-SKT-LOC109 = alloca i64, align 8
  %EBP-SKT-LOC103 = alloca i64, align 8
  %ECX-SKT-LOC = alloca i64, align 8
  %R14D-SKT-LOC = alloca i64, align 8
  %RCX-SKT-LOC = alloca i64, align 8
  %EBX-SKT-LOC = alloca i64, align 8
  %R13D-SKT-LOC = alloca i64, align 8
  %EBP-SKT-LOC = alloca i64, align 8
  %RDX-SKT-LOC = alloca i64, align 8
  %EAX-SKT-LOC = alloca i64, align 8
  %R10D-SKT-LOC = alloca i64, align 8
  %stktop_8 = alloca i8, i32 16, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  %0 = add i64 %tos, 0
  %RSP_P.0 = inttoptr i64 %0 to ptr
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  %1 = and i32 %arg1, %arg1
  %highbit = and i32 -2147483648, %1
  %SF = icmp ne i32 %highbit, 0
  %ZF = icmp eq i32 %1, 0
  %2 = and i32 %1, 255
  %3 = call i32 @llvm.ctpop.i32(i32 %2)
  %4 = and i32 %3, 1
  %PF = icmp eq i32 %4, 0
  %CmpZF_JE = icmp eq i1 %ZF, true
  br i1 %CmpZF_JE, label %bb.11, label %bb.1

bb.1:                                             ; preds = %entry
  %R12D = sext i16 %arg3 to i32
  %5 = zext i32 %arg1 to i64
  store i64 %5, ptr %stktop_8, align 1
  %R11D = and i32 %arg1, -2
  %6 = and i32 %R11D, 255
  %7 = call i32 @llvm.ctpop.i32(i32 %6)
  %8 = and i32 %7, 1
  %PF1 = icmp eq i32 %8, 0
  %ZF2 = icmp eq i32 %R11D, 0
  %highbit3 = and i32 -2147483648, %R11D
  %SF4 = icmp ne i32 %highbit3, 0
  %9 = zext i32 1 to i64
  store i64 %9, ptr %R10D-SKT-LOC, align 1
  %10 = zext i32 0 to i64
  store i64 %10, ptr %EAX-SKT-LOC, align 1
  %11 = zext i32 0 to i64
  store i64 %11, ptr %EBP-SKT-LOC, align 1
  %12 = zext i32 0 to i64
  store i64 %12, ptr %R13D-SKT-LOC, align 1
  %13 = zext i32 0 to i64
  store i64 %13, ptr %R14D-SKT-LOC, align 1
  %14 = zext i32 0 to i64
  store i64 %14, ptr %EBP-SKT-LOC103, align 1
  %15 = zext i32 0 to i64
  store i64 %15, ptr %R13D-SKT-LOC109, align 1
  %16 = zext i32 0 to i64
  store i64 %16, ptr %EAX-SKT-LOC134, align 1
  %17 = zext i32 0 to i64
  store i64 %17, ptr %R14D-SKT-LOC140, align 1
  %18 = zext i32 1 to i64
  store i64 %18, ptr %R10D-SKT-LOC147, align 1
  store i32 0, ptr %EAX-SKT-LOC159, align 1
  br label %bb.4

bb.4:                                             ; preds = %bb.3, %bb.1
  %19 = sub i32 %arg1, 1
  %20 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %arg1, i32 1)
  %CF = extractvalue { i32, i1 } %20, 1
  %ZF5 = icmp eq i32 %19, 0
  %highbit6 = and i32 -2147483648, %19
  %SF7 = icmp ne i32 %highbit6, 0
  %21 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %arg1, i32 1)
  %OF = extractvalue { i32, i1 } %21, 1
  %22 = and i32 %19, 255
  %23 = call i32 @llvm.ctpop.i32(i32 %22)
  %24 = and i32 %23, 1
  %PF8 = icmp eq i32 %24, 0
  %CmpZF_JNE = icmp eq i1 %ZF5, false
  br i1 %CmpZF_JNE, label %bb.7, label %bb.5

bb.5:                                             ; preds = %bb.4
  %25 = zext i32 0 to i64
  store i64 %25, ptr %ECX-SKT-LOC, align 1
  br label %bb.9

bb.7:                                             ; preds = %bb.4
  %26 = load i64, ptr %R10D-SKT-LOC, align 1
  %R10D = trunc i64 %26 to i32
  %27 = load i64, ptr %EAX-SKT-LOC, align 1
  %EAX = trunc i64 %27 to i32
  %28 = zext i32 %R10D to i64
  store i64 %28, ptr %RDX-SKT-LOC, align 1
  %29 = zext i32 %EAX to i64
  store i64 %29, ptr %EBX-SKT-LOC, align 1
  %30 = zext i32 0 to i64
  store i64 %30, ptr %RCX-SKT-LOC, align 1
  %31 = zext i32 %R10D to i64
  store i64 %31, ptr %R10D-SKT-LOC147, align 1
  br label %bb.8

bb.8:                                             ; preds = %bb.7, %bb.8
  %RDX = load i64, ptr %RDX-SKT-LOC, align 1
  %memref-disp = add i64 %RDX, -1
  %EAX9 = trunc i64 %memref-disp to i32
  %32 = zext i32 %EAX9 to i64
  %memref-idxreg = mul i64 4, %32
  %memref-basereg = add i64 %arg2, %memref-idxreg
  %33 = inttoptr i64 %memref-basereg to ptr
  %memload = load i32, ptr %33, align 1
  %34 = load i64, ptr %EBP-SKT-LOC, align 1
  %EBP = trunc i64 %34 to i32
  %EBP13 = add nsw i32 %EBP, %memload
  %highbit10 = and i32 -2147483648, %EBP13
  %SF11 = icmp ne i32 %highbit10, 0
  %ZF12 = icmp eq i32 %EBP13, 0
  %35 = load i64, ptr %R13D-SKT-LOC, align 1
  %R13D = trunc i64 %35 to i32
  %36 = sub i32 %memload, %R13D
  %37 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload, i32 %R13D)
  %CF14 = extractvalue { i32, i1 } %37, 1
  %ZF15 = icmp eq i32 %36, 0
  %highbit16 = and i32 -2147483648, %36
  %SF17 = icmp ne i32 %highbit16, 0
  %38 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload, i32 %R13D)
  %OF18 = extractvalue { i32, i1 } %38, 1
  %39 = and i32 %36, 255
  %40 = call i32 @llvm.ctpop.i32(i32 %39)
  %41 = and i32 %40, 1
  %PF19 = icmp eq i32 %41, 0
  %ZFCmp_CMOVG = icmp eq i1 %ZF15, false
  %SFOFCmp_CMOVG = icmp eq i1 %SF17, %OF18
  %Cond_CMOVG = and i1 %ZFCmp_CMOVG, %SFOFCmp_CMOVG
  %42 = sub i32 %EBP13, %R12D
  %43 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %EBP13, i32 %R12D)
  %CF20 = extractvalue { i32, i1 } %43, 1
  %ZF21 = icmp eq i32 %42, 0
  %highbit22 = and i32 -2147483648, %42
  %SF23 = icmp ne i32 %highbit22, 0
  %44 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %EBP13, i32 %R12D)
  %OF24 = extractvalue { i32, i1 } %44, 1
  %45 = and i32 %42, 255
  %46 = call i32 @llvm.ctpop.i32(i32 %45)
  %47 = and i32 %46, 1
  %PF25 = icmp eq i32 %47, 0
  %ZFCmp_CMOVG26 = icmp eq i1 %ZF21, false
  %SFOFCmp_CMOVG27 = icmp eq i1 %SF23, %OF24
  %Cond_CMOVG28 = and i1 %ZFCmp_CMOVG26, %SFOFCmp_CMOVG27
  %CMOV = select i1 %Cond_CMOVG28, i32 0, i32 %EBP13
  %ZFCmp_CMOVG29 = icmp eq i1 %ZF21, false
  %SFOFCmp_CMOVG30 = icmp eq i1 %SF23, %OF24
  %Cond_CMOVG31 = and i1 %ZFCmp_CMOVG29, %SFOFCmp_CMOVG30
  %48 = zext i1 %Cond_CMOVG to i32
  %CMOV32 = select i1 %Cond_CMOVG31, i32 10, i32 %48
  %49 = load i64, ptr %EBX-SKT-LOC, align 1
  %EBX = trunc i64 %49 to i32
  %EBX36 = add nsw i32 %EBX, %CMOV32
  %highbit33 = and i32 -2147483648, %EBX36
  %SF34 = icmp ne i32 %highbit33, 0
  %ZF35 = icmp eq i32 %EBX36, 0
  %EAX37 = trunc i64 %RDX to i32
  %50 = zext i32 %EAX37 to i64
  %memref-idxreg38 = mul i64 4, %50
  %memref-basereg39 = add i64 %arg2, %memref-idxreg38
  %51 = inttoptr i64 %memref-basereg39 to ptr
  %memload40 = load i32, ptr %51, align 1
  %EBP44 = add nsw i32 %CMOV, %memload40
  %highbit41 = and i32 -2147483648, %EBP44
  %SF42 = icmp ne i32 %highbit41, 0
  %ZF43 = icmp eq i32 %EBP44, 0
  %52 = sub i32 %memload40, %memload
  %53 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload40, i32 %memload)
  %CF45 = extractvalue { i32, i1 } %53, 1
  %ZF46 = icmp eq i32 %52, 0
  %highbit47 = and i32 -2147483648, %52
  %SF48 = icmp ne i32 %highbit47, 0
  %54 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload40, i32 %memload)
  %OF49 = extractvalue { i32, i1 } %54, 1
  %55 = and i32 %52, 255
  %56 = call i32 @llvm.ctpop.i32(i32 %55)
  %57 = and i32 %56, 1
  %PF50 = icmp eq i32 %57, 0
  %ZFCmp_CMOVG51 = icmp eq i1 %ZF46, false
  %SFOFCmp_CMOVG52 = icmp eq i1 %SF48, %OF49
  %Cond_CMOVG53 = and i1 %ZFCmp_CMOVG51, %SFOFCmp_CMOVG52
  %58 = sub i32 %EBP44, %R12D
  %59 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %EBP44, i32 %R12D)
  %CF54 = extractvalue { i32, i1 } %59, 1
  %ZF55 = icmp eq i32 %58, 0
  %highbit56 = and i32 -2147483648, %58
  %SF57 = icmp ne i32 %highbit56, 0
  %60 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %EBP44, i32 %R12D)
  %OF58 = extractvalue { i32, i1 } %60, 1
  %61 = and i32 %58, 255
  %62 = call i32 @llvm.ctpop.i32(i32 %61)
  %63 = and i32 %62, 1
  %PF59 = icmp eq i32 %63, 0
  %ZFCmp_CMOVG60 = icmp eq i1 %ZF55, false
  %SFOFCmp_CMOVG61 = icmp eq i1 %SF57, %OF58
  %Cond_CMOVG62 = and i1 %ZFCmp_CMOVG60, %SFOFCmp_CMOVG61
  %CMOV63 = select i1 %Cond_CMOVG62, i32 0, i32 %EBP44
  %ZFCmp_CMOVG64 = icmp eq i1 %ZF55, false
  %SFOFCmp_CMOVG65 = icmp eq i1 %SF57, %OF58
  %Cond_CMOVG66 = and i1 %ZFCmp_CMOVG64, %SFOFCmp_CMOVG65
  %64 = zext i1 %Cond_CMOVG53 to i32
  %CMOV67 = select i1 %Cond_CMOVG66, i32 10, i32 %64
  %EAX71 = add nsw i32 %CMOV67, %EBX36
  %highbit68 = and i32 -2147483648, %EAX71
  %SF69 = icmp ne i32 %highbit68, 0
  %ZF70 = icmp eq i32 %EAX71, 0
  %RCX = load i64, ptr %RCX-SKT-LOC, align 1
  %RCX78 = add i64 %RCX, 2
  %65 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %RCX, i64 2)
  %CF72 = extractvalue { i64, i1 } %65, 1
  %66 = and i64 %RCX78, 255
  %67 = call i64 @llvm.ctpop.i64(i64 %66)
  %68 = and i64 %67, 1
  %PF73 = icmp eq i64 %68, 0
  %ZF74 = icmp eq i64 %RCX78, 0
  %highbit75 = and i64 -9223372036854775808, %RCX78
  %SF76 = icmp ne i64 %highbit75, 0
  %69 = call { i64, i1 } @llvm.sadd.with.overflow.i64(i64 %RCX, i64 2)
  %OF77 = extractvalue { i64, i1 } %69, 1
  %70 = trunc i64 %RDX to i32
  %EDX = add i32 %70, 2
  %71 = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 %70, i32 2)
  %CF79 = extractvalue { i32, i1 } %71, 1
  %72 = and i32 %EDX, 255
  %73 = call i32 @llvm.ctpop.i32(i32 %72)
  %74 = and i32 %73, 1
  %PF80 = icmp eq i32 %74, 0
  %ZF81 = icmp eq i32 %EDX, 0
  %highbit82 = and i32 -2147483648, %EDX
  %SF83 = icmp ne i32 %highbit82, 0
  %75 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %70, i32 2)
  %OF84 = extractvalue { i32, i1 } %75, 1
  %76 = zext i32 %R11D to i64
  %77 = sub i64 %76, %RCX78
  %78 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %76, i64 %RCX78)
  %CF85 = extractvalue { i64, i1 } %78, 1
  %ZF86 = icmp eq i64 %77, 0
  %highbit87 = and i64 -9223372036854775808, %77
  %SF88 = icmp ne i64 %highbit87, 0
  %79 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %76, i64 %RCX78)
  %OF89 = extractvalue { i64, i1 } %79, 1
  %80 = and i64 %77, 255
  %81 = call i64 @llvm.ctpop.i64(i64 %80)
  %82 = and i64 %81, 1
  %PF90 = icmp eq i64 %82, 0
  store i64 %RCX78, ptr %ECX-SKT-LOC, align 1
  %83 = zext i32 %CMOV63 to i64
  store i64 %83, ptr %EBP-SKT-LOC103, align 1
  %84 = zext i32 %memload40 to i64
  store i64 %84, ptr %R13D-SKT-LOC109, align 1
  %85 = zext i32 %EAX71 to i64
  store i64 %85, ptr %EAX-SKT-LOC134, align 1
  store i32 %EAX71, ptr %EAX-SKT-LOC159, align 1
  %CmpZF_JNE161 = icmp eq i1 %ZF86, false
  %86 = zext i32 %EAX71 to i64
  store i64 %86, ptr %EAX-SKT-LOC, align 1
  %87 = zext i32 %CMOV63 to i64
  store i64 %87, ptr %EBP-SKT-LOC, align 1
  %88 = zext i32 %EAX71 to i64
  store i64 %88, ptr %EBX-SKT-LOC, align 1
  store i64 %RCX78, ptr %RCX-SKT-LOC, align 1
  %89 = zext i32 %EDX to i64
  store i64 %89, ptr %RDX-SKT-LOC, align 1
  %90 = zext i32 %memload40 to i64
  store i64 %90, ptr %R13D-SKT-LOC, align 1
  br i1 %CmpZF_JNE161, label %bb.8, label %bb.9

bb.9:                                             ; preds = %bb.8, %bb.5
  %91 = load i8, ptr %stktop_8, align 1
  %92 = zext i8 %91 to i64
  %93 = zext i8 1 to i64
  %94 = and i64 %92, %93
  %ZF91 = icmp eq i64 %94, 0
  %highbit92 = and i64 -9223372036854775808, %94
  %SF93 = icmp ne i64 %highbit92, 0
  %95 = and i64 %94, 255
  %96 = call i64 @llvm.ctpop.i64(i64 %95)
  %97 = and i64 %96, 1
  %PF94 = icmp eq i64 %97, 0
  %CmpZF_JE162 = icmp eq i1 %ZF91, true
  br i1 %CmpZF_JE162, label %bb.3, label %bb.10

bb.10:                                            ; preds = %bb.9
  %98 = load i64, ptr %R14D-SKT-LOC, align 1
  %R14D = trunc i64 %98 to i32
  %EDX95 = mul nsw i32 %R14D, %arg1
  %99 = load i64, ptr %ECX-SKT-LOC, align 1
  %ECX = trunc i64 %99 to i32
  %ECX99 = add nsw i32 %ECX, %EDX95
  %highbit96 = and i32 -2147483648, %ECX99
  %SF97 = icmp ne i32 %highbit96, 0
  %ZF98 = icmp eq i32 %ECX99, 0
  %100 = zext i32 %ECX99 to i64
  %memref-idxreg100 = mul i64 4, %100
  %memref-basereg101 = add i64 %arg2, %memref-idxreg100
  %101 = inttoptr i64 %memref-basereg101 to ptr
  %memload102 = load i32, ptr %101, align 1
  %102 = load i64, ptr %EBP-SKT-LOC103, align 1
  %EBP104 = trunc i64 %102 to i32
  %EBP108 = add nsw i32 %EBP104, %memload102
  %highbit105 = and i32 -2147483648, %EBP108
  %SF106 = icmp ne i32 %highbit105, 0
  %ZF107 = icmp eq i32 %EBP108, 0
  %103 = load i64, ptr %R13D-SKT-LOC109, align 1
  %R13D110 = trunc i64 %103 to i32
  %104 = sub i32 %memload102, %R13D110
  %105 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %memload102, i32 %R13D110)
  %CF111 = extractvalue { i32, i1 } %105, 1
  %ZF112 = icmp eq i32 %104, 0
  %highbit113 = and i32 -2147483648, %104
  %SF114 = icmp ne i32 %highbit113, 0
  %106 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %memload102, i32 %R13D110)
  %OF115 = extractvalue { i32, i1 } %106, 1
  %107 = and i32 %104, 255
  %108 = call i32 @llvm.ctpop.i32(i32 %107)
  %109 = and i32 %108, 1
  %PF116 = icmp eq i32 %109, 0
  %ZFCmp_CMOVG117 = icmp eq i1 %ZF112, false
  %SFOFCmp_CMOVG118 = icmp eq i1 %SF114, %OF115
  %Cond_CMOVG119 = and i1 %ZFCmp_CMOVG117, %SFOFCmp_CMOVG118
  %110 = sub i32 %EBP108, %R12D
  %111 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %EBP108, i32 %R12D)
  %CF120 = extractvalue { i32, i1 } %111, 1
  %ZF121 = icmp eq i32 %110, 0
  %highbit122 = and i32 -2147483648, %110
  %SF123 = icmp ne i32 %highbit122, 0
  %112 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %EBP108, i32 %R12D)
  %OF124 = extractvalue { i32, i1 } %112, 1
  %113 = and i32 %110, 255
  %114 = call i32 @llvm.ctpop.i32(i32 %113)
  %115 = and i32 %114, 1
  %PF125 = icmp eq i32 %115, 0
  %ZFCmp_CMOVG126 = icmp eq i1 %ZF121, false
  %SFOFCmp_CMOVG127 = icmp eq i1 %SF123, %OF124
  %Cond_CMOVG128 = and i1 %ZFCmp_CMOVG126, %SFOFCmp_CMOVG127
  %CMOV129 = select i1 %Cond_CMOVG128, i32 0, i32 %EBP108
  %ZFCmp_CMOVG130 = icmp eq i1 %ZF121, false
  %SFOFCmp_CMOVG131 = icmp eq i1 %SF123, %OF124
  %Cond_CMOVG132 = and i1 %ZFCmp_CMOVG130, %SFOFCmp_CMOVG131
  %116 = zext i1 %Cond_CMOVG119 to i32
  %CMOV133 = select i1 %Cond_CMOVG132, i32 10, i32 %116
  %117 = load i64, ptr %EAX-SKT-LOC134, align 1
  %EAX135 = trunc i64 %117 to i32
  %EAX139 = add nsw i32 %EAX135, %CMOV133
  %highbit136 = and i32 -2147483648, %EAX139
  %SF137 = icmp ne i32 %highbit136, 0
  %ZF138 = icmp eq i32 %EAX139, 0
  %118 = zext i32 %R14D to i64
  store i64 %118, ptr %R14D-SKT-LOC140, align 1
  store i32 %EAX139, ptr %EAX-SKT-LOC159, align 1
  %119 = zext i32 %EAX139 to i64
  store i64 %119, ptr %EAX-SKT-LOC, align 1
  %120 = zext i32 %EAX139 to i64
  store i64 %120, ptr %EAX-SKT-LOC134, align 1
  %121 = zext i32 %CMOV129 to i64
  store i64 %121, ptr %EBP-SKT-LOC, align 1
  %122 = zext i32 %CMOV129 to i64
  store i64 %122, ptr %EBP-SKT-LOC103, align 1
  %123 = zext i32 %memload102 to i64
  store i64 %123, ptr %R13D-SKT-LOC, align 1
  %124 = zext i32 %memload102 to i64
  store i64 %124, ptr %R13D-SKT-LOC109, align 1
  br label %bb.3

bb.3:                                             ; preds = %bb.10, %bb.9
  %125 = load i64, ptr %R14D-SKT-LOC140, align 1
  %R14D141 = trunc i64 %125 to i32
  %R14D146 = add i32 %R14D141, 1
  %126 = and i32 %R14D146, 255
  %127 = call i32 @llvm.ctpop.i32(i32 %126)
  %128 = and i32 %127, 1
  %PF142 = icmp eq i32 %128, 0
  %ZF143 = icmp eq i32 %R14D146, 0
  %highbit144 = and i32 -2147483648, %R14D146
  %SF145 = icmp ne i32 %highbit144, 0
  %129 = load i64, ptr %R10D-SKT-LOC147, align 1
  %R10D148 = trunc i64 %129 to i32
  %R10D152 = add nsw i32 %R10D148, %arg1
  %highbit149 = and i32 -2147483648, %R10D152
  %SF150 = icmp ne i32 %highbit149, 0
  %ZF151 = icmp eq i32 %R10D152, 0
  %130 = sub i32 %R14D146, %arg1
  %131 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %R14D146, i32 %arg1)
  %CF153 = extractvalue { i32, i1 } %131, 1
  %ZF154 = icmp eq i32 %130, 0
  %highbit155 = and i32 -2147483648, %130
  %SF156 = icmp ne i32 %highbit155, 0
  %132 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %R14D146, i32 %arg1)
  %OF157 = extractvalue { i32, i1 } %132, 1
  %133 = and i32 %130, 255
  %134 = call i32 @llvm.ctpop.i32(i32 %133)
  %135 = and i32 %134, 1
  %PF158 = icmp eq i32 %135, 0
  %CmpZF_JE163 = icmp eq i1 %ZF154, true
  %136 = zext i32 %R10D152 to i64
  store i64 %136, ptr %R10D-SKT-LOC, align 1
  %137 = zext i32 %R10D152 to i64
  store i64 %137, ptr %R10D-SKT-LOC147, align 1
  %138 = zext i32 %R14D146 to i64
  store i64 %138, ptr %R14D-SKT-LOC, align 1
  %139 = zext i32 %R14D146 to i64
  store i64 %139, ptr %R14D-SKT-LOC140, align 1
  br i1 %CmpZF_JE163, label %bb.12, label %bb.4

bb.11:                                            ; preds = %entry
  store i32 0, ptr %EAX-SKT-LOC159, align 1
  br label %bb.12

bb.12:                                            ; preds = %bb.11, %bb.3
  %EAX160 = load i32, ptr %EAX-SKT-LOC159, align 1
  ret i32 %EAX160
}

define dso_local void @call_mul_vect(i32 %arg1, i64 %arg2, i64 %arg3, i64 %arg4) {
entry:
  %R11D-SKT-LOC136 = alloca i64, align 8
  %EBP-SKT-LOC129 = alloca i32, align 4
  %R14-SKT-LOC = alloca i64, align 8
  %EBP-SKT-LOC109 = alloca i64, align 8
  %RAX-SKT-LOC = alloca i64, align 8
  %R11D-SKT-LOC94 = alloca i64, align 8
  %R13-SKT-LOC90 = alloca i64, align 8
  %EBP-SKT-LOC = alloca i64, align 8
  %R13-SKT-LOC = alloca i64, align 8
  %EAX-SKT-LOC = alloca i64, align 8
  %R11D-SKT-LOC = alloca i64, align 8
  %stktop_8 = alloca i8, i32 16, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  %0 = add i64 %tos, 0
  %RSP_P.0 = inttoptr i64 %0 to ptr
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 3735928559, ptr %RSP_P.0, align 8
  store i64 %arg2, ptr %stktop_8, align 1
  %1 = and i32 %arg1, %arg1
  %highbit = and i32 -2147483648, %1
  %SF = icmp ne i32 %highbit, 0
  %ZF = icmp eq i32 %1, 0
  %2 = and i32 %1, 255
  %3 = call i32 @llvm.ctpop.i32(i32 %2)
  %4 = and i32 %3, 1
  %PF = icmp eq i32 %4, 0
  %CmpZF_JE = icmp eq i1 %ZF, true
  br i1 %CmpZF_JE, label %bb.13, label %bb.1

bb.1:                                             ; preds = %entry
  %memref-disp = add i32 %arg1, -1
  %RSI = zext i32 %memref-disp to i64
  %R15D = and i32 %arg1, 3
  %5 = and i32 %R15D, 255
  %6 = call i32 @llvm.ctpop.i32(i32 %5)
  %7 = and i32 %6, 1
  %PF1 = icmp eq i32 %7, 0
  %ZF2 = icmp eq i32 %R15D, 0
  %highbit3 = and i32 -2147483648, %R15D
  %SF4 = icmp ne i32 %highbit3, 0
  %R10D = and i32 %arg1, -4
  %8 = and i32 %R10D, 255
  %9 = call i32 @llvm.ctpop.i32(i32 %8)
  %10 = and i32 %9, 1
  %PF5 = icmp eq i32 %10, 0
  %ZF6 = icmp eq i32 %R10D, 0
  %highbit7 = and i32 -2147483648, %R10D
  %SF8 = icmp ne i32 %highbit7, 0
  %11 = zext i32 0 to i64
  store i64 %11, ptr %R11D-SKT-LOC, align 1
  %12 = zext i32 0 to i64
  store i64 %12, ptr %R11D-SKT-LOC94, align 1
  %13 = zext i32 0 to i64
  store i64 %13, ptr %R14-SKT-LOC, align 1
  %14 = zext i32 0 to i64
  store i64 %14, ptr %R11D-SKT-LOC136, align 1
  br label %bb.4

bb.4:                                             ; preds = %bb.3, %bb.1
  %15 = sub i64 %RSI, 3
  %16 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %RSI, i64 3)
  %CF = extractvalue { i64, i1 } %16, 1
  %ZF9 = icmp eq i64 %15, 0
  %highbit10 = and i64 -9223372036854775808, %15
  %SF11 = icmp ne i64 %highbit10, 0
  %17 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %RSI, i64 3)
  %OF = extractvalue { i64, i1 } %17, 1
  %18 = and i64 %15, 255
  %19 = call i64 @llvm.ctpop.i64(i64 %18)
  %20 = and i64 %19, 1
  %PF12 = icmp eq i64 %20, 0
  %21 = zext i32 0 to i64
  store i64 %21, ptr %R13-SKT-LOC, align 1
  %22 = zext i32 0 to i64
  store i64 %22, ptr %R13-SKT-LOC90, align 1
  %CFCmp_JAE = icmp eq i1 %CF, false
  br i1 %CFCmp_JAE, label %bb.7, label %bb.5

bb.5:                                             ; preds = %bb.4
  %23 = zext i32 0 to i64
  store i64 %23, ptr %EBP-SKT-LOC109, align 1
  store i32 0, ptr %EBP-SKT-LOC129, align 1
  br label %bb.9

bb.7:                                             ; preds = %bb.4
  %24 = load i64, ptr %R11D-SKT-LOC, align 1
  %R11D = trunc i64 %24 to i32
  %25 = zext i32 %R11D to i64
  store i64 %25, ptr %EAX-SKT-LOC, align 1
  %26 = zext i32 0 to i64
  store i64 %26, ptr %EBP-SKT-LOC, align 1
  %27 = zext i32 %R11D to i64
  store i64 %27, ptr %R11D-SKT-LOC94, align 1
  %28 = zext i32 %R11D to i64
  store i64 %28, ptr %R11D-SKT-LOC136, align 1
  br label %bb.8

bb.8:                                             ; preds = %bb.7, %bb.8
  %29 = load i64, ptr %EAX-SKT-LOC, align 1
  %EAX = trunc i64 %29 to i32
  %30 = zext i32 %EAX to i64
  %memref-idxreg = mul i64 2, %30
  %memref-basereg = add i64 %arg3, %memref-idxreg
  %31 = inttoptr i64 %memref-basereg to ptr
  %memload = load i32, ptr %31, align 1
  %32 = trunc i32 %memload to i16
  %R12D = sext i16 %32 to i32
  %R13 = load i64, ptr %R13-SKT-LOC, align 1
  %memref-idxreg13 = mul i64 2, %R13
  %memref-basereg14 = add i64 %arg4, %memref-idxreg13
  %33 = inttoptr i64 %memref-basereg14 to ptr
  %memload15 = load i32, ptr %33, align 1
  %34 = trunc i32 %memload15 to i16
  %EBX = sext i16 %34 to i32
  %EBX16 = mul nsw i32 %EBX, %R12D
  %35 = load i64, ptr %EBP-SKT-LOC, align 1
  %EBP = trunc i64 %35 to i32
  %EBX20 = add nsw i32 %EBX16, %EBP
  %highbit17 = and i32 -2147483648, %EBX20
  %SF18 = icmp ne i32 %highbit17, 0
  %ZF19 = icmp eq i32 %EBX20, 0
  %memref-disp21 = add i32 %EAX, 1
  %36 = zext i32 %memref-disp21 to i64
  %memref-idxreg22 = mul i64 2, %36
  %memref-basereg23 = add i64 %arg3, %memref-idxreg22
  %37 = inttoptr i64 %memref-basereg23 to ptr
  %memload24 = load i32, ptr %37, align 1
  %38 = trunc i32 %memload24 to i16
  %R12D25 = sext i16 %38 to i32
  %memref-idxreg26 = mul i64 2, %R13
  %memref-basereg27 = add i64 %arg4, %memref-idxreg26
  %memref-disp28 = add i64 %memref-basereg27, 2
  %39 = inttoptr i64 %memref-disp28 to ptr
  %memload29 = load i32, ptr %39, align 1
  %40 = trunc i32 %memload29 to i16
  %EBP30 = sext i16 %40 to i32
  %EBP31 = mul nsw i32 %EBP30, %R12D25
  %EBP35 = add nsw i32 %EBP31, %EBX20
  %highbit32 = and i32 -2147483648, %EBP35
  %SF33 = icmp ne i32 %highbit32, 0
  %ZF34 = icmp eq i32 %EBP35, 0
  %memref-disp36 = add i32 %EAX, 2
  %41 = zext i32 %memref-disp36 to i64
  %memref-idxreg37 = mul i64 2, %41
  %memref-basereg38 = add i64 %arg3, %memref-idxreg37
  %42 = inttoptr i64 %memref-basereg38 to ptr
  %memload39 = load i32, ptr %42, align 1
  %43 = trunc i32 %memload39 to i16
  %R12D40 = sext i16 %43 to i32
  %memref-idxreg41 = mul i64 2, %R13
  %memref-basereg42 = add i64 %arg4, %memref-idxreg41
  %memref-disp43 = add i64 %memref-basereg42, 4
  %44 = inttoptr i64 %memref-disp43 to ptr
  %memload44 = load i32, ptr %44, align 1
  %45 = trunc i32 %memload44 to i16
  %EBX45 = sext i16 %45 to i32
  %EBX46 = mul nsw i32 %EBX45, %R12D40
  %EBX50 = add nsw i32 %EBX46, %EBP35
  %highbit47 = and i32 -2147483648, %EBX50
  %SF48 = icmp ne i32 %highbit47, 0
  %ZF49 = icmp eq i32 %EBX50, 0
  %memref-disp51 = add i32 %EAX, 3
  %46 = zext i32 %memref-disp51 to i64
  %memref-idxreg52 = mul i64 2, %46
  %memref-basereg53 = add i64 %arg3, %memref-idxreg52
  %47 = inttoptr i64 %memref-basereg53 to ptr
  %memload54 = load i32, ptr %47, align 1
  %48 = trunc i32 %memload54 to i16
  %R12D55 = sext i16 %48 to i32
  %memref-idxreg56 = mul i64 2, %R13
  %memref-basereg57 = add i64 %arg4, %memref-idxreg56
  %memref-disp58 = add i64 %memref-basereg57, 6
  %49 = inttoptr i64 %memref-disp58 to ptr
  %memload59 = load i32, ptr %49, align 1
  %50 = trunc i32 %memload59 to i16
  %EBP60 = sext i16 %50 to i32
  %EBP61 = mul nsw i32 %EBP60, %R12D55
  %EBP65 = add nsw i32 %EBP61, %EBX50
  %highbit62 = and i32 -2147483648, %EBP65
  %SF63 = icmp ne i32 %highbit62, 0
  %ZF64 = icmp eq i32 %EBP65, 0
  %R1372 = add i64 %R13, 4
  %51 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %R13, i64 4)
  %CF66 = extractvalue { i64, i1 } %51, 1
  %52 = and i64 %R1372, 255
  %53 = call i64 @llvm.ctpop.i64(i64 %52)
  %54 = and i64 %53, 1
  %PF67 = icmp eq i64 %54, 0
  %ZF68 = icmp eq i64 %R1372, 0
  %highbit69 = and i64 -9223372036854775808, %R1372
  %SF70 = icmp ne i64 %highbit69, 0
  %55 = call { i64, i1 } @llvm.sadd.with.overflow.i64(i64 %R13, i64 4)
  %OF71 = extractvalue { i64, i1 } %55, 1
  %EAX79 = add i32 %EAX, 4
  %56 = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 %EAX, i32 4)
  %CF73 = extractvalue { i32, i1 } %56, 1
  %57 = and i32 %EAX79, 255
  %58 = call i32 @llvm.ctpop.i32(i32 %57)
  %59 = and i32 %58, 1
  %PF74 = icmp eq i32 %59, 0
  %ZF75 = icmp eq i32 %EAX79, 0
  %highbit76 = and i32 -2147483648, %EAX79
  %SF77 = icmp ne i32 %highbit76, 0
  %60 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %EAX, i32 4)
  %OF78 = extractvalue { i32, i1 } %60, 1
  %61 = zext i32 %R10D to i64
  %62 = sub i64 %61, %R1372
  %63 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %61, i64 %R1372)
  %CF80 = extractvalue { i64, i1 } %63, 1
  %ZF81 = icmp eq i64 %62, 0
  %highbit82 = and i64 -9223372036854775808, %62
  %SF83 = icmp ne i64 %highbit82, 0
  %64 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %61, i64 %R1372)
  %OF84 = extractvalue { i64, i1 } %64, 1
  %65 = and i64 %62, 255
  %66 = call i64 @llvm.ctpop.i64(i64 %65)
  %67 = and i64 %66, 1
  %PF85 = icmp eq i64 %67, 0
  store i64 %R1372, ptr %R13-SKT-LOC90, align 1
  %68 = zext i32 %EBP65 to i64
  store i64 %68, ptr %EBP-SKT-LOC109, align 1
  store i32 %EBP65, ptr %EBP-SKT-LOC129, align 1
  %CmpZF_JNE = icmp eq i1 %ZF81, false
  %69 = zext i32 %EAX79 to i64
  store i64 %69, ptr %EAX-SKT-LOC, align 1
  %70 = zext i32 %EBP65 to i64
  store i64 %70, ptr %EBP-SKT-LOC, align 1
  store i64 %R1372, ptr %R13-SKT-LOC, align 1
  br i1 %CmpZF_JNE, label %bb.8, label %bb.9

bb.9:                                             ; preds = %bb.8, %bb.5
  %71 = zext i32 %R15D to i64
  %72 = zext i32 %R15D to i64
  %73 = and i64 %71, %72
  %highbit86 = and i64 -9223372036854775808, %73
  %SF87 = icmp ne i64 %highbit86, 0
  %ZF88 = icmp eq i64 %73, 0
  %74 = and i64 %73, 255
  %75 = call i64 @llvm.ctpop.i64(i64 %74)
  %76 = and i64 %75, 1
  %PF89 = icmp eq i64 %76, 0
  %CmpZF_JE148 = icmp eq i1 %ZF88, true
  br i1 %CmpZF_JE148, label %bb.3, label %bb.10

bb.10:                                            ; preds = %bb.9
  %R1391 = load i64, ptr %R13-SKT-LOC90, align 1
  %memref-idxreg92 = mul i64 2, %R1391
  %memref-basereg93 = add i64 %arg4, %memref-idxreg92
  %77 = trunc i64 %R1391 to i32
  %78 = load i64, ptr %R11D-SKT-LOC94, align 1
  %R11D95 = trunc i64 %78 to i32
  %R13D = add nsw i32 %77, %R11D95
  %highbit96 = and i32 -2147483648, %R13D
  %SF97 = icmp ne i32 %highbit96, 0
  %ZF98 = icmp eq i32 %R13D, 0
  %79 = zext i32 0 to i64
  store i64 %79, ptr %RAX-SKT-LOC, align 1
  %80 = zext i32 %R11D95 to i64
  store i64 %80, ptr %R11D-SKT-LOC136, align 1
  br label %bb.11

bb.11:                                            ; preds = %bb.10, %bb.11
  %81 = zext i32 %R13D to i64
  %RAX = load i64, ptr %RAX-SKT-LOC, align 1
  %memref-basereg99 = add i64 %RAX, %81
  %EBX100 = trunc i64 %memref-basereg99 to i32
  %82 = zext i32 %EBX100 to i64
  %memref-idxreg101 = mul i64 2, %82
  %memref-basereg102 = add i64 %arg3, %memref-idxreg101
  %83 = inttoptr i64 %memref-basereg102 to ptr
  %memload103 = load i32, ptr %83, align 1
  %84 = trunc i32 %memload103 to i16
  %EBX104 = sext i16 %84 to i32
  %memref-idxreg105 = mul i64 2, %RAX
  %memref-basereg106 = add i64 %memref-basereg93, %memref-idxreg105
  %85 = inttoptr i64 %memref-basereg106 to ptr
  %memload107 = load i32, ptr %85, align 1
  %86 = trunc i32 %memload107 to i16
  %R8D = sext i16 %86 to i32
  %R8D108 = mul nsw i32 %R8D, %EBX104
  %87 = load i64, ptr %EBP-SKT-LOC109, align 1
  %EBP110 = trunc i64 %87 to i32
  %EBP114 = add nsw i32 %EBP110, %R8D108
  %highbit111 = and i32 -2147483648, %EBP114
  %SF112 = icmp ne i32 %highbit111, 0
  %ZF113 = icmp eq i32 %EBP114, 0
  %RAX119 = add i64 %RAX, 1
  %88 = and i64 %RAX119, 255
  %89 = call i64 @llvm.ctpop.i64(i64 %88)
  %90 = and i64 %89, 1
  %PF115 = icmp eq i64 %90, 0
  %ZF116 = icmp eq i64 %RAX119, 0
  %highbit117 = and i64 -9223372036854775808, %RAX119
  %SF118 = icmp ne i64 %highbit117, 0
  %91 = zext i32 %R15D to i64
  %92 = sub i64 %91, %RAX119
  %93 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %91, i64 %RAX119)
  %CF120 = extractvalue { i64, i1 } %93, 1
  %ZF121 = icmp eq i64 %92, 0
  %highbit122 = and i64 -9223372036854775808, %92
  %SF123 = icmp ne i64 %highbit122, 0
  %94 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %91, i64 %RAX119)
  %OF124 = extractvalue { i64, i1 } %94, 1
  %95 = and i64 %92, 255
  %96 = call i64 @llvm.ctpop.i64(i64 %95)
  %97 = and i64 %96, 1
  %PF125 = icmp eq i64 %97, 0
  store i32 %EBP114, ptr %EBP-SKT-LOC129, align 1
  %CmpZF_JNE149 = icmp eq i1 %ZF121, false
  %98 = zext i32 %EBP114 to i64
  store i64 %98, ptr %EBP-SKT-LOC109, align 1
  store i64 %RAX119, ptr %RAX-SKT-LOC, align 1
  br i1 %CmpZF_JNE149, label %bb.11, label %bb.12

bb.12:                                            ; preds = %bb.11
  br label %bb.3

bb.3:                                             ; preds = %bb.12, %bb.9
  %memload126 = load i64, ptr %stktop_8, align 1
  %R14 = load i64, ptr %R14-SKT-LOC, align 1
  %memref-idxreg127 = mul i64 4, %R14
  %memref-basereg128 = add i64 %memload126, %memref-idxreg127
  %EBP130 = load i32, ptr %EBP-SKT-LOC129, align 1
  %99 = inttoptr i64 %memref-basereg128 to ptr
  store i32 %EBP130, ptr %99, align 1
  %R14135 = add i64 %R14, 1
  %100 = and i64 %R14135, 255
  %101 = call i64 @llvm.ctpop.i64(i64 %100)
  %102 = and i64 %101, 1
  %PF131 = icmp eq i64 %102, 0
  %ZF132 = icmp eq i64 %R14135, 0
  %highbit133 = and i64 -9223372036854775808, %R14135
  %SF134 = icmp ne i64 %highbit133, 0
  %103 = load i64, ptr %R11D-SKT-LOC136, align 1
  %R11D137 = trunc i64 %103 to i32
  %R11D141 = add nsw i32 %R11D137, %arg1
  %highbit138 = and i32 -2147483648, %R11D141
  %SF139 = icmp ne i32 %highbit138, 0
  %ZF140 = icmp eq i32 %R11D141, 0
  %104 = zext i32 %arg1 to i64
  %105 = sub i64 %R14135, %104
  %106 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %R14135, i64 %104)
  %CF142 = extractvalue { i64, i1 } %106, 1
  %ZF143 = icmp eq i64 %105, 0
  %highbit144 = and i64 -9223372036854775808, %105
  %SF145 = icmp ne i64 %highbit144, 0
  %107 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %R14135, i64 %104)
  %OF146 = extractvalue { i64, i1 } %107, 1
  %108 = and i64 %105, 255
  %109 = call i64 @llvm.ctpop.i64(i64 %108)
  %110 = and i64 %109, 1
  %PF147 = icmp eq i64 %110, 0
  %CmpZF_JE150 = icmp eq i1 %ZF143, true
  store i64 %R14135, ptr %R14-SKT-LOC, align 1
  %111 = zext i32 %R11D141 to i64
  store i64 %111, ptr %R11D-SKT-LOC94, align 1
  %112 = zext i32 %R11D141 to i64
  store i64 %112, ptr %R11D-SKT-LOC, align 1
  %113 = zext i32 %R11D141 to i64
  store i64 %113, ptr %R11D-SKT-LOC136, align 1
  br i1 %CmpZF_JE150, label %bb.13, label %bb.4

bb.13:                                            ; preds = %bb.3, %entry
  ret void
}

define dso_local void @call_add_const(i32 %arg1, i64 %arg2, i16 %arg3) {
entry:
  %R11D-SKT-LOC77 = alloca i64, align 8
  %R10D-SKT-LOC = alloca i64, align 8
  %RBX-SKT-LOC = alloca i64, align 8
  %ECX-SKT-LOC56 = alloca i64, align 8
  %R11D-SKT-LOC50 = alloca i64, align 8
  %ECX-SKT-LOC = alloca i64, align 8
  %RCX-SKT-LOC = alloca i64, align 8
  %EBX-SKT-LOC = alloca i64, align 8
  %R11D-SKT-LOC = alloca i64, align 8
  %stktop_8 = alloca i8, i32 8, align 1
  %tos = ptrtoint ptr %stktop_8 to i64
  store i64 3735928559, ptr %stktop_8, align 8
  store i64 3735928559, ptr %stktop_8, align 8
  %0 = and i32 %arg1, %arg1
  %highbit = and i32 -2147483648, %0
  %SF = icmp ne i32 %highbit, 0
  %ZF = icmp eq i32 %0, 0
  %1 = and i32 %0, 255
  %2 = call i32 @llvm.ctpop.i32(i32 %1)
  %3 = and i32 %2, 1
  %PF = icmp eq i32 %3, 0
  %CmpZF_JE = icmp eq i1 %ZF, true
  br i1 %CmpZF_JE, label %bb.13, label %bb.1

bb.1:                                             ; preds = %entry
  %memref-disp = add i32 %arg1, -1
  %R8 = zext i32 %memref-disp to i64
  %R9D = and i32 %arg1, 3
  %4 = and i32 %R9D, 255
  %5 = call i32 @llvm.ctpop.i32(i32 %4)
  %6 = and i32 %5, 1
  %PF1 = icmp eq i32 %6, 0
  %ZF2 = icmp eq i32 %R9D, 0
  %highbit3 = and i32 -2147483648, %R9D
  %SF4 = icmp ne i32 %highbit3, 0
  %R14D = and i32 %arg1, -4
  %7 = and i32 %R14D, 255
  %8 = call i32 @llvm.ctpop.i32(i32 %7)
  %9 = and i32 %8, 1
  %PF5 = icmp eq i32 %9, 0
  %ZF6 = icmp eq i32 %R14D, 0
  %highbit7 = and i32 -2147483648, %R14D
  %SF8 = icmp ne i32 %highbit7, 0
  %10 = zext i32 0 to i64
  store i64 %10, ptr %R11D-SKT-LOC, align 1
  %11 = zext i32 0 to i64
  store i64 %11, ptr %R11D-SKT-LOC50, align 1
  %12 = zext i32 0 to i64
  store i64 %12, ptr %R10D-SKT-LOC, align 1
  %13 = zext i32 0 to i64
  store i64 %13, ptr %R11D-SKT-LOC77, align 1
  br label %bb.4

bb.4:                                             ; preds = %bb.3, %bb.1
  %14 = sub i64 %R8, 3
  %15 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %R8, i64 3)
  %CF = extractvalue { i64, i1 } %15, 1
  %ZF9 = icmp eq i64 %14, 0
  %highbit10 = and i64 -9223372036854775808, %14
  %SF11 = icmp ne i64 %highbit10, 0
  %16 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %R8, i64 3)
  %OF = extractvalue { i64, i1 } %16, 1
  %17 = and i64 %14, 255
  %18 = call i64 @llvm.ctpop.i64(i64 %17)
  %19 = and i64 %18, 1
  %PF12 = icmp eq i64 %19, 0
  %CFCmp_JAE = icmp eq i1 %CF, false
  br i1 %CFCmp_JAE, label %bb.7, label %bb.5

bb.5:                                             ; preds = %bb.4
  %20 = zext i32 0 to i64
  store i64 %20, ptr %ECX-SKT-LOC, align 1
  br label %bb.9

bb.7:                                             ; preds = %bb.4
  %21 = load i64, ptr %R11D-SKT-LOC, align 1
  %R11D = trunc i64 %21 to i32
  %22 = zext i32 %R11D to i64
  store i64 %22, ptr %EBX-SKT-LOC, align 1
  %23 = zext i32 0 to i64
  store i64 %23, ptr %RCX-SKT-LOC, align 1
  %24 = zext i32 %R11D to i64
  store i64 %24, ptr %R11D-SKT-LOC50, align 1
  %25 = zext i32 %R11D to i64
  store i64 %25, ptr %R11D-SKT-LOC77, align 1
  br label %bb.8

bb.8:                                             ; preds = %bb.7, %bb.8
  %26 = load i64, ptr %EBX-SKT-LOC, align 1
  %EBX = trunc i64 %26 to i32
  %27 = zext i32 %EBX to i64
  %memref-idxreg = mul i64 2, %27
  %memref-basereg = add i64 %arg2, %memref-idxreg
  %28 = inttoptr i64 %memref-basereg to ptr
  %29 = load i16, ptr %28, align 1
  %30 = add i16 %29, %arg3
  %31 = and i16 %30, 255
  %32 = call i16 @llvm.ctpop.i16(i16 %31)
  %33 = and i16 %32, 1
  %PF13 = icmp eq i16 %33, 0
  store i16 %30, ptr %28, align 1
  %memref-disp14 = add i32 %EBX, 1
  %34 = zext i32 %memref-disp14 to i64
  %memref-idxreg15 = mul i64 2, %34
  %memref-basereg16 = add i64 %arg2, %memref-idxreg15
  %35 = inttoptr i64 %memref-basereg16 to ptr
  %36 = load i16, ptr %35, align 1
  %37 = add i16 %36, %arg3
  %38 = and i16 %37, 255
  %39 = call i16 @llvm.ctpop.i16(i16 %38)
  %40 = and i16 %39, 1
  %PF17 = icmp eq i16 %40, 0
  store i16 %37, ptr %35, align 1
  %memref-disp18 = add i32 %EBX, 2
  %41 = zext i32 %memref-disp18 to i64
  %memref-idxreg19 = mul i64 2, %41
  %memref-basereg20 = add i64 %arg2, %memref-idxreg19
  %42 = inttoptr i64 %memref-basereg20 to ptr
  %43 = load i16, ptr %42, align 1
  %44 = add i16 %43, %arg3
  %45 = and i16 %44, 255
  %46 = call i16 @llvm.ctpop.i16(i16 %45)
  %47 = and i16 %46, 1
  %PF21 = icmp eq i16 %47, 0
  store i16 %44, ptr %42, align 1
  %memref-disp22 = add i32 %EBX, 3
  %48 = zext i32 %memref-disp22 to i64
  %memref-idxreg23 = mul i64 2, %48
  %memref-basereg24 = add i64 %arg2, %memref-idxreg23
  %49 = inttoptr i64 %memref-basereg24 to ptr
  %50 = load i16, ptr %49, align 1
  %51 = add i16 %50, %arg3
  %52 = and i16 %51, 255
  %53 = call i16 @llvm.ctpop.i16(i16 %52)
  %54 = and i16 %53, 1
  %PF25 = icmp eq i16 %54, 0
  store i16 %51, ptr %49, align 1
  %RCX = load i64, ptr %RCX-SKT-LOC, align 1
  %RCX32 = add i64 %RCX, 4
  %55 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %RCX, i64 4)
  %CF26 = extractvalue { i64, i1 } %55, 1
  %56 = and i64 %RCX32, 255
  %57 = call i64 @llvm.ctpop.i64(i64 %56)
  %58 = and i64 %57, 1
  %PF27 = icmp eq i64 %58, 0
  %ZF28 = icmp eq i64 %RCX32, 0
  %highbit29 = and i64 -9223372036854775808, %RCX32
  %SF30 = icmp ne i64 %highbit29, 0
  %59 = call { i64, i1 } @llvm.sadd.with.overflow.i64(i64 %RCX, i64 4)
  %OF31 = extractvalue { i64, i1 } %59, 1
  %EBX39 = add i32 %EBX, 4
  %60 = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 %EBX, i32 4)
  %CF33 = extractvalue { i32, i1 } %60, 1
  %61 = and i32 %EBX39, 255
  %62 = call i32 @llvm.ctpop.i32(i32 %61)
  %63 = and i32 %62, 1
  %PF34 = icmp eq i32 %63, 0
  %ZF35 = icmp eq i32 %EBX39, 0
  %highbit36 = and i32 -2147483648, %EBX39
  %SF37 = icmp ne i32 %highbit36, 0
  %64 = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 %EBX, i32 4)
  %OF38 = extractvalue { i32, i1 } %64, 1
  %65 = zext i32 %R14D to i64
  %66 = sub i64 %65, %RCX32
  %67 = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 %65, i64 %RCX32)
  %CF40 = extractvalue { i64, i1 } %67, 1
  %ZF41 = icmp eq i64 %66, 0
  %highbit42 = and i64 -9223372036854775808, %66
  %SF43 = icmp ne i64 %highbit42, 0
  %68 = call { i64, i1 } @llvm.ssub.with.overflow.i64(i64 %65, i64 %RCX32)
  %OF44 = extractvalue { i64, i1 } %68, 1
  %69 = and i64 %66, 255
  %70 = call i64 @llvm.ctpop.i64(i64 %69)
  %71 = and i64 %70, 1
  %PF45 = icmp eq i64 %71, 0
  store i64 %RCX32, ptr %ECX-SKT-LOC, align 1
  %CmpZF_JNE = icmp eq i1 %ZF41, false
  %72 = zext i32 %EBX39 to i64
  store i64 %72, ptr %EBX-SKT-LOC, align 1
  store i64 %RCX32, ptr %RCX-SKT-LOC, align 1
  br i1 %CmpZF_JNE, label %bb.8, label %bb.9

bb.9:                                             ; preds = %bb.8, %bb.5
  %73 = zext i32 %R9D to i64
  %74 = zext i32 %R9D to i64
  %75 = and i64 %73, %74
  %highbit46 = and i64 -9223372036854775808, %75
  %SF47 = icmp ne i64 %highbit46, 0
  %ZF48 = icmp eq i64 %75, 0
  %76 = and i64 %75, 255
  %77 = call i64 @llvm.ctpop.i64(i64 %76)
  %78 = and i64 %77, 1
  %PF49 = icmp eq i64 %78, 0
  %CmpZF_JE89 = icmp eq i1 %ZF48, true
  br i1 %CmpZF_JE89, label %bb.3, label %bb.10

bb.10:                                            ; preds = %bb.9
  %79 = load i64, ptr %ECX-SKT-LOC, align 1
  %ECX = trunc i64 %79 to i32
  %80 = load i64, ptr %R11D-SKT-LOC50, align 1
  %R11D51 = trunc i64 %80 to i32
  %ECX55 = add nsw i32 %ECX, %R11D51
  %highbit52 = and i32 -2147483648, %ECX55
  %SF53 = icmp ne i32 %highbit52, 0
  %ZF54 = icmp eq i32 %ECX55, 0
  %RBX = zext i32 %R9D to i64
  %81 = zext i32 %ECX55 to i64
  store i64 %81, ptr %ECX-SKT-LOC56, align 1
  store i64 %RBX, ptr %RBX-SKT-LOC, align 1
  %82 = zext i32 %R11D51 to i64
  store i64 %82, ptr %R11D-SKT-LOC77, align 1
  br label %bb.11

bb.11:                                            ; preds = %bb.10, %bb.11
  %83 = load i64, ptr %ECX-SKT-LOC56, align 1
  %ECX57 = trunc i64 %83 to i32
  %84 = zext i32 %ECX57 to i64
  %memref-idxreg58 = mul i64 2, %84
  %memref-basereg59 = add i64 %arg2, %memref-idxreg58
  %85 = inttoptr i64 %memref-basereg59 to ptr
  %86 = load i16, ptr %85, align 1
  %87 = add i16 %86, %arg3
  %88 = and i16 %87, 255
  %89 = call i16 @llvm.ctpop.i16(i16 %88)
  %90 = and i16 %89, 1
  %PF60 = icmp eq i16 %90, 0
  store i16 %87, ptr %85, align 1
  %ECX65 = add i32 %ECX57, 1
  %91 = and i32 %ECX65, 255
  %92 = call i32 @llvm.ctpop.i32(i32 %91)
  %93 = and i32 %92, 1
  %PF61 = icmp eq i32 %93, 0
  %ZF62 = icmp eq i32 %ECX65, 0
  %highbit63 = and i32 -2147483648, %ECX65
  %SF64 = icmp ne i32 %highbit63, 0
  %RBX66 = load i64, ptr %RBX-SKT-LOC, align 1
  %RBX71 = sub i64 %RBX66, 1
  %94 = and i64 %RBX71, 255
  %95 = call i64 @llvm.ctpop.i64(i64 %94)
  %96 = and i64 %95, 1
  %PF67 = icmp eq i64 %96, 0
  %ZF68 = icmp eq i64 %RBX71, 0
  %highbit69 = and i64 -9223372036854775808, %RBX71
  %SF70 = icmp ne i64 %highbit69, 0
  %CmpZF_JNE90 = icmp eq i1 %ZF68, false
  %97 = zext i32 %ECX65 to i64
  store i64 %97, ptr %ECX-SKT-LOC56, align 1
  store i64 %RBX71, ptr %RBX-SKT-LOC, align 1
  br i1 %CmpZF_JNE90, label %bb.11, label %bb.12

bb.12:                                            ; preds = %bb.11
  br label %bb.3

bb.3:                                             ; preds = %bb.12, %bb.9
  %98 = load i64, ptr %R10D-SKT-LOC, align 1
  %R10D = trunc i64 %98 to i32
  %R10D76 = add i32 %R10D, 1
  %99 = and i32 %R10D76, 255
  %100 = call i32 @llvm.ctpop.i32(i32 %99)
  %101 = and i32 %100, 1
  %PF72 = icmp eq i32 %101, 0
  %ZF73 = icmp eq i32 %R10D76, 0
  %highbit74 = and i32 -2147483648, %R10D76
  %SF75 = icmp ne i32 %highbit74, 0
  %102 = load i64, ptr %R11D-SKT-LOC77, align 1
  %R11D78 = trunc i64 %102 to i32
  %R11D82 = add nsw i32 %R11D78, %arg1
  %highbit79 = and i32 -2147483648, %R11D82
  %SF80 = icmp ne i32 %highbit79, 0
  %ZF81 = icmp eq i32 %R11D82, 0
  %103 = sub i32 %R10D76, %arg1
  %104 = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 %R10D76, i32 %arg1)
  %CF83 = extractvalue { i32, i1 } %104, 1
  %ZF84 = icmp eq i32 %103, 0
  %highbit85 = and i32 -2147483648, %103
  %SF86 = icmp ne i32 %highbit85, 0
  %105 = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 %R10D76, i32 %arg1)
  %OF87 = extractvalue { i32, i1 } %105, 1
  %106 = and i32 %103, 255
  %107 = call i32 @llvm.ctpop.i32(i32 %106)
  %108 = and i32 %107, 1
  %PF88 = icmp eq i32 %108, 0
  %CmpZF_JE91 = icmp eq i1 %ZF84, true
  %109 = zext i32 %R10D76 to i64
  store i64 %109, ptr %R10D-SKT-LOC, align 1
  %110 = zext i32 %R11D82 to i64
  store i64 %110, ptr %R11D-SKT-LOC, align 1
  %111 = zext i32 %R11D82 to i64
  store i64 %111, ptr %R11D-SKT-LOC50, align 1
  %112 = zext i32 %R11D82 to i64
  store i64 %112, ptr %R11D-SKT-LOC77, align 1
  br i1 %CmpZF_JE91, label %bb.13, label %bb.4

bb.13:                                            ; preds = %bb.3, %entry
  ret void
}

define dso_local i32 @main() {
entry:
  %RSP_P.0 = alloca i64, align 1
  store i64 3735928559, ptr %RSP_P.0, align 8
  %EAX = call i32 @bench_call()
  %EAX1 = call i32 (ptr, ...) @printf(ptr getelementptr inbounds ([12 x i8], ptr @rodata_14, i32 0, i32 4), i32 %EAX)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.ctpop.i32(i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i8 @llvm.ctpop.i8(i8) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i8, i1 } @llvm.usub.with.overflow.i8(i8, i8) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i8, i1 } @llvm.ssub.with.overflow.i8(i8, i8) #0

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
declare { i32, i1 } @llvm.uadd.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.sadd.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.usub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i32, i1 } @llvm.ssub.with.overflow.i32(i32, i32) #0

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.ctpop.i16(i16) #0

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 4197152}
