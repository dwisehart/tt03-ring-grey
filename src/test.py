import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


@cocotb.test()
async def test_my_design( dut ):
    dut._log.info( "start" )
    clock = Clock( dut.CLK, 28, units="ns" )  # Should be us but simulation takes too long.
    cocotb.start_soon( clock.start() )

    dut.RST.value = 1
    await ClockCycles( dut.CLK, 1 )
    dut.RST.value = 0

    dut._log.info( "Starting test" )
    await ClockCycles( dut.CLK, 1 )
