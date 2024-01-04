        // always @ (posedge clk) begin
        //     if(~(isJump == 1'b0 && collision_state[0] == 1'b0))begin
        //         
        //     end else if(FallTimer == 31'd250000) begin
        //         FallTimerUpdate <= 0;
        //     end
        // end
        always @ (posedge clk) begin
            //update y_blue
                if(collision_state[1] == 1'b1 || JumpTimer == 31'd500000) begin//touch the ceiling
                    isJump = 1'b0;
                end
                else if(wasd_down[0] == 1'b1 && collision_state[0] == 1'b1) begin //jump from the ground
                    isJump = 1'b1;
                end

                if(isJump == 1'b0)begin
                    JumpTimer <= 31'd250000;
                    JumpTimerUpdate <= 0;
                    if(collision_state[0] == 1'b0) begin //fall from the air
                        if(FallTimerUpdate == 24) begin
                            if(FallTimer > 31'd200000)
                                FallTimer <= FallTimer - 31'd50000;
                            else
                                FallTimer <= 31'd200000;
                            FallTimerUpdate <= 0;
                        end else if(down_cnt < FallTimer)begin
                            down_cnt <= down_cnt + 1;
                        end else begin
                            down_cnt <= 0;
                            y_blue <= y_blue + 9'd1;
                            FallTimerUpdate <= FallTimerUpdate + 1;
                        end
                    end else begin
                        FallTimer <= 31'd500000;
                        FallTimerUpdate <= 0;
                    end
                end else begin//jump in the air
                    FallTimer <= 31'd500000;
                    FallTimerUpdate <= 0;
                    if(JumpTimerUpdate == 24) begin
                        JumpTimer <= JumpTimer + 31'd50000;
                        JumpTimerUpdate <= 0;
                    end else if(up_cnt < JumpTimer)begin
                        up_cnt <= up_cnt + 1;
                    end else begin
                        up_cnt <= 0;
                        y_blue <= y_blue - 9'd1;
                        JumpTimerUpdate <= JumpTimerUpdate + 1;
                    end
                end
        end