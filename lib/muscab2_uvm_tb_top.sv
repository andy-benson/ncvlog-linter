// ------------------------------------------------------------------------------------
// Musca-B2 Top Level Test Bench
// ------------------------------------------------------------------------------------

`include "muscab2_hpath_defines.sv"
`include "muscab2_io_if_mod.sv"
`include "reset_ctrl_if.sv"
`include "N25Q00AA13E_VG13/include/UserData.h"

module muscab2_uvm_tb_top();

   // Definitions
   import uvm_pkg::*;
   import muscab2_uvm_tb_env_cfg_pkg::*;
   import muscab2_uvm_tb_pkg::*;



initial begin
    $display("*******************************"); 
    $display("vfast_experiment: woof"); 
    $display("*******************************"); 
end

    
     
   // ------------------------------------------------------------------------------------
   // muscab2_io_if_mod interface instance
   // ------------------------------------------------------------------------------------

   muscab2_io_if_mod io_vif();

   wire pmu_bypass_tb;
   wire flash_pwr_ok_tb;
   wire nsrst_tb;

   wire pa_at_ci1_tb;
   wire pa_at_ci0_tb;
   wire pa_an_io_tb;

   typedef virtual reset_ctrl_if reset_ctrl_vif_t;
   // SerialLogic and JTAG
   logic 	   swclktck;
   tri1 	   cxdt_swclktck;
   tri1 	   tdi;
   tri1 	   tdo;
   tri1 	   swdiotms;
   logic 	   cxdt_ntrst_in;
   tri1 	   cxdt_ntrst_out;

   // ------------------------------------------------------------------------------------
   // SC000 AHB 5 UVC instantiation
   // ------------------------------------------------------------------------------------

   localparam DATA_BITS      = 32;
   localparam HSEL_WIDTH     = 1;
   localparam HMASTER_WIDTH  = 5;
   localparam HAUSER_WIDTH   = 2;
   localparam HDUSER_WIDTH   = 2;
   localparam PROTOCOL       = 1;



   // OUTPUTS

   wire [HSEL_WIDTH-1:0] ci_pd_mem_if_hselx;
   wire [DATA_BITS-1:0]  ci_pd_mem_if_haddr;
   wire [1:0] 		 ci_pd_mem_if_htrans;
   wire 		 ci_pd_mem_if_hwrite;
   wire [2:0] 		 ci_pd_mem_if_hsize;
   wire [2:0] 		 ci_pd_mem_if_hburst;
   wire [6:0] 		 ci_pd_mem_if_hprot;
   wire [HMASTER_WIDTH-1:0] ci_pd_mem_if_hmaster;
   wire [DATA_BITS-1:0]     ci_pd_mem_if_hwdata;
   wire 		    ci_pd_mem_if_hmastlock;
   wire 		    ci_pd_mem_if_hready;
   wire 		    ci_pd_mem_if_hnonsec;

   // INPUTS
   wire 		    ci_pd_mem_if_hclk;
   wire 		    ci_pd_mem_if_hreset;
   wire [DATA_BITS-1:0]     ci_pd_mem_if_hrdata;
   wire 		    ci_pd_mem_if_hreadyout;
   wire 		    ci_pd_mem_if_hresp;
   wire 		    ci_pd_mem_if_hexokay;
   wire [1:0] 		    ci_pd_mem_if_hruser;

   typedef virtual 	    vip_ahb5_uvm_interface #(
						     .DATA_BITS     (DATA_BITS),
						     .HSEL_WIDTH    (HSEL_WIDTH),
						     .HMASTER_WIDTH (HMASTER_WIDTH),
						     .HAUSER_WIDTH  (HAUSER_WIDTH),
						     .HDUSER_WIDTH  (HDUSER_WIDTH),
						     .PROTOCOL      (PROTOCOL)
						     ) vip_ahb5_vif_t;

   vip_ahb5_pin_interface #(
			    .DATA_BITS(DATA_BITS),
			    .HSEL_WIDTH(HSEL_WIDTH),
			    .HMASTER_WIDTH(HMASTER_WIDTH),
			    .HAUSER_WIDTH(HAUSER_WIDTH),
			    .HDUSER_WIDTH(HDUSER_WIDTH),
			    .PROTOCOL(PROTOCOL)
			    ) ci_pd_mem_if 
     (
      .HCLK         (ci_pd_mem_if_hclk),
      .HRESET_N     (ci_pd_mem_if_hreset),
      .HSELX        (ci_pd_mem_if_hselx),
      .HADDR        (ci_pd_mem_if_haddr),
      .HTRANS       (ci_pd_mem_if_htrans),
      .HWRITE       (ci_pd_mem_if_hwrite),
      .HSIZE        (ci_pd_mem_if_hsize),
      .HBURST       (ci_pd_mem_if_hburst),
      .HPROT        (ci_pd_mem_if_hprot),
      .HMASTER      (ci_pd_mem_if_hmaster),
      .HWDATA       (ci_pd_mem_if_hwdata),
      .HMASTLOCK    (ci_pd_mem_if_hmastlock),
      .HREADY       (ci_pd_mem_if_hready),
      .HNONSEC      (ci_pd_mem_if_hnonsec),

      .HRDATA       (ci_pd_mem_if_hrdata),
      .HREADYOUT    (ci_pd_mem_if_hreadyout),
      .HRESP        (ci_pd_mem_if_hresp),
      .HEXOKAY      (ci_pd_mem_if_hexokay),
      .HRUSER       (ci_pd_mem_if_hruser)

      );



   always_comb
     begin
	if($test$plusargs ("SC000_AHB_UVC_CI_0"))
	  begin
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HSEL        = ci_pd_mem_if_hselx;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HADDR       = ci_pd_mem_if_haddr;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HTRANS      = ci_pd_mem_if_htrans;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HWRITE      = ci_pd_mem_if_hwrite;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HSIZE       = ci_pd_mem_if_hsize;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HBURST      = ci_pd_mem_if_hburst;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HPROT       = ci_pd_mem_if_hprot;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HMASTER     = ci_pd_mem_if_hmaster;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HWDATA      = ci_pd_mem_if_hwdata;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HMASTLOCK   = ci_pd_mem_if_hmastlock;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HREADY      = `MUSCAB2_CI_0.u_ci_top.HOSTMS_HREADYOUT;
	     force `MUSCAB2_CI_0.u_ci_top.HOSTMS_HNONSEC     = ci_pd_mem_if_hnonsec;

	     force ci_pd_mem_if_hclk                         = `MUSCAB2_CI_PD_0.u_soc_ci_pd_ci.u_sie200_ahb5_busmatrix_ci.hclk;
	     force ci_pd_mem_if_hreset                       = `MUSCAB2_CI_PD_0.u_soc_ci_pd_ci.u_sie200_ahb5_busmatrix_ci.hresetn;
	     force ci_pd_mem_if_hready                       = `MUSCAB2_CI_0.u_ci_top.HOSTMS_HREADYOUT;
	     force ci_pd_mem_if_hrdata                       = `MUSCAB2_CI_0.u_ci_top.HOSTMS_HRDATA;
	     force ci_pd_mem_if_hreadyout                    = `MUSCAB2_CI_0.u_ci_top.HOSTMS_HREADY;
	     force ci_pd_mem_if_hresp                        = `MUSCAB2_CI_0.u_ci_top.HOSTMS_HRESP;
	     force ci_pd_mem_if_hexokay                      = 1'b0;
	     force ci_pd_mem_if_hruser                       = 1'b0;

	  end else if ($test$plusargs ("SC000_AHB_UVC_CI_1"))
	    begin

	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HSEL      = ci_pd_mem_if_hselx;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HADDR     = ci_pd_mem_if_haddr;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HTRANS    = ci_pd_mem_if_htrans;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HWRITE    = ci_pd_mem_if_hwrite;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HSIZE     = ci_pd_mem_if_hsize;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HBURST    = ci_pd_mem_if_hburst;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HPROT     = ci_pd_mem_if_hprot;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HMASTER   = ci_pd_mem_if_hmaster;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HWDATA    = ci_pd_mem_if_hwdata;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HMASTLOCK = ci_pd_mem_if_hmastlock;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HREADY    = `MUSCAB2_CI_1.u_ci_top.HOSTMS_HREADYOUT;
	       force `MUSCAB2_CI_1.u_ci_top.HOSTMS_HNONSEC   = ci_pd_mem_if_hnonsec;

	       force ci_pd_mem_if_hclk                       = `MUSCAB2_CI_PD_1.u_soc_ci_pd_ci.u_sie200_ahb5_busmatrix_ci.hclk;
	       force ci_pd_mem_if_hreset                     = `MUSCAB2_CI_PD_1.u_soc_ci_pd_ci.u_sie200_ahb5_busmatrix_ci.hresetn;
	       force ci_pd_mem_if_hready                     = `MUSCAB2_CI_1.u_ci_top.HOSTMS_HREADYOUT;
	       force ci_pd_mem_if_hrdata                     = `MUSCAB2_CI_1.u_ci_top.HOSTMS_HRDATA;
	       force ci_pd_mem_if_hreadyout                  = `MUSCAB2_CI_1.u_ci_top.HOSTMS_HREADY;
	       force ci_pd_mem_if_hresp                      = `MUSCAB2_CI_1.u_ci_top.HOSTMS_HRESP;
	       force ci_pd_mem_if_hexokay                    = 1'b0;
	       force ci_pd_mem_if_hruser                     = 1'b0;

	    end else if ($test$plusargs ("SC000_AHB_UVC_CI_2"))
	      begin

		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HSEL            = ci_pd_mem_if_hselx;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HADDR           = ci_pd_mem_if_haddr;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HTRANS          = ci_pd_mem_if_htrans;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HWRITE          = ci_pd_mem_if_hwrite;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HSIZE           = ci_pd_mem_if_hsize;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HBURST          = ci_pd_mem_if_hburst;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HPROT           = ci_pd_mem_if_hprot;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HMASTER         = ci_pd_mem_if_hmaster;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HWDATA          = ci_pd_mem_if_hwdata;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HMASTLOCK       = ci_pd_mem_if_hmastlock;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HREADY          = `MUSCAB2_CI_2.u_ci_top.HOSTMS_HREADYOUT;
		 force `MUSCAB2_CI_2.u_ci_top.HOSTMS_HNONSEC         = ci_pd_mem_if_hnonsec;
		 force ci_pd_mem_if_hclk                             = `MUSCAB2_CI_PD_2.u_soc_ci_pd_ci.u_sie200_ahb5_busmatrix_ci.hclk;
		 force ci_pd_mem_if_hreset                           = `MUSCAB2_CI_PD_2.u_soc_ci_pd_ci.u_sie200_ahb5_busmatrix_ci.hresetn;
		 force ci_pd_mem_if_hready                           = `MUSCAB2_CI_2.u_ci_top.HOSTMS_HREADYOUT;
		 force ci_pd_mem_if_hrdata                           = `MUSCAB2_CI_2.u_ci_top.HOSTMS_HRDATA;
		 force ci_pd_mem_if_hreadyout                        = `MUSCAB2_CI_2.u_ci_top.HOSTMS_HREADY;
		 force ci_pd_mem_if_hresp                            = `MUSCAB2_CI_2.u_ci_top.HOSTMS_HRESP;
		 force ci_pd_mem_if_hexokay                          = 1'b0;
		 force ci_pd_mem_if_hruser                           = 1'b0;
	      end
     end

   // ------------------------------------------------------------------------------------
   // Protocol_checkers
   // ------------------------------------------------------------------------------------

