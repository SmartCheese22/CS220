module encoder(
    input clk,
    input PB,
    output reg [7:0] output_led
);

    reg [3:0] counter;     // Counter for iterating through rg array
    reg [7:0] output_sum;  // Output sum value
    reg [15:0] rg[0:7];    // Array of registers holding temporary values
    reg [15:0] store;      // Memory for storing current values
    reg [3:0] temp_a;      // Temporary variable for summing elements of store
    reg [7:0] temp_b;      // Temporary variable for weighted sum of store elements
    integer i;             // for loop variable
    // Initialize values
    initial begin
        output_led <= 8'b11111111;
        store <= 0;
        temp_a <= 0;
        temp_b <= 0;
        output_sum <= 0;
        rg[0] = 16'h0000;
        rg[1] = 16'h8800;
        rg[2] = 16'h0100;
        rg[3] = 16'h8000;
        rg[4] = 16'h0001;
        rg[5] = 16'h0800;
        rg[6] = 16'h8110;
        rg[7] = 16'h0080;
    end

    // Always block for processing data on positive edge of clock
    always @(posedge clk) begin
        // Check if counter is not equal to 8
        if (counter != 8) begin
            // Load current value from rg array into store
            store <= rg[counter];
            temp_a = 8'b0;
            temp_b = 8'b0;

            // Loop through store to calculate temp_a and temp_b
            for ( i = 0; i < 16; i = i + 1) begin
                temp_a = temp_a + store[i];
                temp_b = temp_b + (i + 1) * store[i];
            end

            // Check condition for updating output_sum
            if (temp_a <= 1 && temp_a != 0) begin
                output_sum <= output_sum + temp_b;
            end
            else begin
                if (output_sum == 8'h00) begin
                    output_sum <= 8'b11111111;
                end
                else begin
                    output_sum <= output_sum - 1;
                end
            end
            // Increment counter
            counter <= counter + 1;
        end
        else begin
            // Check PB value to determine output_led
            if (PB == 0) begin
                output_led[7:1] <= 7'b0;
                output_led[0] <= output_sum[0] ^ output_sum[1] ^ output_sum[2] ^ output_sum[3] ^ output_sum[4] ^ output_sum[5] ^ output_sum[6] ^ output_sum[7];
            end
            else begin
                output_led <= output_sum;
            end
        end
    end
endmodule
