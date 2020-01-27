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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000000888480141_3774705410_init();
    work_m_00000000004128426419_3734802550_init();
    work_m_00000000001071610448_2475284671_init();
    work_m_00000000002725146569_4113518587_init();
    work_m_00000000003703902386_2979166180_init();
    work_m_00000000002698060526_3231297128_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002698060526_3231297128");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