`ifdef MUSCAB2_TB_PC

   ahb_protocol_checkers u_ahb_protocol_checkers();
   apb_protocol_checkers u_apb_protocol_checkers();
   qch_protocol_checkers u_qch_protocol_checkers();

   interconnect_param_check u_interconnect_param_check();
`endif


   // ------------------------------------------------------------------------------------
   // DUT instantiation
   // ------------------------------------------------------------------------------------
   soc_top u_muscab2 (
		      .PA_X32K                                (x32k_i),
		      .PA_nPORESET                            (io_vif.nporeset),

		      .PA_UART1_RX                            (io_vif.dio_pa[16]),
		      .PA_UART1_TX                            (io_vif.dio_pa[17]),
		      .PA_I2C1_SDA                            (io_vif.dio_pa[18]),
		      .PA_I2C1_SCL                            (io_vif.dio_pa[19]),
		      .PA_QSPI_N_SS                           (io_vif.dio_pa[20]),
		      .PA_QSPI_MIO0                           (io_vif.dio_pa[21]),
		      .PA_QSPI_MIO1                           (io_vif.dio_pa[22]),
		      .PA_QSPI_MIO2                           (io_vif.dio_pa[23]),
		      .PA_QSPI_MIO3                           (io_vif.dio_pa[24]),
		      .PA_QSPI_SCLK                           (io_vif.dio_pa[25]),
		      .PA_TESTCLK                             (io_vif.dio_pa[29]),
		      .PA_I3C1_SDA                            (io_vif.i3c1_sda_pad),
		      .PA_I3C1_SCL                            (io_vif.i3c1_scl_pad),
		      .PA_I3C1_SDA_PUR_OEN                    (io_vif.i3c1_sda_pur_oen_pad), //now active high , but keeps active low naming.
		      .PA_FASTCLK                             (fastclk_i),
		      .PA_PSA_COMP                            (io_vif.nporeset),
		      .PA_CFGRSTn                             (io_vif.nsccrst),
		      .PA_nSRST                               (io_vif.nsrst),
		      .PA_nTRST                               (cxdt_ntrst_out),
		      .PA_TMS                                 (swdiotms),
		      .PA_TCK                                 (cxdt_swclktck),
		      .PA_TDO                                 (tdo),
		      .PA_TDI                                 (tdi),
		      .PA_DFT_nTRST                           (cxdt_ntrst_out),
		      .PA_DFT_TMS                             (),
		      .PA_DFT_TCK                             (cxdt_swclktck),
		      .PA_DFT_TDO                             (),
		      .PA_DFT_TDI                             (),
		      .PA_PALARM                              (),
		      .PA_CFGLOAD                             (io_vif.scc_load),
		      .PA_CFGWNR                              (io_vif.scc_wnr),
		      .PA_CFGDATAIN                           (io_vif.scc_datain),
		      .PA_CFGCLK                              (io_vif.scc_clk),
		      .PA_CFGDATAOUT                          (io_vif.scc_dataout),
		      .PA_AT_CI1                              (pa_at_ci1_tb),
		      .PA_AT_CI0                              (pa_at_ci0_tb),
		      .PA_AN_IO                               (pa_an_io_tb),
		      .PA15                                   (io_vif.dio_pa[15]),
		      .PA14                                   (io_vif.dio_pa[14]),
		      .PA13                                   (io_vif.dio_pa[13]),
		      .PA12                                   (io_vif.dio_pa[12]),
		      .PA11                                   (io_vif.dio_pa[11]),
		      .PA10                                   (io_vif.dio_pa[10]),
		      .PA9                                    (io_vif.dio_pa[9]),
		      .PA8                                    (io_vif.dio_pa[8]),
		      .PA7                                    (io_vif.dio_pa[7]),
		      .PA6                                    (io_vif.dio_pa[6]),
		      .PA5                                    (io_vif.dio_pa[5]),
		      .PA4                                    (io_vif.dio_pa[4]),
		      .PA3                                    (io_vif.dio_pa[3]),
		      .PA2                                    (io_vif.dio_pa[2]),
		      .PA1                                    (io_vif.dio_pa[1]),
		      .PA0                                    (io_vif.dio_pa[0])
		      );

   // ------------------------------------------------------------------------------------
   // wire/logic definitions - defn
   // ------------------------------------------------------------------------------------
   logic [31:0]                scc_command;
   logic [31:0] 	       scc_wrdata;
   logic [31:0] 	       scc_rddata;
   logic                       scc_busy;

   logic 		       cfgclk_i;
   logic 		       scc_load_done;
   logic 		       nsccrst_tb;
   logic 		       tbclk;
   logic 		       tbreset;


   assign pmu_bypass_tb = 1'b1;
   assign flash_pwr_ok_tb = 1'b1;

   assign pa_at_ci1_tb  = 1'b0;
   assign pa_at_ci0_tb = 1'b0;
   assign pa_an_io_tb = 1'b0;

   realtime 		       X32KCLK_PRD_IN_PS;
   realtime 		       FASTCLK_PRD_IN_PS;
   realtime 		       CFGCLK_PRD_IN_PS;
   realtime 		       SWCLKTCK_PRD_IN_PS;
   realtime 		       TBCLK_PRD_IN_PS;

   // ------------------------------------------------------------------------------------
   // Clock and reset generation
   // ------------------------------------------------------------------------------------
   reset_ctrl_if muscab2_rst_ctrl_if(
				     .ref_clk      (x32k_i),
				     .enable       (scc_load_done)
				     );

   assign muscab2_rst_ctrl_if.fclk_force_on = `MUSCAB2_AON_CRG.fclk_force_on;
   assign muscab2_rst_ctrl_if.fclk_force_off = `MUSCAB2_AON_CRG.fclk_force_off;

   assign io_vif.nporeset = muscab2_rst_ctrl_if.nporeset_reg;

   initial
     begin
	// Clock generator
	if(!$value$plusargs("X32KCLK_PRD_IN_PS=%0F", X32KCLK_PRD_IN_PS))
	  X32KCLK_PRD_IN_PS  = 30517578;  // 32 kHz default

	if (!$value$plusargs("FASTCLK_PRD_IN_PS=%0F", FASTCLK_PRD_IN_PS))
	  FASTCLK_PRD_IN_PS  = 14286; // 70 MHz default

	if (!$value$plusargs("CFGCLK_PRD_IN_PS=%0F", CFGCLK_PRD_IN_PS))
	  CFGCLK_PRD_IN_PS   = 100000;// 10 MHz default

	if (!$value$plusargs("SWCLKTCK_PRD_IN_PS=%0F", SWCLKTCK_PRD_IN_PS))
	  SWCLKTCK_PRD_IN_PS = 50000;// 20 MHz default

	if (!$value$plusargs("TBCLK_PRD_IN_PS=%0F", TBCLK_PRD_IN_PS))
	  TBCLK_PRD_IN_PS = 28571;// 35 MHz default

     end

   clock_gen       x32kclk_gen         (.clk (x32k_i),    .CLOCK_PERIOD_IN_PS (X32KCLK_PRD_IN_PS));
   clock_gen       fastclk_gen         (.clk (fastclk_i), .CLOCK_PERIOD_IN_PS (FASTCLK_PRD_IN_PS));
   clock_gen       cfgclk_gen          (.clk (cfgclk_i),  .CLOCK_PERIOD_IN_PS (CFGCLK_PRD_IN_PS));
   clock_gen       swclktck_gen        (.clk (swclktck),  .CLOCK_PERIOD_IN_PS (SWCLKTCK_PRD_IN_PS));
   clock_gen       tbclk_gen           (.clk (tbclk),     .CLOCK_PERIOD_IN_PS (TBCLK_PRD_IN_PS));




   reset_gen #(10) nsccrst_gen        (cfgclk_i, nsccrst_tb,1'b1);
   reset_gen #(10) ntrst_gen           (swclktck, cxdt_ntrst_in, `MUSCAB2_NT_DEBUG.core_poresetn);
   reset_gen #(10) tbreset_gen         (tbclk, tbreset, io_vif.nporeset);

   assign io_vif.nsrst = nsrst_tb;

   muscab2_io_if_mux u_muscab2_io_if_mux(io_vif);

   assign  cfgen_i     = 1'b0;

   assign io_vif.electra_sclk = `MUSCAB2_ELECTRA.SCLK;

   // ------------------------------------------------------------------------------------
   // PAD Enables
   //  Mirror the functionality of the DUT pad muxing by air-wiring into the output from the SCC
   //  Further information :
   //   Musca B2 Engineering Specification, pp  82/83
   //   https://armh.sharepoint.com/sites/ProjectDocuments/Systems/PJ10000037/engineering/specification/MuscaB2_IO_config.xlsx?web=1
   // ------------------------------------------------------------------------------------


   // UART enables
   assign u_muscab2_io_if_mux.uart0_tx_en            = (`MUSCAB2_SCC.scc_iomux_func_sel0[2:0] == 3'b010) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.uart0_rx_en            = (`MUSCAB2_SCC.scc_iomux_func_sel0[6:4] == 3'b010) ? 1'b1 : 1'b0;

   assign u_muscab2_io_if_mux.uart1_tx_en            = 1'b1;
   assign u_muscab2_io_if_mux.uart1_rx_en            = 1'b1;

   // GPIO enables
   assign u_muscab2_io_if_mux.gpio_en[0]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[2:0]   == 3'b100) ? 1'b1 : 1'b0;  //PA0_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[1]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[6:4]   == 3'b100) ? 1'b1 : 1'b0;  //PA1_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[2]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[10:8]  == 3'b100) ? 1'b1 : 1'b0;  //PA2_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[3]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[14:12] == 3'b100) ? 1'b1 : 1'b0;  //PA3_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[4]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[18:16] == 3'b100) ? 1'b1 : 1'b0;  //PA4_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[5]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[22:20] == 3'b100) ? 1'b1 : 1'b0;  //PA5_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[6]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[26:24] == 3'b100) ? 1'b1 : 1'b0;  //PA6_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[7]             = (`MUSCAB2_SCC.scc_iomux_func_sel0[30:28] == 3'b100) ? 1'b1 : 1'b0;  //PA7_MUX_FUNC_SEL

   assign u_muscab2_io_if_mux.gpio_en[8]             = (`MUSCAB2_SCC.scc_iomux_func_sel1[2:0]   == 3'b100) ? 1'b1 : 1'b0;  //PA8_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[9]             = (`MUSCAB2_SCC.scc_iomux_func_sel1[6:4]   == 3'b100) ? 1'b1 : 1'b0;  //PA9_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[10]            = (`MUSCAB2_SCC.scc_iomux_func_sel1[10:8]  == 3'b100) ? 1'b1 : 1'b0;  //PA10_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[11]            = (`MUSCAB2_SCC.scc_iomux_func_sel1[14:12] == 3'b100) ? 1'b1 : 1'b0;  //PA11_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[12]            = (`MUSCAB2_SCC.scc_iomux_func_sel1[18:16] == 3'b100) ? 1'b1 : 1'b0;  //PA12_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[13]            = (`MUSCAB2_SCC.scc_iomux_func_sel1[22:20] == 3'b100) ? 1'b1 : 1'b0;  //PA13_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[14]            = (`MUSCAB2_SCC.scc_iomux_func_sel1[26:24] == 3'b100) ? 1'b1 : 1'b0;  //PA14_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.gpio_en[15]            = (`MUSCAB2_SCC.scc_iomux_func_sel1[30:28] == 3'b100) ? 1'b1 : 1'b0;  //PA15_MUX_FUNC_SEL

   // QSPI enables
   assign u_muscab2_io_if_mux.qspi_cs1_en            = 1'b1;
   assign u_muscab2_io_if_mux.qspi_iof0_en           = io_vif.nporeset;
   assign u_muscab2_io_if_mux.qspi_iof1_en           = io_vif.nporeset;
   assign u_muscab2_io_if_mux.qspi_iof2_en           = io_vif.nporeset;
   assign u_muscab2_io_if_mux.qspi_iof3_en           = io_vif.nporeset;
   assign u_muscab2_io_if_mux.qspi_sclk_en           = io_vif.nporeset;

   // SCC enables
   assign u_muscab2_io_if_mux.scc_load_en            =  !io_vif.nporeset;
   assign u_muscab2_io_if_mux.scc_wnr_en             =  !io_vif.nporeset;
   assign u_muscab2_io_if_mux.scc_datain_en          =  !io_vif.nporeset;
   assign u_muscab2_io_if_mux.scc_clk_en             =  !io_vif.nporeset;
   assign u_muscab2_io_if_mux.scc_dataout_en         =  !io_vif.nporeset;

   // I2C enables
   assign u_muscab2_io_if_mux.i2c0_sda_en            = (`MUSCAB2_SCC.scc_iomux_func_sel1[26:24] == 3'b010) ? 1'b1 : 1'b0;  //PA14_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.i2c0_scl_en            = (`MUSCAB2_SCC.scc_iomux_func_sel1[30:28] == 3'b010) ? 1'b1 : 1'b0;  //PA15_MUX_FUNC_SEL

   assign u_muscab2_io_if_mux.i2c1_sda_en            = 1'b1;  //no pad mux:  PA_I2C1_SDA connected directly
   assign u_muscab2_io_if_mux.i2c1_scl_en            = 1'b1;  //no pad mux:  PA_I2C1_SCL connected directly

   //I2S enables
   // Chan 0, master-tx
   assign u_muscab2_io_if_mux.mt_i2s_sck_en          = (`MUSCAB2_SCC.scc_iomux_func_sel1[6:4]   == 3'b010) ? 1'b1 : 1'b0;  //PA9_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.mt_i2s_ws0_en          = (`MUSCAB2_SCC.scc_iomux_func_sel0[26:24] == 3'b010) ? 1'b1 : 1'b0;  //PA6_MUX_FUNC_SEL,  NB! PA8/PA6 are both connected internally to twso
   assign u_muscab2_io_if_mux.mt_i2s_sd0_en          = (`MUSCAB2_SCC.scc_iomux_func_sel0[22:20] == 3'b010) ? 1'b1 : 1'b0;  //PA5_MUX_FUNC_SEL
   // Chan 1, master-tx
   // mt_i2s_sck shared from Chan0, PA9
   assign u_muscab2_io_if_mux.mt_i2s_ws1_en          =  (`MUSCAB2_SCC.scc_iomux_func_sel1[2:0]   == 3'b010) ? 1'b1 : 1'b0;  //PA8_MUX_FUNC_SEL, NB! PA8/PA6 are both connected internally to twso
   assign u_muscab2_io_if_mux.mt_i2s_sd1_en          = (`MUSCAB2_SCC.scc_iomux_func_sel0[30:28]  == 3'b010) ? 1'b1 : 1'b0;  //PA7_MUX_FUNC_SEL
   // Chan 2, master-rx
   assign u_muscab2_io_if_mux.mr_i2s_sck_en          = (`MUSCAB2_SCC.scc_iomux_func_sel0[18:16]  == 3'b010) ? 1'b1 : 1'b0;  //PA4_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.mr_i2s_ws_en           = (`MUSCAB2_SCC.scc_iomux_func_sel0[14:12]  == 3'b010) ? 1'b1 : 1'b0;  //PA3_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.mr_i2s_sd2_en          = (`MUSCAB2_SCC.scc_iomux_func_sel0[10:8]   == 3'b010) ? 1'b1 : 1'b0;  //PA2_MUX_FUNC_SEL

   // I3C enables
   assign u_muscab2_io_if_mux.i3c0_sda_pur_oen_en    = (`MUSCAB2_SCC.scc_iomux_func_sel1[22:20]  == 3'b001) ? 1'b1 : 1'b0;  //PA13_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.i3c0_sda_en            = (`MUSCAB2_SCC.scc_iomux_func_sel1[26:24]  == 3'b001) ? 1'b1 : 1'b0;  //PA14_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.i3c0_scl_en            = (`MUSCAB2_SCC.scc_iomux_func_sel1[30:28]  == 3'b001) ? 1'b1 : 1'b0;  //PA15_MUX_FUNC_SEL

   assign u_muscab2_io_if_mux.i3c1_sda_pur_oen_en    = 1'b1;  //no pad mux:  PA_I3C1_SDA_PUR_OEN connected directly
   assign u_muscab2_io_if_mux.i3c1_sda_en            = 1'b1;  //no pad mux:  PA_I3C1_SDA connected directly
   assign u_muscab2_io_if_mux.i3c1_scl_en            = 1'b1;  //no pad mux:  PA_I3C1_SCL connected directly

   wire             mhur_irq_0_en;
   wire             mhur_irq_1_en;
   wire             mhur_da_uart_rx_en;
   wire             mhur_da_uart_tx_en;
   wire             mhus_int_access_nr2r_en;
   wire             mhus_int_access_r2nr_en;
   wire             mhus_da_uart_rx_en;
   wire             mhus_da_uart_tx_en;

   // DMA Bus Bridge
   assign io_vif.mhur_da_uart_cts_en                 = (`MUSCAB2_SCC.scc_iomux_func_sel0[2:0]   == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhur_da_uart_rts_en                 = (`MUSCAB2_SCC.scc_iomux_func_sel0[6:4]   == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhur_da_uart_rx_en                  = (`MUSCAB2_SCC.scc_iomux_func_sel0[30:28] == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhur_da_uart_tx_en                  = (`MUSCAB2_SCC.scc_iomux_func_sel1[2:0]   == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhus_da_uart_cts_en                 = (`MUSCAB2_SCC.scc_iomux_func_sel1[6:4]   == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhus_da_uart_rts_en                 = (`MUSCAB2_SCC.scc_iomux_func_sel1[10:8]  == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhus_da_uart_rx_en                  = (`MUSCAB2_SCC.scc_iomux_func_sel1[14:12] == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhus_da_uart_tx_en                  = (`MUSCAB2_SCC.scc_iomux_func_sel1[18:16] == 3'b001) ? 1'b1 : 1'b0;
   assign io_vif.mhus_dma_bb_nuartrst                = `MUSCAB2_DMA_BB_SND.u_da_uart.nUARTRST;
   assign io_vif.mhur_dma_bb_nuartrst                = `MUSCAB2_DMA_BB_REC.u_da_uart.nUARTRST;
   assign io_vif.mhus_dma_bb_uartclk                 = `MUSCAB2_DMA_BB_SND.u_da_uart.UARTCLK;
   assign io_vif.mhur_dma_bb_uartclk                 = `MUSCAB2_DMA_BB_SND.u_da_uart.UARTCLK;

   // SPI

   assign u_muscab2_io_if_mux.spi_n_ss_en           = (`MUSCAB2_SCC.scc_iomux_func_sel1[10:8]  == 3'b010) ? 1'b1 : 1'b0;   //PA10
   assign u_muscab2_io_if_mux.spi_do_en             = (`MUSCAB2_SCC.scc_iomux_func_sel1[14:12] == 3'b010) ? 1'b1 : 1'b0;   //PA11
   assign u_muscab2_io_if_mux.spi_di_en             = (`MUSCAB2_SCC.scc_iomux_func_sel1[18:16] == 3'b010) ? 1'b1 : 1'b0;   //PA12
   assign u_muscab2_io_if_mux.spi_sck_en            = (`MUSCAB2_SCC.scc_iomux_func_sel1[22:20] == 3'b010) ? 1'b1 : 1'b0;   //PA13 


   // PWM
   assign u_muscab2_io_if_mux.pwm0_pwm_output_en     = (`MUSCAB2_SCC.scc_iomux_func_sel0[10:8 ]   == 3'b001) ? 1'b1 : 1'b0;  //PA2_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.pwm1_pwm_output_en     = (`MUSCAB2_SCC.scc_iomux_func_sel0[14:12]   == 3'b001) ? 1'b1 : 1'b0;  //PA3_MUX_FUNC_SEL
   assign u_muscab2_io_if_mux.pwm2_pwm_output_en     = (`MUSCAB2_SCC.scc_iomux_func_sel0[18:16]   == 3'b001) ? 1'b1 : 1'b0;  //PA4_MUX_FUNC_SEL


   // TEST_MUX_CTRL CLKs
   assign u_muscab2_io_if_mux.pllclk_en              = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0000 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.clk1hz_en              = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0001 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.socfclk_en             = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0010 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.sysfclk_en             = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0011 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.aonintclk_en           = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0100 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.memclk_en              = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0101 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.mhuifclk_en            = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0110 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.qspirefclk_en          = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b0111 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.spirefclk_en           = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1000 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.i3csysclk_en           = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1001 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.i2c0refclk_en          = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1010 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.i2c1refclk_en          = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1011 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.i2sclk_en              = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1100 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.electra_hclk_en        = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1101 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.electra_sclk_en        = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1110 ) ? 1'b1 : 1'b0;
   assign u_muscab2_io_if_mux.electra_dclk_en        = (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]   == 4'b1111 ) ? 1'b1 : 1'b0;


   // ------------------------------------------------------------------------------------
   // UART1 QVIP
   // ------------------------------------------------------------------------------------



   uart_device #("UART0_IF") qvip_uart0_dev
     (
      .tx_clk(tbclk),
      .rx_clk(tbclk),
      .tx(io_vif.uart0_uvc_tx), //io_vif.uart0_rx),
      .rx(io_vif.uart0_uvc_rx), //io_vif.uart0_tx),
      .RTSn(),
      .CTSn()
      );

   uart_device #("UART1_IF") qvip_uart1_dev
     (
      .tx_clk(tbclk),
      .rx_clk(tbclk),
      .tx(io_vif.uart1_rx),
      .rx(io_vif.uart1_tx),
      .RTSn(),
      .CTSn()
      );

   uart_device #("UART2_IF") qvip_uart_tb_dma_bb_mhus_dev
     (
      .tx_clk(tbclk),
      .rx_clk(tbclk),
      .tx(io_vif.dma_bb_mhus_uvc_tx), //io_vif.mhus_da_uart_rx),
      .rx(io_vif.dma_bb_mhus_uvc_rx), //io_vif.mhus_da_uart_tx),
      .RTSn(),//io_vif.mhus_da_uart_cts),
      .CTSn()//io_vif.mhus_da_uart_rts)
      );
   assign io_vif.mhus_da_uart_cts = 1'b0;

   uart_device #("UART3_IF") qvip_uart_tb_dma_bb_mhur_dev
     (
      .tx_clk(tbclk),
      .rx_clk(tbclk),
      .tx(io_vif.dma_bb_mhur_uvc_tx), //io_vif.mhur_da_uart_rx),
      .rx(io_vif.dma_bb_mhur_uvc_rx), //io_vif.mhur_da_uart_tx),
      .RTSn(),//io_vif.mhur_da_uart_cts),
      .CTSn()//io_vif.mhur_da_uart_rts)
      );
   assign io_vif.mhur_da_uart_cts = 1'b0;

   // ------------------------------------------------------------------------------------
   // I2C QVIP
   // ------------------------------------------------------------------------------------

   // Pad Pullups -
   // i2c0 can be enabled to use the internal PAD pullups, however this requires additional
   // functionality in the uvm test

   pullup(io_vif.i2c0_sda);
   pullup(io_vif.i2c0_scl);

   pullup(io_vif.i2c1_sda);
   pullup(io_vif.i2c1_scl);

   pullup(io_vif.i3c0_sda);
   pullup(io_vif.i3c0_scl);

   pullup(io_vif.i3c1_sda);
   pullup(io_vif.i3c1_scl);


   i2c_bidir_slave #(.IF_NAME("I2C0_IF")) qvip_i2c0
     (
      .SDA(io_vif.i2c0_sda),
      .SCL(io_vif.i2c0_scl),
      .sample_clk(1'bz)
      );

   i2c_bidir_slave #(.IF_NAME("I2C1_IF")) qvip_i2c1
     (
      .SDA(io_vif.i2c1_sda),
      .SCL(io_vif.i2c1_scl),
      .sample_clk(1'bz)
      );

   i2c_bidir_master #(.IF_NAME("I2C2_IF")) qvip_i2c2
     (
      .SDA(io_vif.i2c0_sda),
      .SCL(io_vif.i2c0_scl),
      .sample_clk(1'bz)
      );

   i2c_bidir_master #(.IF_NAME("I2C3_IF")) qvip_i2c3
     (
      .SDA(io_vif.i2c1_sda),
      .SCL(io_vif.i2c1_scl),
      .sample_clk(1'bz)
      );

   i2c_bidir_slave #(.IF_NAME("I2C4_IF")) qvip_i3c0
     (
      .SDA(io_vif.i3c0_sda),
      .SCL(io_vif.i3c0_scl),
      .sample_clk(1'bz)
      );


   i2c_bidir_slave #(.IF_NAME("I2C5_IF")) qvip_i3c1
     (
      .SDA(io_vif.i3c1_sda),
      .SCL(io_vif.i3c1_scl),
      .sample_clk(1'bz)
      );

   // i2c clock gate check
   i2s_clk_gate_monitor u_i2s_clk_gate_monitor
     (
      .nreset(io_vif.i3c1_sda),
      .t_clk_0(`MUSCAB2_SYS_PERIPH.i2s_clk_0),
      .t_clk_1(`MUSCAB2_SYS_PERIPH.i2s_clk_1),
      .t_clk_2(`MUSCAB2_SYS_PERIPH.i2s_clk_2),
      .t_clk_ts(`MUSCAB2_SYS_PERIPH.i2s_clk_ts),
      .t_clk_rs(`MUSCAB2_SYS_PERIPH.i2s_clk_rs)
      );



   // ------------------------------------------------------------------------------------
   // PWM
   // ------------------------------------------------------------------------------------
   pwm_monitor u_pwm_monitor_0
     (
      .clk        (`MUSCAB2_SYS_PERIPH.u_pwm0.pclk)                       ,
      .nreset     (`MUSCAB2_SYS_PERIPH.u_pwm0.n_p_reset)                  ,
      .pad        (io_vif.dio_pa[2])                                      ,
      .pwm_mux_en (u_muscab2_io_if_mux.pwm0_pwm_output_en)                ,
      .control_reg(`MUSCAB2_SYS_PERIPH.u_pwm0.i_interface.control_reg_out),
      .period_reg (`MUSCAB2_SYS_PERIPH.u_pwm0.i_interface.period_reg_out) ,
      .hitime_reg (`MUSCAB2_SYS_PERIPH.u_pwm0.i_interface.hitime_reg_out)
      );

   pwm_monitor u_pwm_monitor_1
     (
      .clk        (`MUSCAB2_SYS_PERIPH.u_pwm1.pclk)                       ,
      .nreset     (`MUSCAB2_SYS_PERIPH.u_pwm1.n_p_reset)                  ,
      .pad        (io_vif.dio_pa[3])                                      ,
      .pwm_mux_en (u_muscab2_io_if_mux.pwm1_pwm_output_en)                ,
      .control_reg(`MUSCAB2_SYS_PERIPH.u_pwm1.i_interface.control_reg_out),
      .period_reg (`MUSCAB2_SYS_PERIPH.u_pwm1.i_interface.period_reg_out) ,
      .hitime_reg (`MUSCAB2_SYS_PERIPH.u_pwm1.i_interface.hitime_reg_out)
      );

   pwm_monitor u_pwm_monitor_2
     (
      .clk        (`MUSCAB2_SYS_PERIPH.u_pwm2.pclk)                       ,
      .nreset     (`MUSCAB2_SYS_PERIPH.u_pwm2.n_p_reset)                  ,
      .pad        (io_vif.dio_pa[4])                                      ,
      .pwm_mux_en (u_muscab2_io_if_mux.pwm2_pwm_output_en)                ,
      .control_reg(`MUSCAB2_SYS_PERIPH.u_pwm2.i_interface.control_reg_out),
      .period_reg (`MUSCAB2_SYS_PERIPH.u_pwm2.i_interface.period_reg_out) ,
      .hitime_reg (`MUSCAB2_SYS_PERIPH.u_pwm2.i_interface.hitime_reg_out)
      );


   // ------------------------------------------------------------------------------------
   // TEST_MUX_CTRL
   // ------------------------------------------------------------------------------------
   test_mux_ctrl_monitor u_test_mux_ctrl_monitor
     (
      .clk (fastclk_i),
      .nreset (io_vif.nporeset),
      .pad (io_vif.dio_pa[29]),
      .mux_sel (`MUSCAB2_SCC.scc_test_mux_ctrl[3:0]),
      .clk_div (`MUSCAB2_SCC.scc_test_mux_ctrl[10:8])
      );

   // ------------------------------------------------------------------------------------
   // SCC BFM
   // ------------------------------------------------------------------------------------
   scc_bfm_interface scc_bfm_if();

   tcvip_scc_bfm u_tcvip_scc_bfm
     (
      .clk_in                        (cfgclk_i),
      .nrst_in                       (nsccrst_tb),
      .reload_req                    (1'b0),
      .reload_ack                    (),
      .load_done                     (scc_load_done),

      .bfm_command                   ({scc_bfm_if.bfm_command_type,scc_bfm_if.bfm_command_addr}), // input
      .bfm_wrdata                    (scc_bfm_if.bfm_wrdata), // input
      .bfm_rddata                    (scc_bfm_if.bfm_rddata), //output
      .bfm_busy                      (scc_bfm_if.bfm_busy),  //output

      .CLK                           (io_vif.scc_clk),
      .nRST                          (io_vif.scc_cfg_rstn),
      .LOAD                          (io_vif.scc_load),
      .WnR                           (io_vif.scc_wnr),
      .DATAIN                        (io_vif.scc_datain),
      .DATAOUT                       (io_vif.scc_dataout)
      );

   assign io_vif.nsccrst = io_vif.scc_cfg_rstn & io_vif.scc_cfg_rstn_ovrd;

   always_comb begin
      if($test$plusargs ("SCC_CFG_RSTn_OVRD_EN"))
	begin
	   if(`MUSCAB2_SYS_PERIPH.u_gpio_sys_0.GPOUT == 8'h61) begin
	      io_vif.scc_cfg_rstn_ovrd = 1'b0;
	   end
	   else begin
	      io_vif.scc_cfg_rstn_ovrd = 1'b1;
	   end
	end
      else begin
	 io_vif.scc_cfg_rstn_ovrd = 1'b1;
      end
   end


   // ------------------------------------------------------------------------------------
   // SPI Mode spi_do spi_di mux
   // 
   //  Use the spi_op_mode pin on the cdns_spi to determine the routing of the spi data lines
   // this is required the data lines are not bi-directional
   // There is similar logic on the chip itself
   // 
   // Note that the spi_op_mode reflects the mode of the cdns_spi , i.e. in master mode (1'b1)
   // connect the spi data lines to the QVIP master     
   // ------------------------------------------------------------------------------------

   wire qvip_spi_mstr_di;
   wire qvip_spi_mstr_do;
   wire qvip_spi_mstr_n_ss;
   wire qvip_spi_mstr_sck;

   wire qvip_spi_slv_di;
   wire qvip_spi_slv_do;
   wire qvip_spi_slv_n_ss;
   wire qvip_spi_slv_sck;
                                                    
   assign io_vif.spi_di     = `MUSCAB2_SYS_PERIPH.spi_op_mode ? qvip_spi_slv_do  : qvip_spi_mstr_do;
   assign qvip_spi_mstr_di  = `MUSCAB2_SYS_PERIPH.spi_op_mode ? 1'b0             : io_vif.spi_do;
   assign qvip_spi_slv_di   = `MUSCAB2_SYS_PERIPH.spi_op_mode ? io_vif.spi_do    : 1'b0;

   // qvip_spi_slv can never drive ss/sck so can connect direct to bidirectional pads
   assign qvip_spi_slv_n_ss = io_vif.spi_n_ss;
   assign qvip_spi_slv_sck  = io_vif.spi_sck;
  
   // disconnect qvip_spi_mstr ss/sck when cdns_spi is in master mode to prevent conflict on the bi-directional pads 
   // note the use of tranif0 , in other words , *connect* when in cdns_spi is in slave mode (spi_op_mode = 0).
   tranif0   qvip_spi_mstr_n_ss_tran      (io_vif.spi_n_ss,qvip_spi_mstr_n_ss,`MUSCAB2_SYS_PERIPH.spi_op_mode);
   tranif0   qvip_spi_mstr_n_sck_tran     (io_vif.spi_sck ,qvip_spi_mstr_sck ,`MUSCAB2_SYS_PERIPH.spi_op_mode);
   
   // ------------------------------------------------------------------------------------
   // SPI QVIP  
   // MB2 only has 1 SPI interface , however the cdns_spi can be configured in master or 
   // slave mode. To accomodate this two SPI QVIP's are used that are hard-configured to 
   // be either master or slave.
   // Alternatively could re-write the mentor spi_master/spi_slave module to include the 
   // data mux logic , and configure the agent ( during build time) to be either master 
   // or slave   
   //
   // ------------------------------------------------------------------------------------

   spi_slave #(.SPI_SS_WIDTH(SPI_SS_WIDTH),.IF_NAME("SPI0_IF")) qvip_spi_slv 
     (
      .sys_clk                       (`MUSCAB2_SYS_PERIPH.spi_ref_clk), 
      .reset                         (),    
      .SS                            (qvip_spi_slv_n_ss),
      .SCK                           (qvip_spi_slv_sck),
      .MOSI                          (qvip_spi_slv_di),
      .MISO                          (qvip_spi_slv_do) 
      );

 spi_master #(.SPI_SS_WIDTH(SPI_SS_WIDTH),.IF_NAME("SPI1_IF")) qvip_spi_mstr 
     (
      .sys_clk                       (`MUSCAB2_SYS_PERIPH.spi_ref_clk), 
      .reset                         (),     
//     .SS                            (io_vif.spi_n_ss),
//     .SCK                           (io_vif.spi_sck),
      .SS                            (qvip_spi_mstr_n_ss),
      .SCK                           (qvip_spi_mstr_sck),
      .MOSI                          (qvip_spi_mstr_do),
      .MISO                          (qvip_spi_mstr_di) 
      );


   // ------------------------------------------------------------------------------------
   // I2S QVIP
   //  weak pull down on the master_tx channel that is not selected.
   //  The pulldown not part of the i2s specification , but will  stop "X" errors on master_tx channel
   //  that is not in operation (mt_i2s_sck is shared between the two master_tx channels ).
   //  Alternatively the i2s slave that  is not in operation could be disabled in the inactive
   //  slave_rx sequence (if implemented)
   // ------------------------------------------------------------------------------------

   pulldown(io_vif.mt_i2s_sd1);
   pulldown(io_vif.mt_i2s_sd0);
   pulldown(io_vif.mt_i2s_ws0);
   pulldown(io_vif.mt_i2s_ws1);

   i2s_rx_slave #(.IF_NAME("I2S0_IF")) qvip_i2s_rx_slave_0
     (
      .SCK(io_vif.mt_i2s_sck),
      .WS      (io_vif.mt_i2s_ws0),
      .SD      (io_vif.mt_i2s_sd0),
      .SI         ()
      );

   i2s_rx_slave #("I2S1_IF") qvip_i2s_rx_slave_1
     (
      .SCK(io_vif.mt_i2s_sck),
      .WS(io_vif.mt_i2s_ws1),
      .SD(io_vif.mt_i2s_sd1),
      .SI()
      );

   i2s_tx_slave #("I2S2_IF") qvip_i2s_tx_slave
     (
      .SCK(io_vif.mr_i2s_sck),
      .WS(io_vif.mr_i2s_ws),
      .SD(io_vif.mr_i2s_sd2),
      .SI()
      );

   // ------------------------------------------------------------------------------------
   // I3C QVIP AB , cannot get working properly so am using the i2c QVIP instead
   // comment out for the moment until make a decision to remove completely
   // ------------------------------------------------------------------------------------

   //    pullup(io_vif.i3c0_scl);
   //    pullup(io_vif.i3c1_scl);
   //
   //    i3c_device #("I3C0_IF") qvip_i3c_0
   //    (
   //        .sda(io_vif.i3c0_sda),
   //        .scl(io_vif.i3c0_scl),
   //        //.ref_clk()
   //        .reset(io_vif.nporeset)
   //    );
   //
   //
   //    i3c_device #("I3C1_IF") qvip_i3c_1
   //    (
   //        .sda(io_vif.i3c1_sda),
   //        .scl(io_vif.i3c1_scl),
   //        //.ref_clk
   //        .reset(io_vif.nporeset)
   //
   //    );

   // ------------------------------------------------------------------------------------
   // QSPI Flash
   // ------------------------------------------------------------------------------------

   pullup(io_vif.qspi_cs1);

   N25Qxxx #(.memory_file(`FILENAME_mem)) u_qspi_vip 
     (
      .S                             (io_vif.qspi_cs1),
      .C_                            (io_vif.qspi_sclk),
      .HOLD_DQ3                      (io_vif.qspi_iof3),
      .DQ0                           (io_vif.qspi_iof0),
      .DQ1                           (io_vif.qspi_iof1),
      .Vcc                           (32'h00000708   ),
      .Vpp_W_DQ2                     (io_vif.qspi_iof2)
      );

   // ------------------------------------------------------------------------------------
   // UART Tube
   // ------------------------------------------------------------------------------------
   Uart_stdout Uart_tube 
     (
      .PCLK                           (`MUSCAB2_UART1.PCLK),
      .UARTCLK       (1'b0),
      .PRESETn       (`MUSCAB2_UART1.PRESETn),
      .nUARTRST      (`MUSCAB2_UART1.nUARTRST),
      .PSEL          (`MUSCAB2_UART1.PSEL),
      .PENABLE       (`MUSCAB2_UART1.PENABLE),
      .PWRITE        (`MUSCAB2_UART1.PWRITE),
      .PADDR         (`MUSCAB2_UART1.PADDR),

      .PWDATA        (`MUSCAB2_UART1.PWDATA),
      .UARTRXD       (),
      .SIRIN         (),
      .nUARTCTS      (),
      .nUARTDCD      (),
      .nUARTDSR      (),
      .nUARTRI       (),
      .UARTTXDMACLR  (),
      .UARTRXDMACLR  (),
      .SCANENABLE    (1'b0),
      .SCANINPCLK    (1'b0),
      .SCANINUCLK    (1'b0),

      .PRDATA        (),
      .UARTMSINTR    (),
      .UARTRXINTR    (),
      .UARTTXINTR    (),
      .UARTRTINTR    (),
      .UARTEINTR     (),
      .UARTINTR      (),
      .nSIROUT       (),
      .UARTTXD       (),
      .nUARTOut2     (),
      .nUARTOut1     (),
      .nUARTRTS      (),
      .nUARTDTR      (),
      .UARTTXDMASREQ (),
      .UARTTXDMABREQ (),
      .UARTRXDMASREQ (),
      .UARTRXDMABREQ (),
      .SCANOUTPCLK   (),
      .SCANOUTUCLK   ()
      );



   // ------------------------------------------------------------------------------------
   // Memory preload
   // ------------------------------------------------------------------------------------

`ifdef ARM_USE_TECH_RAM
   initial
     begin
	@(x32k_i)
	  #1; // unit delay required as tech model zeros mem
	// Electra internal SRAM
	`MUSCAB2_NT.u_electra.u_ss_sys.u_sram.u_sram_wrapper.u_SRAM_SP_2048X32M8WM1_MUSCA_1.loadmem("build/sse123_sram_0.bin32");
	`MUSCAB2_NT.u_electra.u_ss_sys.u_sram.u_sram_wrapper.u_SRAM_SP_2048X32M8WM1_MUSCA_2.loadmem("build/sse123_sram_1.bin32");
	// System Code SRAM
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_0.loadmem("build/code_sram_0.bin32");
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_1.loadmem("build/code_sram_1.bin32");
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_2.loadmem("build/code_sram_2.bin32");
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_3.loadmem("build/code_sram_3.bin32");
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_4.loadmem("build/code_sram_4.bin32");
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_5.loadmem("build/code_sram_5.bin32");
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_6.loadmem("build/code_sram_6.bin32");
	`MUSCAB2_MEM_SUBSYS_SRAM.u_soc_mem_sram_512kb.u_sram64k_7.loadmem("build/code_sram_7.bin32");
	// SoC SRAM
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_0.loadmem("build/soc_sram_0.bin32");
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_1.loadmem("build/soc_sram_1.bin32");
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_2.loadmem("build/soc_sram_2.bin32");
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_3.loadmem("build/soc_sram_3.bin32");
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_4.loadmem("build/soc_sram_4.bin32");
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_5.loadmem("build/soc_sram_5.bin32");
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_6.loadmem("build/soc_sram_6.bin32");
	`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_sram64k_7.loadmem("build/soc_sram_7.bin32");

	// Aruba ROM
	$readmemh("build/sc000_rom.rcf", `MUSCAB2_CI_0.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_rom_wrapper.u_arm_element_sp_rom_pa.mem);
	$readmemh("build/sc000_rom.rcf", `MUSCAB2_CI_1.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_rom_wrapper.u_arm_element_sp_rom_pa.mem);
	$readmemh("build/sc000_rom.rcf", `MUSCAB2_CI_2.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_rom_wrapper.u_arm_element_sp_rom_pa.mem);
	// Aruba SRAM
	`MUSCAB2_CI_0.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_sram_wrapper.u_arm_element_sp_ram_pa.loadmem("build/sc000_sram.bin32");
	`MUSCAB2_CI_1.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_sram_wrapper.u_arm_element_sp_ram_pa.loadmem("build/sc000_sram.bin32");
	`MUSCAB2_CI_2.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_sram_wrapper.u_arm_element_sp_ram_pa.loadmem("build/sc000_sram.bin32");
     end
`else
   initial
     begin
	// Electra internal SRAM
	$readmemh("build/sse123_sram.rcf",`MUSCAB2_NT.u_electra.u_ss_sys.u_sram.u_sram_wrapper.u_sp_ram_pa.mem);
	// System Code SRAM
	$readmemh("build/code_sram.rcf",`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_code_sram.u_soc_mem_sram_512kb.u_arm_element_sp_ram_pa.mem);
	// SoC SRAM
	$readmemh("build/soc_sram.rcf",`MUSCAB2_SYS.u_soc_mem_subsys.u_soc_mem_internal_flash.u_soc_mem_sram_512kb.u_arm_element_sp_ram_pa.mem);
	// Aruba ROM
	$readmemh("build/sc000_rom.rcf", `MUSCAB2_CI_0.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_rom_wrapper.u_arm_element_sp_rom_pa.mem);
	$readmemh("build/sc000_rom.rcf", `MUSCAB2_CI_1.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_rom_wrapper.u_arm_element_sp_rom_pa.mem);
	$readmemh("build/sc000_rom.rcf", `MUSCAB2_CI_2.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_rom_wrapper.u_arm_element_sp_rom_pa.mem);
	// Aruba SRAM
	#2;
	$readmemh("build/sc000_sram.rcf", `MUSCAB2_CI_0.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_sram_wrapper.u_arm_element_sp_ram_pa.mem);
	$readmemh("build/sc000_sram.rcf", `MUSCAB2_CI_1.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_sram_wrapper.u_arm_element_sp_ram_pa.mem);
	$readmemh("build/sc000_sram.rcf", `MUSCAB2_CI_2.u_ci_top.u_cryptss_core.u_cryptss_mem_integration.u_cryptss_sram_wrapper.u_arm_element_sp_ram_pa.mem);
     end
`endif

   // ------------------------------------------------------------------------------------
   // Execute UVM test
   // ------------------------------------------------------------------------------------
   //virtual io_vif.peripheral_con peripherals;
   initial
     begin
	vip_ahb5_common_pkg::vip_ahb5_master_if_wrapper#(vip_ahb5_vif_t) master_vif_wrapper;

	master_vif_wrapper = new(ci_pd_mem_if.intf);

	uvm_config_db#(vip_ahb5_common_pkg::vip_ahb5_if_wrapper)::set(uvm_root::get(),"uvm_test_top.tb_env.exp_ahb5_env.master","vif",master_vif_wrapper);
	$timeformat(-9, 2, " ns", 20);

	// Register the interface
	uvm_config_db#(virtual muscab2_io_if_mod)::set(uvm_root::get(),"*","muscab2_io_if_mod",io_vif);
	uvm_config_db#(reset_ctrl_vif_t)::set(uvm_root::get(),"uvm_test_top.tb_env.muscab2_rst_ctrl_if","vif",muscab2_rst_ctrl_if);

	uvm_config_db#(virtual scc_bfm_interface)::set(uvm_root::get(),"uvm_test_top.tb_env.m_scc_bfm_agent.m_driver","vif",scc_bfm_if);

	run_test();  // UVM function that kicks off the test
     end

   // ---------------------------------------------------------------------------
   // CXDT - JTAG master
   // ---------------------------------------------------------------------------
   CXDT #(
	  .IMAGENAME                     ("build/cxdt.bin"),
	  .SWCLKTCKDELAY                 (50ns))
   u_cxdt(
	  .CLK                           (),
	  .PORESETn                      (cxdt_ntrst_in),
	  // JTAG/SerialWire Debug Interface
	  .TDO                           (tdo),
	  .TDI                           (tdi),
	  .nTRST                         (cxdt_ntrst_out),
	  .SWCLKTCK                      (cxdt_swclktck),
	  .SWDIOTMS                      (swdiotms),
	  .nSRST                         (nsrst_tb),
	  // Needed for CoreSight SoC 600 CXDT
	  // Debug over Functional I/O Interface - NOT USED
	  .PCLK                          (1'b0),   //input  wire
	  .PRESETn                       (1'b0),   //input  wire
	  .PSEL                          (),       //output wire
	  .PENABLE                       (),       //output wire
	  .PWRITE                        (),       //output wire
	  .PWAKEUP                       (),       //output wire
	  .PADDR                         (),       //output wire [31:0]
	  .PWDATA                        (),       //output wire [31:0]
	  .PREADY                        (1'b0),   //input  wire
	  .PSLVERR                       (1'b0),   //input  wire
	  .PRDATA                        (32'h0)   //input  wire [31:0]
	  );

   // ------------------------------------------------------------------------------------
   // CI CPU CM0Plus tarmac intance
   // ------------------------------------------------------------------------------------
`ifdef ARM_CM0PIK_TARMAC

 `define ARM_CM0PIK_PATH `MUSCAB2_CI_0.u_ci_top.u_cryptss_core.u_CM0PINTEGRATION.u_imp

   cm0p_tarmac u_tarmac 
     (
      .en_i           (1'b1),
      .echo_i         (1'b0),
      .id_i           (32'h0),
      .use_time_i     (1'b1),
      .tube_i         (32'h40400000),
      .halted_i       (`ARM_CM0PIK_PATH.HALTED),
      .lockup_i       (`ARM_CM0PIK_PATH.LOCKUP),
      .hclk           (`ARM_CM0PIK_PATH.HCLK),
      .hready_i       (`ARM_CM0PIK_PATH.HREADY),
      .haddr_i        (`ARM_CM0PIK_PATH.HADDR[31:0]),
      .hprot_i        (`ARM_CM0PIK_PATH.HPROT[3:0]),
      .hsize_i        (`ARM_CM0PIK_PATH.HSIZE[2:0]),
      .hwrite_i       (`ARM_CM0PIK_PATH.HWRITE),
      .htrans_i       (`ARM_CM0PIK_PATH.HTRANS[1:0]),
      .hresetn_i      (`ARM_CM0PIK_PATH.HRESETn),
      .hresp_i        (`ARM_CM0PIK_PATH.HRESP),
      .hrdata_i       (`ARM_CM0PIK_PATH.HRDATA[31:0]),
      .hwdata_i       (`ARM_CM0PIK_PATH.HWDATA[31:0]),
      .ppb_trans_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_matrix.ppb_trans),
      .scs_rdata_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_matrix.scs_rdata),
      .ahb_trans_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.ahb_trans),
      .ipsr_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.ipsr_q[5:0]),
      .tbit_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.tbit_q),
      .fault_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.fault_q),
      .cc_pass_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.cc_pass),
      .spsel_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.spsel_q),
      .npriv_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.npriv_q),
      .primask_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.primask_q),
      .apsr_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.apsr_q[3:0]),
      .state_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.state_q[3:0]),
      .op_i           (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.op_q[15:0]),
      .op_s_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.op_s_q),
      .iq_i           (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.iq_q[15:0]),
      .iq_s_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.iq_s_q),
      .psp_en_i       (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.psp_en),
      .msp_en_i       (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.msp_en),
      .wr_data_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.wr_data[31:0]),
      .wr_data_sp_i   (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.wr_data_sp[29:0]),
      .wr_addr_en_i   (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.wr_addr_en[3:0]),
      .iaex_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.iaex_q[30:0]),
      .preempt_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.preempt),
      .int_ready_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.int_ready_q),
      .irq_ack_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.irq_ack),
      .rfe_ack_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.rfe_ack),
      .int_pend_num_i (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.nvm_int_pend_num_i[5:0]),
      .atomic_i       (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.atomic_q),
      .hardfault_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.hdf_req),
      .iotrans_i      (`ARM_CM0PIK_PATH.IOTRANS),
      .iowrite_i      (`ARM_CM0PIK_PATH.IOWRITE),
      .iosize_i       (`ARM_CM0PIK_PATH.IOSIZE[1:0]),
      .ioaddr_i       (`ARM_CM0PIK_PATH.IOADDR[31:0]),
      .iordata_i      (`ARM_CM0PIK_PATH.IORDATA[31:0]),
      .iowdata_i      (`ARM_CM0PIK_PATH.IOWDATA[31:0]),
      .slvtrans_i     (`ARM_CM0PIK_PATH.SLVTRANS[1:0]),
      .slvwrite_i     (`ARM_CM0PIK_PATH.SLVWRITE),
      .slvsize_i      (`ARM_CM0PIK_PATH.SLVSIZE[1:0]),
      .slvaddr_i      (`ARM_CM0PIK_PATH.SLVADDR[31:0]),
      .slvrdata_i     (`ARM_CM0PIK_PATH.SLVRDATA[31:0]),
      .slvwdata_i     (`ARM_CM0PIK_PATH.SLVWDATA[31:0]),
      .slvready_i     (`ARM_CM0PIK_PATH.SLVREADY),
      .slvresp_i      (`ARM_CM0PIK_PATH.SLVRESP)
      );

