	qsys u0 (
		.clk_clk                            (<connected-to-clk_clk>),                            //                        clk.clk
		.reset_reset_n                      (<connected-to-reset_reset_n>),                      //                      reset.reset_n
		.sdram_clock_areset_conduit_export  (<connected-to-sdram_clock_areset_conduit_export>),  // sdram_clock_areset_conduit.export
		.sdram_clock_c0_clk                 (<connected-to-sdram_clock_c0_clk>),                 //             sdram_clock_c0.clk
		.sdram_read_control_fixed_location  (<connected-to-sdram_read_control_fixed_location>),  //         sdram_read_control.fixed_location
		.sdram_read_control_read_base       (<connected-to-sdram_read_control_read_base>),       //                           .read_base
		.sdram_read_control_read_length     (<connected-to-sdram_read_control_read_length>),     //                           .read_length
		.sdram_read_control_go              (<connected-to-sdram_read_control_go>),              //                           .go
		.sdram_read_control_done            (<connected-to-sdram_read_control_done>),            //                           .done
		.sdram_read_control_early_done      (<connected-to-sdram_read_control_early_done>),      //                           .early_done
		.sdram_read_user_read_buffer        (<connected-to-sdram_read_user_read_buffer>),        //            sdram_read_user.read_buffer
		.sdram_read_user_buffer_output_data (<connected-to-sdram_read_user_buffer_output_data>), //                           .buffer_output_data
		.sdram_read_user_data_available     (<connected-to-sdram_read_user_data_available>),     //                           .data_available
		.sdram_wire_addr                    (<connected-to-sdram_wire_addr>),                    //                 sdram_wire.addr
		.sdram_wire_ba                      (<connected-to-sdram_wire_ba>),                      //                           .ba
		.sdram_wire_cas_n                   (<connected-to-sdram_wire_cas_n>),                   //                           .cas_n
		.sdram_wire_cke                     (<connected-to-sdram_wire_cke>),                     //                           .cke
		.sdram_wire_cs_n                    (<connected-to-sdram_wire_cs_n>),                    //                           .cs_n
		.sdram_wire_dq                      (<connected-to-sdram_wire_dq>),                      //                           .dq
		.sdram_wire_dqm                     (<connected-to-sdram_wire_dqm>),                     //                           .dqm
		.sdram_wire_ras_n                   (<connected-to-sdram_wire_ras_n>),                   //                           .ras_n
		.sdram_wire_we_n                    (<connected-to-sdram_wire_we_n>),                    //                           .we_n
		.sdram_write_control_fixed_location (<connected-to-sdram_write_control_fixed_location>), //        sdram_write_control.fixed_location
		.sdram_write_control_write_base     (<connected-to-sdram_write_control_write_base>),     //                           .write_base
		.sdram_write_control_write_length   (<connected-to-sdram_write_control_write_length>),   //                           .write_length
		.sdram_write_control_go             (<connected-to-sdram_write_control_go>),             //                           .go
		.sdram_write_control_done           (<connected-to-sdram_write_control_done>),           //                           .done
		.sdram_write_user_write_buffer      (<connected-to-sdram_write_user_write_buffer>),      //           sdram_write_user.write_buffer
		.sdram_write_user_buffer_input_data (<connected-to-sdram_write_user_buffer_input_data>), //                           .buffer_input_data
		.sdram_write_user_buffer_full       (<connected-to-sdram_write_user_buffer_full>)        //                           .buffer_full
	);

