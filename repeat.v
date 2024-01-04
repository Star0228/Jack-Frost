//update x_blue
                if (wasd_down[1] == 1'b1 &amp;&amp; wasd_down[3] == 1'b0 &amp;&amp; collision_state[3] == 1'b0) begin
                    blue_state[0] &lt;= 1'b0;
                    blue_state[2] &lt;= 1'b1;
                    if(left_cnt &lt; 12_500_00)begin
                        left_cnt &lt;= left_cnt + 1;
                    end else begin
                        left_cnt &lt;= 0;
                        x_blue &lt;= x_blue - 10'd1;
                    end
                end 
                else if (wasd_down[3] == 1'b1 &amp;&amp; collision_state[2] == 1'b0) begin
                    blue_state[0] &lt;= 1'b1;
                    blue_state[2] &lt;= 1'b1;
                    if(right_cnt &lt; 12_500_00)begin
                        right_cnt &lt;= right_cnt + 1;
                    end else begin
                        right_cnt &lt;= 0;
                        x_blue &lt;= x_blue + 10'd1;
                    end
                end 
                else begin
                    blue_state[2] &lt;= 1'b0;
                end

            //update y_blue
                if (wasd_down[0] == 1'b1 &amp;&amp; collision_state[1] == 1'b0) begin
                    if(up_cnt &lt; 12_500_00)begin
                        up_cnt &lt;= up_cnt + 1;
                    end else begin
                        up_cnt &lt;= 0;
                        y_blue &lt;= y_blue - 9'd1;
                    end
                end else if (wasd_down[2] == 1'b1 &amp;&amp; collision_state[0] == 1'b0) begin
                    if(down_cnt &lt; 12_500_00)begin
                        down_cnt &lt;= down_cnt + 1;
                    end else begin
                        down_cnt &lt;= 0;
                        y_blue &lt;= y_blue + 9'd1;
                    end
                end