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
static const char *ng0 = "/home/ise/Desktop/csm152a/CSm152A/lab1/lab1_2comp-SM_encoder.v";
static unsigned int ng1[] = {1U, 0U};
static int ng2[] = {2048, 0};
static unsigned int ng3[] = {2047U, 0U};



static void Always_27_0(char *t0)
{
    char t6[8];
    char t24[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;

LAB0:    t1 = (t0 + 2520U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 2840);
    *((int *)t2) = 1;
    t3 = (t0 + 2552);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(27, ng0);

LAB5:    xsi_set_current_line(28, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t4 = (t6 + 4);
    t7 = (t5 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 11);
    t10 = (t9 & 1);
    *((unsigned int *)t6) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 11);
    t13 = (t12 & 1);
    *((unsigned int *)t4) = t13;
    t14 = (t0 + 1448);
    xsi_vlogvar_assign_value(t14, t6, 0, 0, 1);
    xsi_set_current_line(29, ng0);
    t2 = (t0 + 1448);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (~(t8));
    t10 = *((unsigned int *)t4);
    t11 = (t10 & t9);
    t12 = (t11 != 0);
    if (t12 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t6 + 4);
    t4 = (t3 + 4);
    t8 = *((unsigned int *)t3);
    t9 = (t8 >> 0);
    *((unsigned int *)t6) = t9;
    t10 = *((unsigned int *)t4);
    t11 = (t10 >> 0);
    *((unsigned int *)t2) = t11;
    t12 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t12 & 2047U);
    t13 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t13 & 2047U);
    t5 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t5, t6, 0, 0, 11, 0LL);

LAB8:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng2)));
    memset(t6, 0, 8);
    t4 = (t3 + 4);
    t5 = (t2 + 4);
    t8 = *((unsigned int *)t3);
    t9 = *((unsigned int *)t2);
    t10 = (t8 ^ t9);
    t11 = *((unsigned int *)t4);
    t12 = *((unsigned int *)t5);
    t13 = (t11 ^ t12);
    t16 = (t10 | t13);
    t17 = *((unsigned int *)t4);
    t18 = *((unsigned int *)t5);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB14;

LAB11:    if (t19 != 0)
        goto LAB13;

LAB12:    *((unsigned int *)t6) = 1;

LAB14:    t14 = (t6 + 4);
    t22 = *((unsigned int *)t14);
    t26 = (~(t22));
    t27 = *((unsigned int *)t6);
    t28 = (t27 & t26);
    t29 = (t28 != 0);
    if (t29 > 0)
        goto LAB15;

LAB16:
LAB17:    goto LAB2;

LAB6:    xsi_set_current_line(30, ng0);
    t7 = (t0 + 1048U);
    t14 = *((char **)t7);
    memset(t6, 0, 8);
    t7 = (t6 + 4);
    t15 = (t14 + 4);
    t13 = *((unsigned int *)t14);
    t16 = (~(t13));
    *((unsigned int *)t6) = t16;
    *((unsigned int *)t7) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t21 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t21 & 4095U);
    t22 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t22 & 4095U);
    t23 = ((char*)((ng1)));
    memset(t24, 0, 8);
    xsi_vlog_unsigned_add(t24, 12, t6, 12, t23, 12);
    t25 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t25, t24, 0, 0, 11, 0LL);
    goto LAB8;

LAB10:    t17 = *((unsigned int *)t6);
    t18 = *((unsigned int *)t15);
    *((unsigned int *)t6) = (t17 | t18);
    t19 = *((unsigned int *)t7);
    t20 = *((unsigned int *)t15);
    *((unsigned int *)t7) = (t19 | t20);
    goto LAB9;

LAB13:    t7 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t7) = 1;
    goto LAB14;

LAB15:    xsi_set_current_line(35, ng0);
    t15 = ((char*)((ng3)));
    t23 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t23, t15, 0, 0, 11, 0LL);
    goto LAB17;

}


extern void work_m_06722949890281120141_3774705410_init()
{
	static char *pe[] = {(void *)Always_27_0};
	xsi_register_didat("work_m_06722949890281120141_3774705410", "isim/lab1_TB_isim_beh.exe.sim/work/m_06722949890281120141_3774705410.didat");
	xsi_register_executes(pe);
}
