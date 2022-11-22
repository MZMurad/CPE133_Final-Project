`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2019 01:44:29
// Design Name: 
// Module Name: top
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


module Test(
    input wire clk,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input U,L,D,R,
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output reg [3:0] vgaRed,    // 4-bit VGA red output
    output reg [3:0] vgaGreen,    // 4-bit VGA green output
    output reg [3:0] vgaBlue,     // 4-bit VGA blue output
    output reg [3:0] sw
    );

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    reg [1:0] direction;
    always @(posedge clk)
    begin
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000
    end
    
   
    
    
    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
                   // because x is a reg, when it reaches 1023, adding to it will set it to 0
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511
                  // similarly, y will come back to 0 after it is 511 
    wire animate; // active after every frame for one tick
    

    
    
    vga640x480 display (
        .i_clk(clk),
        .i_pix_stb(pix_stb),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O),
        .o_x(x), 
        .o_y(y),
        .animate(animate)
    );
    
    
        
        
        
    
    
    
    

    // Printing Objects
     reg square; //background gamearea
     reg snake; //head of the snake
     reg snake1; // first block of snake's body
     reg snake2; // and so on
     reg snake3;
     reg snake4;
     reg snake5;
     reg snake6;
     reg snake7;
     reg snake8;
     reg snake9;
     reg snake10;
     reg snake11;
     reg snake12;
     reg snake13;
     reg food;
     
     
     // coordinates for every block.  
    reg [9:0] headx=200;
    reg [8:0] heady = 150;
    // headx and heady denote the coordinates of the top left corner of the snake's head
    // similarly for all 13 blocks. If length of snake hasn't reached a number, that block will be at 0,0
    //initial length of snake is 4
    reg [9:0] headx1 = 200;
    reg [8:0] heady1 = 130;
    reg [9:0] headx2 = 0;
    reg [8:0] heady2 = 0;
    reg [9:0] headx3 = 0;
    reg [8:0] heady3 = 0;
    reg [9:0] headx4 = 0;
    reg [8:0] heady4 = 0;
    reg [9:0] headx5 = 0;
    reg [8:0] heady5 = 0;
    reg [9:0] headx6 = 0;
    reg [8:0] heady6 = 0;
    reg [9:0] headx7 = 0;
    reg [8:0] heady7 = 0;
    reg [9:0] headx8 = 0;
    reg [8:0] heady8 = 0;
    reg [9:0] headx9 = 0;
    reg [8:0] heady9 = 0;
    reg [9:0] headx10 = 0;
    reg [8:0] heady10 = 0;
    reg [9:0] headx11 = 0;
    reg [8:0] heady11 = 0;
    reg [9:0] headx12 = 0;
    reg [8:0] heady12 = 0;
    reg [9:0] headx13 = 0;
    reg [8:0] heady13 = 0;
    
    // first food block will be at 300,200. next blocks will have pseudorandom coordinates
    reg [9:0] foodx = 300;
    reg [8:0] foody = 200;
    
        
    
    reg [4:0] div = 0; // controls the speed of snake. Rises to 16, then resets to 0.
    integer len = 4; // length of the snake
    reg flag = 1; // initial condition. Flag remains 0 throughout the code
    reg foodeat = 0; // checks whether food is being eaten. Triggers new block generation.
        




//THIS HERE IS TO BE AUGMENTED WITH AN FSM        
    // changing direction based on push-button input.
    always @(posedge clk)
    begin
        if(flag)
            begin direction = 1; flag = 0; end // sets initial direction to right.
        
        if (R && direction != 0) // if direction is left, the snake won't change direction if R is pressed.
            begin
                direction=2'b01; // if direction isn't left, change it to right.
            end
        if(D && direction != 2) // similarly for U, D, L
            begin
                direction=2'b11;
            end
        if (L && direction != 1)
            begin
                direction=2'b00;
            end
        if(U && direction != 3)
            begin
                direction=2'b10;
            end
    end
    
    
    always @(posedge animate)
    begin
        div <=div + 1;   // div controls speed of snake. It increases till 16, then resets to 0 
    end  
   
    always@(posedge div[3])
    begin
    if((((headx - foodx < 20) & (headx - foodx > 0)) || ((foodx - headx > 0) & (foodx - headx < 20))) & (((heady - foody < 20) & (heady - foody > 0)) || ((foody - heady < 20)) & (foody - heady > 0)))
     // checks if block is being eaten, by comparing top left corner
     // of food block and head of the snake.      
        begin
        len = len + 1; // increase length by 1 if food block is being eaten.
        foodeat = 1; // set foodeat=1 to triger new food block generation
        end

    
    if(foodeat)
        begin
            foodx = 80 + (headx*2 + headx1*2 + headx2*1)%450 ; // new food block generated
            foody = 80 + (heady*2 + headx1)%320; 
            foodeat = 0;
        end
    
    
    heady1 <= heady; // when snake moves 1 block, block1 replaces the head.
    headx1 <= headx;
    if(len>2)       // if a block exists, it'll replace the next block
    begin
    heady2 <= heady1;
    headx2 <= headx1;
    end
    // similar checking of length and replacement for all valid blocks.
    if(len>3)
    begin
    heady3 <= heady2;
    headx3 <= headx2;
    end
    if(len>4)
    begin
    heady4 <= heady3;
    headx4 <= headx3;
    end
    if(len>5)
    begin
    heady5 <= heady4;
    headx5 <= headx4;
    end
    if(len>6)
    begin
    heady6 <= heady5;
    headx6 <= headx5;
    end
    if(len>7)
    begin
    heady7 <= heady6;
    headx7 <= headx6;
    end
    if(len>8)
    begin
    heady8 <= heady7;
    headx8 <= headx7;
    end
    if(len>9)
    begin
    heady9 <= heady8;
    headx9 <= headx8;
    end
    if(len>10)
    begin
    heady10 <= heady9;
    headx10 <= headx9;
    end
    if(len>11)
    begin
    heady11 <= heady10;
    headx11 <= headx10;
    end
    if(len>12)
    begin
    heady12 <= heady11;
    headx12 <= headx11;
    end
    if(len>13)
    begin
    heady13 <= heady12;
    headx13 <= headx12;
    end
    
    
    // displaying the movement of snake according to direction.
    if(direction == 0) // Left
        begin
        headx <= headx - 20; // snake head will move 20 pixels to the left in x direction 
        end
    if(direction == 1) // Right
        begin
        headx <= headx + 20; // snake head will move 20 pixels to the right in x direction
        end
    if(direction == 3) // Down
        begin
        heady <= heady + 20; // snake head will move 20 pixels below in y direction
        end
    if(direction == 2) // Up
        begin
        heady <= heady - 20; // snake head will move 20 pixels above in y direction
        end
    end   
    
    //object defining section
    always_comb
    begin
    square = (x>20) & (x<620) & (y>20) & (y< 460); // storing all the pixels within the gamearea background
    
    snake = (x > headx) & (x < headx + 20) & (y>heady) & (y<heady + 20); // storing all pixels inside 20x20 square
                                                                         // with top left corner headx,heady
    // similar statements for all the blocks from 1 to 13.
    snake1 = (x > headx1) & (x < headx1 + 20) & (y>heady1) & (y<heady1 + 20);
    snake2 = (x > headx2) & (x < headx2 + 20) & (y>heady2) & (y<heady2 + 20);
    snake3 = (x > headx3) & (x < headx3 + 20) & (y>heady3) & (y<heady3 + 20);
    snake4 = (x > headx4) & (x < headx4 + 20) & (y>heady4) & (y<heady4 + 20);
    snake5 = (x > headx5) & (x < headx5 + 20) & (y>heady5) & (y<heady5 + 20);
    snake6 = (x > headx6) & (x < headx6 + 20) & (y>heady6) & (y<heady6 + 20);
    snake7 = (x > headx7) & (x < headx7 + 20) & (y>heady7) & (y<heady7 + 20);
    snake8 = (x > headx8) & (x < headx8 + 20) & (y>heady8) & (y<heady8 + 20);
    snake9 = (x > headx9) & (x < headx9 + 20) & (y>heady9) & (y<heady9 + 20);
    snake10 = (x > headx10) & (x < headx10 + 20) & (y>heady10) & (y<heady10 + 20);
    snake11 = (x > headx11) & (x < headx11 + 20) & (y>heady11) & (y<heady11 + 20);
    snake12 = (x > headx12) & (x < headx12 + 20) & (y>heady12) & (y<heady12 + 20);
    snake13 = (x > headx13) & (x < headx13 + 20) & (y>heady13) & (y<heady13 + 20);
    
    // storing all the pixels within the food block
    food = (x > foodx) & (x < foodx + 20) & (y> foody) & (y<foody + 20); 
  
    end
    
    
    //drawing section
    always_comb
    begin 
        
        vgaGreen[3] = square & ~(snake|food) ; // everything in gamearea except snake's head and food will be green
        vgaBlue[3] = food; // food will be blue
        vgaRed[3] = snake | snake1 | snake2 | snake3 | snake4 | snake5 | snake6 | snake7 | snake8 | snake9 | snake10 | snake11 | snake12 | snake13 | food;
        // whole body of snake and food will be red
        
        // hence, body of snake except head will be green + red = yellow
        // snake head = red
        // food = blue + red = purple
        // rest of the gamearea = green  
    end
    

endmodule
