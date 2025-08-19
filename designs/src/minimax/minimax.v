`default_nettype none
module minimax (
	clk,
	reset,
	inst,
	inst_ce,
	rdata,
	inst_addr,
	addr,
	wdata,
	wmask,
	rreq,
	rack
);
	input wire clk;
	input wire reset;
	input wire [15:0] inst;
	output wire inst_ce;
	input wire [31:0] rdata;
	parameter PC_BITS = 12;
	output wire [PC_BITS - 1:0] inst_addr;
	output reg [31:0] addr;
	output reg [31:0] wdata;
	output reg [3:0] wmask;
	output reg rreq;
	input wire rack;
	parameter [31:0] UC_BASE = 32'h00000000;
	wire [31:0] uc_base;
	assign uc_base = UC_BASE;
	reg [31:0] register_file [63:0];
	reg [15:0] inst_e;
	wire [5:0] addrS;
	wire [5:0] addrD;
	reg [4:0] addrD_port;
	reg [4:0] addrS_port;
	reg bD_banksel;
	reg bS_banksel;
	wire [31:0] regS;
	wire [31:0] regD;
	wire [31:0] aluA;
	wire [31:0] aluB;
	wire [31:0] aluS;
	wire [31:0] aluX;
	reg [PC_BITS - 1:1] pc_f = {PC_BITS - 1 {1'b0}};
	reg [PC_BITS - 1:1] pc_d = {PC_BITS - 1 {1'b0}};
	reg [PC_BITS - 1:1] pc_e = {PC_BITS - 1 {1'b0}};
	wire [PC_BITS - 1:1] aguX;
	wire [PC_BITS - 1:1] aguA;
	wire [PC_BITS - 1:1] aguB;
	reg bubble_d = 1'b1;
	reg bubble_e = 1'b1;
	wire stall_f;
	wire stall_d;
	wire stall_e;
	reg microcode = 1'b0;
	wire op16_add_d;
	reg op16_add_e;
	wire op16_addi_d;
	reg op16_addi_e;
	wire op16_addi16sp_d;
	reg op16_addi16sp_e;
	wire op16_addi4spn_d;
	reg op16_addi4spn_e;
	wire op16_and_d;
	reg op16_and_e;
	wire op16_andi_d;
	reg op16_andi_e;
	wire op16_beqz_d;
	reg op16_beqz_e;
	wire op16_bnez_d;
	reg op16_bnez_e;
	wire op16_ebreak_d;
	reg op16_ebreak_e;
	wire op16_j_d;
	reg op16_j_e;
	wire op16_jal_d;
	reg op16_jal_e;
	wire op16_jalr_d;
	reg op16_jalr_e;
	wire op16_jr_d;
	reg op16_jr_e;
	wire op16_li_d;
	reg op16_li_e;
	wire op16_lui_d;
	reg op16_lui_e;
	wire op16_lw_d;
	reg op16_lw_e;
	wire op16_lwsp_d;
	reg op16_lwsp_e;
	wire op16_mv_d;
	reg op16_mv_e;
	wire op16_or_d;
	reg op16_or_e;
	wire op16_sb_d;
	reg op16_sb_e;
	wire op16_sh_d;
	reg op16_sh_e;
	wire op16_slli_d;
	reg op16_slli_e;
	wire op16_slli_setrd_d;
	reg op16_slli_setrd_e;
	wire op16_slli_setrs_d;
	reg op16_slli_setrs_e;
	wire op16_slli_thunk_d;
	reg op16_slli_thunk_e;
	wire op16_srai_d;
	reg op16_srai_e;
	wire op16_srli_d;
	reg op16_srli_e;
	wire op16_sub_d;
	reg op16_sub_e;
	wire op16_sw_d;
	reg op16_sw_e;
	wire op16_swsp_d;
	reg op16_swsp_e;
	wire op16_xor_d;
	reg op16_xor_e;
	wire op32_d;
	reg op32_e;
	wire [15:0] inst_type_masked_d = inst & 16'b1110000000000011;
	wire [15:0] inst_type_masked_zcb_d = inst & 16'b1111110000000011;
	wire [15:0] inst_type_masked_i16_d = inst & 16'b1110111110000011;
	wire [15:0] inst_type_masked_and_d = inst & 16'b1110110000000011;
	wire [15:0] inst_type_masked_op_d = inst & 16'b1110110001100011;
	wire [15:0] inst_type_masked_j_d = inst & 16'b1111000001111111;
	wire [15:0] inst_type_masked_mj_d = inst & 16'b1111000000000011;
	assign op16_addi4spn_d = inst_type_masked_d == 16'b0000000000000000;
	assign op16_lw_d = inst_type_masked_d == 16'b0100000000000000;
	assign op16_sw_d = inst_type_masked_d == 16'b1100000000000000;
	assign op16_sb_d = inst_type_masked_zcb_d == 16'b1000100000000000;
	assign op16_sh_d = inst_type_masked_zcb_d == 16'b1000110000000000;
	assign op16_addi_d = inst_type_masked_d == 16'b0000000000000001;
	assign op16_jal_d = inst_type_masked_d == 16'b0010000000000001;
	assign op16_li_d = inst_type_masked_d == 16'b0100000000000001;
	assign op16_addi16sp_d = inst_type_masked_i16_d == 16'b0110000100000001;
	assign op16_lui_d = (inst_type_masked_d == 16'b0110000000000001) & ~op16_addi16sp_d;
	assign op16_srli_d = inst_type_masked_zcb_d == 16'b1000000000000001;
	assign op16_srai_d = inst_type_masked_zcb_d == 16'b1000010000000001;
	assign op16_andi_d = inst_type_masked_and_d == 16'b1000100000000001;
	assign op16_sub_d = inst_type_masked_op_d == 16'b1000110000000001;
	assign op16_xor_d = inst_type_masked_op_d == 16'b1000110000100001;
	assign op16_or_d = inst_type_masked_op_d == 16'b1000110001000001;
	assign op16_and_d = inst_type_masked_op_d == 16'b1000110001100001;
	assign op16_j_d = inst_type_masked_d == 16'b1010000000000001;
	assign op16_beqz_d = inst_type_masked_d == 16'b1100000000000001;
	assign op16_bnez_d = inst_type_masked_d == 16'b1110000000000001;
	assign op16_slli_d = inst_type_masked_mj_d == 16'b0000000000000010;
	assign op16_lwsp_d = inst_type_masked_d == 16'b0100000000000010;
	assign op16_jr_d = inst_type_masked_j_d == 16'b1000000000000010;
	assign op16_mv_d = (inst_type_masked_mj_d == 16'b1000000000000010) & ~op16_jr_d;
	assign op16_ebreak_d = inst == 16'b1001000000000010;
	assign op16_jalr_d = (inst_type_masked_j_d == 16'b1001000000000010) & ~op16_ebreak_d;
	assign op16_add_d = ((inst_type_masked_mj_d == 16'b1001000000000010) & ~op16_jalr_d) & ~op16_ebreak_d;
	assign op16_swsp_d = inst_type_masked_d == 16'b1100000000000010;
	assign op16_slli_setrd_d = inst_type_masked_j_d == 16'b0001000000000110;
	assign op16_slli_setrs_d = inst_type_masked_j_d == 16'b0001000000001010;
	assign op16_slli_thunk_d = inst_type_masked_j_d == 16'b0001000000010010;
	assign op32_d = &inst[1:0];
	always @(posedge clk)
		if (~stall_e) begin
			op16_add_e <= op16_add_d;
			op16_addi_e <= op16_addi_d;
			op16_addi16sp_e <= op16_addi16sp_d;
			op16_addi4spn_e <= op16_addi4spn_d;
			op16_and_e <= op16_and_d;
			op16_andi_e <= op16_andi_d;
			op16_beqz_e <= op16_beqz_d;
			op16_bnez_e <= op16_bnez_d;
			op16_ebreak_e <= op16_ebreak_d;
			op16_j_e <= op16_j_d;
			op16_jal_e <= op16_jal_d;
			op16_jalr_e <= op16_jalr_d;
			op16_jr_e <= op16_jr_d;
			op16_li_e <= op16_li_d;
			op16_lui_e <= op16_lui_d;
			op16_lw_e <= op16_lw_d;
			op16_lwsp_e <= op16_lwsp_d;
			op16_mv_e <= op16_mv_d;
			op16_or_e <= op16_or_d;
			op16_sb_e <= op16_sb_d;
			op16_sh_e <= op16_sh_d;
			op16_slli_e <= op16_slli_d;
			op16_slli_setrd_e <= op16_slli_setrd_d;
			op16_slli_setrs_e <= op16_slli_setrs_d;
			op16_slli_thunk_e <= op16_slli_thunk_d;
			op16_srai_e <= op16_srai_d;
			op16_srli_e <= op16_srli_d;
			op16_sub_e <= op16_sub_d;
			op16_sw_e <= op16_sw_d;
			op16_swsp_e <= op16_swsp_d;
			op16_xor_e <= op16_xor_d;
			op32_e <= op32_d;
		end
	reg ld_stall = 0;
	assign stall_e = (~bubble_e & ((op16_lw_e | op16_lwsp_e) | ld_stall)) & ~rack;
	assign stall_d = stall_e & ~bubble_d;
	assign stall_f = stall_e & ~bubble_d;
	function automatic [31:0] _sv2v_strm_regD_reversed;
		input reg [31:0] inp;
		reg [31:0] _sv2v_strm_5EA55_inp;
		reg [31:0] _sv2v_strm_5EA55_out;
		integer _sv2v_strm_5EA55_idx;
		begin
			_sv2v_strm_5EA55_inp = {inp};
			for (_sv2v_strm_5EA55_idx = 0; _sv2v_strm_5EA55_idx <= 31; _sv2v_strm_5EA55_idx = _sv2v_strm_5EA55_idx + 1)
				_sv2v_strm_5EA55_out[31 - _sv2v_strm_5EA55_idx-:1] = _sv2v_strm_5EA55_inp[_sv2v_strm_5EA55_idx+:1];
			_sv2v_strm_regD_reversed = _sv2v_strm_5EA55_out << 0;
		end
	endfunction
	wire [31:0] regD_reversed = _sv2v_strm_regD_reversed({regD});
	reg shift_right_e;
	wire signed [32:0] ishift = (shift_right_e ? {regD[31] & op16_srai_e, regD} : {1'b0, regD_reversed});
	reg [4:0] shamt_e;
	wire [32:0] rshift = ishift >>> shamt_e;
	function automatic [31:0] _sv2v_strm_rshift_reversed;
		input reg [31:0] inp;
		reg [31:0] _sv2v_strm_5EA55_inp;
		reg [31:0] _sv2v_strm_5EA55_out;
		integer _sv2v_strm_5EA55_idx;
		begin
			_sv2v_strm_5EA55_inp = {inp};
			for (_sv2v_strm_5EA55_idx = 0; _sv2v_strm_5EA55_idx <= 31; _sv2v_strm_5EA55_idx = _sv2v_strm_5EA55_idx + 1)
				_sv2v_strm_5EA55_out[31 - _sv2v_strm_5EA55_idx-:1] = _sv2v_strm_5EA55_inp[_sv2v_strm_5EA55_idx+:1];
			_sv2v_strm_rshift_reversed = _sv2v_strm_5EA55_out << 0;
		end
	endfunction
	wire [31:0] rshift_reversed = _sv2v_strm_rshift_reversed({rshift[31:0]});
	wire [31:0] oshift = (shift_right_e ? rshift[31:0] : rshift_reversed);
	always @(posedge clk) begin
		rreq <= 1'b0;
		addr <= 32'b00000000000000000000000000000000;
		wmask <= 4'h0;
		wdata <= 32'b00000000000000000000000000000000;
		if (reset | rack)
			ld_stall <= 'b0;
		else if ((~bubble_e & ~ld_stall) & (op16_lw_e | op16_lwsp_e)) begin
			addr <= aluS;
			ld_stall <= 1'b1;
			rreq <= 1'b1;
		end
		else if (~bubble_e & (((op16_swsp_e | op16_sw_e) | op16_sh_e) | op16_sb_e)) begin
			addr <= aluS;
			wmask <= (({4 {op16_swsp_e}} | {4 {op16_sw_e}}) | ({4 {op16_sh_e}} & {{2 {inst_e[5]}}, {2 {~inst_e[5]}}})) | ({4 {op16_sb_e}} & {inst_e[6:5] == 2'b11, inst_e[6:5] == 2'b01, inst_e[6:5] == 2'b10, inst_e[6:5] == 2'b00});
			wdata <= oshift;
		end
	end
	assign inst_addr = {pc_f, 1'b0};
	assign inst_ce = ~stall_f;
	wire cond_taken = (op16_beqz_e & ~|regS) | (op16_bnez_e & |regS);
	wire branch_taken = (((cond_taken | op16_j_e) | op16_jal_e) | op16_jr_e) | op16_jalr_e;
	wire dest_abs = ~bubble_e & (((op32_e | op16_slli_thunk_e) | op16_jr_e) | op16_jalr_e);
	wire dest_pcrel = ~bubble_e & ((cond_taken | op16_j_e) | op16_jal_e);
	wire dest_next = (~dest_abs & ~dest_pcrel) & ~stall_e;
	always @(posedge clk)
		if (reset) begin
			pc_f <= 0;
			pc_d <= 0;
			pc_e <= 0;
			bubble_d <= 1'b1;
			bubble_e <= 1'b1;
			microcode <= 1'b0;
		end
		else begin
			if (~stall_f)
				pc_f <= aguX;
			if (~stall_d) begin
				pc_d <= pc_f;
				bubble_d <= ~bubble_e & ~dest_next;
			end
			if (~stall_e) begin
				pc_e <= pc_d;
				inst_e <= inst;
				bubble_e <= (~bubble_e & ~dest_next) | bubble_d;
				if (~bubble_e)
					microcode <= (microcode | op32_e) & ~op16_slli_thunk_e;
			end
		end
	reg [31:0] aluA_imm;
	reg [31:0] aluB_imm;
	always @(posedge clk)
		if (reset | bubble_d) begin
			addrD_port <= 0;
			addrS_port <= 0;
			bD_banksel <= 0;
			bS_banksel <= 0;
			aluA_imm <= 0;
			aluB_imm <= 0;
		end
		else if (~stall_e) begin
			addrD_port <= (((((5'b00001 & {5 {(op16_jal_d | op16_jalr_d) | op32_d}}) | (regD[4:0] & {5 {op16_slli_setrd_e & ~bubble_e}})) | (inst[6:2] & {5 {op16_swsp_d}})) | ({2'b01, inst[9:7]} & {5 {(((((op16_sub_d | op16_xor_d) | op16_or_d) | op16_and_d) | op16_andi_d) | op16_srli_d) | op16_srai_d}})) | ({2'b01, inst[4:2]} & {5 {(((op16_addi4spn_d | op16_sw_d) | op16_sh_d) | op16_sb_d) | op16_lw_d}})) | (inst[11:7] & {5 {((((((((op16_addi_d | op16_add_d) | (op16_mv_d & (~op16_slli_setrd_e | bubble_e))) | op16_addi16sp_d) | op16_slli_setrd_d) | op16_slli_setrs_d) | op16_li_d) | op16_lui_d) | op16_lwsp_d) | op16_slli_d}});
			addrS_port <= (((((regD[4:0] & {5 {op16_slli_setrs_e & ~bubble_e}}) | (5'b00010 & {5 {(op16_addi4spn_d | op16_lwsp_d) | op16_swsp_d}})) | ({2'b01, inst[9:7]} & {5 {((((op16_sw_d | op16_sh_d) | op16_sb_d) | op16_lw_d) | op16_beqz_d) | op16_bnez_d}})) | ({2'b01, inst[4:2]} & {5 {((op16_and_d | op16_or_d) | op16_xor_d) | op16_sub_d}})) | (inst[11:7] & {5 {(op16_jr_d | op16_jalr_d) | op16_slli_thunk_d}})) | (inst[6:2] & {5 {(op16_mv_d & (~op16_slli_setrs_e | bubble_e)) | op16_add_d}});
			bD_banksel <= (microcode ^ (~bubble_e & op16_slli_setrd_e)) | op32_d;
			bS_banksel <= (microcode ^ (~bubble_e & op16_slli_setrs_e)) | op32_d;
			(* full_case, parallel_case *)
			case (1'b1)
				op16_addi4spn_d: aluA_imm <= {22'b0000000000000000000000, inst[10:7], inst[12:11], inst[5], inst[6], 2'b00};
				op16_swsp_d: aluA_imm <= {24'b000000000000000000000000, inst[8:7], inst[12:9], 2'b00};
				op16_lwsp_d: aluA_imm <= {24'b000000000000000000000000, inst[3:2], inst[12], inst[6:4], 2'b00};
				op16_lw_d | op16_sw_d: aluA_imm <= {25'b0000000000000000000000000, inst[5], inst[12:10], inst[6], 2'b00};
				default: aluA_imm <= 0;
			endcase
			(* full_case, parallel_case *)
			case (1'b1)
				(op16_addi_d | op16_andi_d) | op16_li_d: aluB_imm <= {{27 {inst[12]}}, inst[6:2]};
				op16_lui_d: aluB_imm <= {{15 {inst[12]}}, inst[6:2], 12'b000000000000};
				op16_addi16sp_d: aluB_imm <= {{23 {inst[12]}}, inst[4:3], inst[5], inst[2], inst[6], 4'b0000};
				default: aluB_imm <= 0;
			endcase
		end
	assign addrD = {bD_banksel, addrD_port};
	assign addrS = {bS_banksel, addrS_port};
	assign regD = register_file[addrD];
	assign regS = register_file[addrS];
	assign aluA = aluA_imm | (regD & {32 {((((((op16_add_e | op16_addi_e) | op16_sub_e) | op16_and_e) | op16_andi_e) | op16_or_e) | op16_xor_e) | op16_addi16sp_e}});
	assign aluB = aluB_imm | regS;
	assign aluS = (op16_sub_e ? aluA - aluB : aluA + aluB);
	always @(posedge clk)
		if (reset | bubble_d) begin
			shamt_e <= 0;
			shift_right_e <= 0;
		end
		else begin
			case (1'b1)
				op16_srli_d: shamt_e <= inst[6:2];
				op16_srai_d: shamt_e <= inst[6:2];
				op16_slli_d: shamt_e <= inst[6:2];
				op16_sb_d: shamt_e <= {inst[5], inst[6], 3'b000};
				op16_sh_d: shamt_e <= {inst[5], 4'b0000};
				default: shamt_e <= 0;
			endcase
			shift_right_e <= op16_srli_d | op16_srai_d;
		end
	assign aluX = ((((((aluS & {32 {(((((op16_add_e | op16_sub_e) | op16_addi_e) | op16_li_e) | op16_lui_e) | op16_addi4spn_e) | op16_addi16sp_e}}) | ((aluA & aluB) & {32 {op16_andi_e | op16_and_e}})) | (oshift & {32 {(op16_slli_e | op16_srai_e) | op16_srli_e}})) | ((aluA ^ aluB) & {32 {op16_xor_e}})) | ((aluA | aluB) & {32 {op16_or_e | op16_mv_e}})) | (rdata & {32 {rack}})) | ({{32 - PC_BITS {1'b0}}, pc_d[PC_BITS - 1:1], 1'b0} & {32 {(op16_jal_e | op16_jalr_e) | op32_e}});
	assign aguA = (pc_f & {PC_BITS - 1 {dest_next}}) | (pc_e & {PC_BITS - 1 {dest_pcrel}});
	assign aguB = ((((regS[PC_BITS - 1:1] & {PC_BITS - 1 {~bubble_e & dest_abs}}) | ({{PC_BITS - 11 {inst_e[12]}}, inst_e[8], inst_e[10:9], inst_e[6], inst_e[7], inst_e[2], inst_e[11], inst_e[5:3]} & {PC_BITS - 1 {~bubble_e & (op16_j_e | op16_jal_e)}})) | ({{PC_BITS - 8 {inst_e[12]}}, inst_e[6:5], inst_e[2], inst_e[11:10], inst_e[4:3]} & {PC_BITS - 1 {~bubble_e & cond_taken}})) | (uc_base[PC_BITS - 1:1] & {PC_BITS - 1 {~bubble_e & op32_e}})) | {{PC_BITS - 2 {1'b0}}, dest_next};
	assign aguX = aguA + aguB;
	reg wb;
	always @(posedge clk) begin
		wb <= ~reset & (((((((((((((((((op32_d | op16_jal_d) | op16_jalr_d) | op16_li_d) | op16_lui_d) | op16_addi_d) | op16_addi4spn_d) | op16_addi16sp_d) | op16_andi_d) | op16_mv_d) | op16_add_d) | op16_and_d) | op16_or_d) | op16_xor_d) | op16_sub_d) | op16_slli_d) | op16_srli_d) | op16_srai_d);
		if ((|addrD[4:0] & ~(stall_e | bubble_e)) & (wb | rack))
			register_file[addrD] <= aluX;
	end
	initial begin : sv2v_autoblock_1
		integer i;
		for (i = 0; i < 64; i = i + 1)
			register_file[i] = 32'h00000000;
	end
endmodule