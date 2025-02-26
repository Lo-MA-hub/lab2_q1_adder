# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_adder(dut):
    """Test the 8-bit adder functionality."""
    
    dut._log.info("Starting adder test")

    # Define test cases: (ui_in, uio_in, expected output)
    test_cases = [
        (0, 0, 0),
        (10, 15, 25),
        (20, 30, 50),
        (255, 1, 0),  # Overflow case (8-bit wrap-around)
        (128, 128, 0) # Overflow case
    ]

    for ui_in, uio_in, expected in test_cases:
        # Set inputs
        dut.ui_in.value = ui_in
        dut.uio_in.value = uio_in

        # Wait briefly to ensure values settle (not strictly needed for combinational logic)
        await Timer(1, units="ns")

        # Check expected output
        assert dut.uo_out.value == expected, f"Adder failed: {ui_in} + {uio_in} = {dut.uo_out.value}, expected {expected}"
    
    dut._log.info("Adder test completed successfully")
