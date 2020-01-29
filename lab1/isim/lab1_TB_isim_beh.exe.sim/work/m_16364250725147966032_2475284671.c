/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/Desktop/csm152a/CSm152A/lab1/lab1_middleman.v";
static int ng1[] = {11, 0};
static int ng2[] = {8, 0};
static int ng3[] = {0, 0};
static int ng4[] = {4, 0};



static void Always_42_0(char *t0)
{
    char t7[8];
    char t30[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;

LAB0:    t1 = (t0 + 3320U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 3640);
    *((int *)t2) = 1;
    t3 = (t0 + 3352);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(42, ng0);

LAB5:    xsi_set_current_line(45, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 1208U);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_minus(t7, 32, t4, 32, t6, 4);
    t5 = (t0 + 2248);
    xsi_vlogvar_assign_value(t5, t7, 0, 0, 4);
    xsi_set_current_line(46, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 2248);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    memset(t7, 0, 8);
    xsi_vlog_unsigned_minus(t7, 32, t2, 32, t5, 4);
    t6 = (t0 + 2088);
    xsi_vlogvar_assign_value(t6, t7, 0, 0, 3);
    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = ((char*)((ng3)));
    memset(t7, 0, 8);
    t6 = (t4 + 4);
    if (*((unsigned int *)t6) != 0)
        goto LAB7;

LAB6:    t8 = (t5 + 4);
    if (*((unsigned int *)t8) != 0)
        goto LAB7;

LAB10:    if (*((unsigned int *)t4) < *((unsigned int *)t5))
        goto LAB8;

LAB9:    t10 = (t7 + 4);
    t11 = *((unsigned int *)t10);
    t12 = (~(t11));
    t13 = *((unsigned int *)t7);
    t14 = (t13 & t12);
    t15 = (t14 != 0);
    if (t15 > 0)
        goto LAB11;

LAB12:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng3)));
    memset(t7, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t11 = *((unsigned int *)t3);
    t12 = *((unsigned int *)t2);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t4);
    t15 = *((unsigned int *)t5);
    t18 = (t14 ^ t15);
    t19 = (t13 | t18);
    t20 = *((unsigned int *)t4);
    t21 = *((unsigned int *)t5);
    t22 = (t20 | t21);
    t23 = (~(t22));
    t24 = (t19 & t23);
    if (t24 != 0)
        goto LAB18;

LAB15:    if (t22 != 0)
        goto LAB17;

LAB16:    *((unsigned int *)t7) = 1;

LAB18:    t8 = (t7 + 4);
    t25 = *((unsigned int *)t8);
    t26 = (~(t25));
    t27 = *((unsigned int *)t7);
    t28 = (t27 & t26);
    t29 = (t28 != 0);
    if (t29 > 0)
        goto LAB19;

LAB20:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1208U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng4)));
    memset(t7, 0, 8);
    t4 = (t3 + 4);
    if (*((unsigned int *)t4) != 0)
        goto LAB24;

LAB23:    t5 = (t2 + 4);
    if (*((unsigned int *)t5) != 0)
        goto LAB24;

LAB27:    if (*((unsigned int *)t3) < *((unsigned int *)t2))
        goto LAB25;

LAB26:    t8 = (t7 + 4);
    t11 = *((unsigned int *)t8);
    t12 = (~(t11));
    t13 = *((unsigned int *)t7);
    t14 = (t13 & t12);
    t15 = (t14 != 0);
    if (t15 > 0)
        goto LAB28;

LAB29:    xsi_set_current_line(62, ng0);

LAB32:    xsi_set_current_line(63, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = (t0 + 1208U);
    t4 = *((char **)t2);
    t2 = ((char*)((ng4)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_minus(t7, 32, t4, 4, t2, 32);
    memset(t30, 0, 8);
    xsi_vlog_unsigned_rshift(t30, 11, t3, 11, t7, 32);
    t5 = (t0 + 2408);
    xsi_vlogvar_wait_assign_value(t5, t30, 0, 0, 11, 0LL);
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t7, 0, 8);
    t5 = (t7 + 4);
    t6 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 1);
    *((unsigned int *)t7) = t12;
    t13 = *((unsigned int *)t6);
    t14 = (t13 >> 1);
    *((unsigned int *)t5) = t14;
    t15 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t15 & 31U);
    t18 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t18 & 31U);
    t8 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t8, t7, 0, 0, 4, 0LL);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 2408);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t7, 0, 8);
    t5 = (t7 + 4);
    t6 = (t4 + 4);
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 0);
    t13 = (t12 & 1);
    *((unsigned int *)t7) = t13;
    t14 = *((unsigned int *)t6);
    t15 = (t14 >> 0);
    t18 = (t15 & 1);
    *((unsigned int *)t5) = t18;
    t8 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t8, t7, 0, 0, 1, 0LL);
    xsi_set_current_line(66, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 3, 0LL);

LAB30:
LAB21:
LAB13:    goto LAB2;

LAB7:    t9 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB9;

LAB8:    *((unsigned int *)t7) = 1;
    goto LAB9;

LAB11:    xsi_set_current_line(47, ng0);

LAB14:    xsi_set_current_line(48, ng0);
    t16 = ((char*)((ng3)));
    t17 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t17, t16, 0, 0, 3, 0LL);
    xsi_set_current_line(49, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t7, 0, 8);
    t2 = (t7 + 4);
    t4 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t12 = (t11 >> 0);
    *((unsigned int *)t7) = t12;
    t13 = *((unsigned int *)t4);
    t14 = (t13 >> 0);
    *((unsigned int *)t2) = t14;
    t15 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t15 & 15U);
    t18 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t18 & 15U);
    t5 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t5, t7, 0, 0, 4, 0LL);
    xsi_set_current_line(50, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB13;

LAB17:    t6 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t6) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(52, ng0);

LAB22:    xsi_set_current_line(53, ng0);
    t9 = ((char*)((ng3)));
    t10 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t10, t9, 0, 0, 3, 0LL);
    xsi_set_current_line(54, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 4, 0LL);
    xsi_set_current_line(55, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB21;

LAB24:    t6 = (t7 + 4);
    *((unsigned int *)t7) = 1;
    *((unsigned int *)t6) = 1;
    goto LAB26;

LAB25:    *((unsigned int *)t7) = 1;
    goto LAB26;

LAB28:    xsi_set_current_line(57, ng0);

LAB31:    xsi_set_current_line(58, ng0);
    t9 = (t0 + 1048U);
    t10 = *((char **)t9);
    memset(t30, 0, 8);
    t9 = (t30 + 4);
    t16 = (t10 + 4);
    t18 = *((unsigned int *)t10);
    t19 = (t18 >> 0);
    *((unsigned int *)t30) = t19;
    t20 = *((unsigned int *)t16);
    t21 = (t20 >> 0);
    *((unsigned int *)t9) = t21;
    t22 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t22 & 15U);
    t23 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t23 & 15U);
    t17 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t17, t30, 0, 0, 4, 0LL);
    xsi_set_current_line(59, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(60, ng0);
    t2 = (t0 + 2088);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 3, 0LL);
    goto LAB30;

}


extern void work_m_16364250725147966032_2475284671_init()
{
	static char *pe[] = {(void *)Always_42_0};
	xsi_register_didat("work_m_16364250725147966032_2475284671", "isim/lab1_TB_isim_beh.exe.sim/work/m_16364250725147966032_2475284671.didat");
	xsi_register_executes(pe);
}