`endif // ARM_CM0PIK_TARMAC

   // ------------------------------------------------------------------------------------
   // CI Physical Security Sensors alarm interface
   // ------------------------------------------------------------------------------------
   ci_physec_alarm_if u_ci_physec_alarm_if();

   initial begin
      u_ci_physec_alarm_if.sg_vmin_alarm_l   = 1'b0 ;
      u_ci_physec_alarm_if.sg_hpn_alarm_l    = 2'b0;
      u_ci_physec_alarm_if.sg_vmin_alarm_r   = 1'b0;
      u_ci_physec_alarm_if.sg_hpn_alarm_r    = 2'b0;
      u_ci_physec_alarm_if.ash_alarm         = 1'b0;
      u_ci_physec_alarm_if.can_alarm         = 1'b0;
      u_ci_physec_alarm_if.hpn_alarm         = 4'b0;
      u_ci_physec_alarm_if.hpnchar_hpn_alarm = 8'b0;
      u_ci_physec_alarm_if.ctm_alarm         = 1'b0;
      u_ci_physec_alarm_if.vgd_alarm         = 2'b0;
      

      if($test$plusargs ("CI0_PHYSEC_ALARM_OVRD"))
	begin
	   force `MUSCAB2_CI_INT_CTM.ctm_alarm              = u_ci_physec_alarm_if.ctm_alarm;
	   force `MUSCAB2_CI_INT_VGD_0.vgd_alarm            = u_ci_physec_alarm_if.vgd_alarm[0];
	   force `MUSCAB2_CI_INT_VGD_1.vgd_alarm            = u_ci_physec_alarm_if.vgd_alarm[1];
	   force `MUSCAB2_CI_INT_HPN_CHAR.hpnchar_hpn_alarm = u_ci_physec_alarm_if.hpnchar_hpn_alarm;
	   force `MUSCAB2_CI_0_ASH.ash_alarm                = u_ci_physec_alarm_if.ash_alarm;
	   force `MUSCAB2_CI_0_CANARY.can_alarm             = u_ci_physec_alarm_if.can_alarm;
	   force `MUSCAB2_CI_0_HPN_0.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[0];
	   force `MUSCAB2_CI_0_HPN_1.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[1];
	   force `MUSCAB2_CI_0_HPN_2.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[2];
	   force `MUSCAB2_CI_0_HPN_3.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[3];
	   force `MUSCAB2_CC_0_SG_L.sg_vmin_alarm           = u_ci_physec_alarm_if.sg_vmin_alarm_l;
	   force `MUSCAB2_CC_0_SG_R.sg_vmin_alarm           = u_ci_physec_alarm_if.sg_vmin_alarm_r;
	   force `MUSCAB2_CC_0_SG_L.sg_hpn_alarm            = u_ci_physec_alarm_if.sg_hpn_alarm_l;
	   force `MUSCAB2_CC_0_SG_R.sg_hpn_alarm            = u_ci_physec_alarm_if.sg_hpn_alarm_r;
	end

      if($test$plusargs ("CI1_PHYSEC_ALARM_OVRD"))
	begin
	   force `MUSCAB2_CI_INT_CTM.ctm_alarm              = u_ci_physec_alarm_if.ctm_alarm;
	   force `MUSCAB2_CI_INT_VGD_0.vgd_alarm            = u_ci_physec_alarm_if.vgd_alarm[0];
	   force `MUSCAB2_CI_INT_VGD_1.vgd_alarm            = u_ci_physec_alarm_if.vgd_alarm[1];
	   force `MUSCAB2_CI_INT_HPN_CHAR.hpnchar_hpn_alarm = u_ci_physec_alarm_if.hpnchar_hpn_alarm;
	   force `MUSCAB2_CI_1_ASH.ash_alarm                = u_ci_physec_alarm_if.ash_alarm;
	   force `MUSCAB2_CI_1_CANARY.can_alarm             = u_ci_physec_alarm_if.can_alarm;
	   force `MUSCAB2_CI_1_HPN_0.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[0];
	   force `MUSCAB2_CI_1_HPN_1.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[1];
	   force `MUSCAB2_CI_1_HPN_2.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[2];
	   force `MUSCAB2_CI_1_HPN_3.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[3];
	   force `MUSCAB2_CC_1_SG_L.sg_vmin_alarm           = u_ci_physec_alarm_if.sg_vmin_alarm_l;
	   force `MUSCAB2_CC_1_SG_R.sg_vmin_alarm           = u_ci_physec_alarm_if.sg_vmin_alarm_r;
	   force `MUSCAB2_CC_1_SG_L.sg_hpn_alarm            = u_ci_physec_alarm_if.sg_hpn_alarm_l;
	   force `MUSCAB2_CC_1_SG_R.sg_hpn_alarm            = u_ci_physec_alarm_if.sg_hpn_alarm_r;
	end

      if($test$plusargs ("CI2_PHYSEC_ALARM_OVRD"))
	begin
	   force `MUSCAB2_CI_INT_CTM.ctm_alarm              = u_ci_physec_alarm_if.ctm_alarm;
	   force `MUSCAB2_CI_INT_VGD_0.vgd_alarm            = u_ci_physec_alarm_if.vgd_alarm[0];
	   force `MUSCAB2_CI_INT_VGD_1.vgd_alarm            = u_ci_physec_alarm_if.vgd_alarm[1];
	   force `MUSCAB2_CI_INT_HPN_CHAR.hpnchar_hpn_alarm = u_ci_physec_alarm_if.hpnchar_hpn_alarm;
	   force `MUSCAB2_CI_2_ASH.ash_alarm                = u_ci_physec_alarm_if.ash_alarm;
	   force `MUSCAB2_CI_2_CANARY.can_alarm             = u_ci_physec_alarm_if.can_alarm;
	   force `MUSCAB2_CI_2_HPN_0.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[0];
	   force `MUSCAB2_CI_2_HPN_1.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[1];
	   force `MUSCAB2_CI_2_HPN_2.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[2];
	   force `MUSCAB2_CI_2_HPN_3.hpn_alarm              = u_ci_physec_alarm_if.hpn_alarm[3];
	   force `MUSCAB2_CC_2_SG_L.sg_vmin_alarm           = u_ci_physec_alarm_if.sg_vmin_alarm_l;
	   force `MUSCAB2_CC_2_SG_R.sg_vmin_alarm           = u_ci_physec_alarm_if.sg_vmin_alarm_r;
	   force `MUSCAB2_CC_2_SG_L.sg_hpn_alarm            = u_ci_physec_alarm_if.sg_hpn_alarm_l;
	   force `MUSCAB2_CC_2_SG_R.sg_hpn_alarm            = u_ci_physec_alarm_if.sg_hpn_alarm_r;
	end

      uvm_config_db#(virtual ci_physec_alarm_if)::set(uvm_root::get(),"*","ci_physec_alarm_if",u_ci_physec_alarm_if);
   end

endmodule
