`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2019 01:36:19
// Design Name:
// Module Name: vga640x480
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga640x480(
    input wire i_clk,           // base clock
    input wire i_pix_stb,       // pixel clock strobe
    output wire o_hs,           // horizontal sync
    output wire o_vs,           // vertical sync
    output wire [9:0] o_x,      // current pixel x position
    output wire [8:0] o_y,       // current pixel y position
    output wire animate
    );

    // VGA timings https://timetoexplore.net/blog/video-timings-vga-720p-1080p
    localparam HS_STA = 16;              // horizontal sync start
    localparam HS_END = 16 + 96;         // horizontal sync end
    localparam HA_STA = 16 + 96 + 48;    // horizontal active pixel start(where every line's drawing starts) 
    localparam VS_STA = 480 + 10;        // vertical sync start
    localparam VS_END = 480 + 10 + 2;    // vertical sync end
    localparam VA_END = 480;             // vertical active pixel end (where the screen's drawing ends)
    localparam LINE   = 800;             // complete line (pixels)
    localparam SCREEN = 525;             // complete screen (lines)

    reg [9:0] h_count;  // line position
    reg [9:0] v_count;  // screen position
    
    assign o_hs = ~((h_count >= HS_STA) & (h_count < HS_END)); // 1 outside the screen
    assign o_vs = ~((v_count >= VS_STA) & (v_count < VS_END)); // 1 outside the screen

    // keep x and y bound within the active pixels
    assign o_x = (h_count < HA_STA) ? 0 : (h_count - HA_STA); // when h_count<HA_STA, x will be 0, else h_count-HA_STA
    assign o_y = (v_count >= VA_END) ? (VA_END - 1) : (v_count); // when v_count>=VA_END, y will be VA_END-1, else v_count
    
    // animate: high for one tick at the end of the final active pixel line
    assign animate = ((v_count == VA_END - 1) & (h_count == LINE));


    always @ (posedge i_clk)
    begin
        if (i_pix_stb)  // once per pixel
        begin
            if (h_count == LINE)  // end of line
            begin
                h_count <= 0; // reset to 0 when line ends
                v_count <= v_count + 1;
            end
            else 
                h_count <= h_count + 1;

            if (v_count == SCREEN)  // end of screen
                v_count <= 0; // reset to 0 when screen ends
            else;
        end
    end
endmodule

