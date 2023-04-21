import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

# RANGE =          10 * 1000  takes      2 sec
# RANGE =         100 * 1000  takes     19 sec
# RANGE =        1000 * 1000  takes    189 sec
# RANGE =   10 * 1000 * 1000  takes   2193 sec     ~37 min
# RANGE =  100 * 1000 * 1000  takes  21572 sec     ~6 hr
RANGE  =          100 * 1000


ZERO   = 0b10001
ONE    = 0b00001
TWO    = 0b00011
THREE  = 0b00010
FOUR   = 0b00110
FIVE   = 0b00100
SIX    = 0b01100
SEVEN  = 0b01000
EIGHT  = 0b11000
NINE   = 0b10000

def get_value( value ) -> int:
    if value == 0:
        return ZERO
    elif value == 1:
        return ONE
    elif value == 2:
        return TWO
    elif value == 3:
        return THREE
    elif value == 4:
        return FOUR
    elif value == 5:
        return FIVE
    elif value == 6:
        return SIX
    elif value == 7:
        return SEVEN
    elif value == 8:
        return EIGHT
    elif value == 9:
        return NINE
    else:
        assert value
        return 0


def bit_grey( cnt ) -> int:
    val1  = cnt % 10
    rem1  = int( cnt / 10 )
    ret1  = get_value( val1 )

    val2  = rem1 % 10
    rem2  = int( rem1 / 10 )
    ret2  = get_value( val2 )

    val3  = rem2 % 10
    rem3  = int( rem2 / 10 )
    ret3  = get_value( val3 )

    val4  = rem3 % 10
    rem4  = int( rem3 / 10 )
    ret4  = get_value( val4 )

    val5  = rem4 % 10
    rem5  = int( rem4 / 10 )
    ret5  = get_value( val5 )

    val6  = rem5 % 10
    rem6  = int( rem5 / 10 )
    ret6  = get_value( val6 )

    val7  = rem6 % 10
    rem7  = int( rem6 / 10 )
    ret7  = get_value( val7 )

    val8  = rem7 % 10
    rem8  = int( rem7 / 10 )
    ret8  = get_value( val8 )

    val9  = rem8 % 10
    rem9  = int( rem8 / 10 )
    ret9  = get_value( val9 )

    val10 = rem9 % 10
    rem10 = int( rem9 / 10 )
    ret10 = get_value( val10 )

    val11 = rem10 % 10
    rem11 = int( rem10 / 10 )
    ret11 = get_value( val11 )

    val12 = rem11 % 10
    rem12 = int( rem11 / 10 )
    ret12 = get_value( val12 )

    return ((((((((((((((((((((((( ret12 ) *32 ) +
                                ret11 ) *32 ) +
                              ret10 ) *32 ) +
                            ret9 ) *32 ) +
                          ret8 ) *32 ) +
                        ret7 ) *32 ) +
                      ret6 ) *32 ) +
                    ret5 ) *32 ) +
                  ret4 ) *32 ) +
                ret3 ) *32 ) +
              ret2 ) *32 ) +
            ret1 )


def get_grey( dut ):
    return ( str( dut.HUN_BIL.value ) + " " +
             str( dut.TEN_BIL.value ) + " " +
             str( dut.BIL.value ) + " " +
             str( dut.HUN_MIL.value ) + " " +
             str( dut.TEN_MIL.value ) + " " +
             str( dut.MIL.value ) + " " +
             str( dut.HUN_THOU.value ) + " " +
             str( dut.TEN_THOU.value ) + " " +
             str( dut.THOU.value ) + " " +
             str( dut.HUND.value ) + " " +
             str( dut.TENS.value ) + " " +
             str( dut.ONES.value ) )


def match_value( bit_val, value, dut, cnt ):
    if value == 0:
        assert bit_val == ZERO, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 1:
        assert bit_val == ONE, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 2:
        assert bit_val == TWO, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 3:
        assert bit_val == THREE, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 4:
        assert bit_val == FOUR, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 5:
        assert bit_val == FIVE, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 6:
        assert bit_val == SIX, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 7:
        assert bit_val == SEVEN, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 8:
        assert bit_val == EIGHT, "%s %d" % ( get_grey( dut ), cnt )
    elif value == 9:
        assert bit_val == NINE, "%s %d" % ( get_grey( dut ), cnt )
    else:
        assert False, "%s %d" % ( get_grey( dut ), cnt )


def test_grey_cnt( dut, cnt ):
    val1  = cnt % 10
    rem1  = int( cnt / 10 )
    match_value( int( dut.ONES.value ), val1, dut, cnt )

    val2  = rem1 % 10
    rem2  = int( rem1 / 10 )
    match_value( int( dut.TENS.value ), val2, dut, cnt )

    val3  = rem2 % 10
    rem3  = int( rem2 / 10 )
    match_value( int( dut.HUND.value ), val3, dut, cnt )

    val4  = rem3 % 10
    rem4  = int( rem3 / 10 )
    match_value( int( dut.THOU.value ), val4, dut, cnt )

    val5  = rem4 % 10
    rem5  = int( rem4 / 10 )
    match_value( int( dut.TEN_THOU.value ), val5, dut, cnt )

    val6  = rem5 % 10
    rem6  = int( rem5 / 10 )
    match_value( int( dut.HUN_THOU.value ), val6, dut, cnt )

    val7  = rem6 % 10
    rem7  = int( rem6 / 10 )
    match_value( int( dut.MIL.value ), val7, dut, cnt )

    val8  = rem7 % 10
    rem8  = int( rem7 / 10 )
    match_value( int( dut.TEN_MIL.value ), val8, dut, cnt )

    val9  = rem8 % 10
    rem9  = int( rem8 / 10 )
    match_value( int( dut.HUN_MIL.value ), val9, dut, cnt )

    val10  = rem9 % 10
    rem10  = int( rem9 / 10 )
    match_value( int( dut.BIL.value ), val10, dut, cnt )

    val11  = rem10 % 10
    rem11  = int( rem10 / 10 )
    match_value( int( dut.TEN_BIL.value ), val11, dut, cnt )

    val12  = rem11 % 10
    rem12  = int( rem11 / 10 )
    match_value( int( dut.HUN_BIL.value ), val12, dut, cnt )


MAX_VALUE  = 1000 * 1000 * 1000 * 1000
LOG_INCR   =                100 * 1000

@cocotb.test()
async def test_my_design( dut ):
    dut._log.info( "start" )
    clock = Clock( dut.CLK, 10, units="ns" )
    cocotb.start_soon( clock.start() )

    cnt = MAX_VALUE - RANGE / 2
    dut.INIT.value = bit_grey( cnt )

    dut.RST.value = 1
    await ClockCycles( dut.CLK, 10 )
    dut.RST.value = 0

    dut._log.info( "Checking %d counts from %d to %d", RANGE, cnt, ( cnt + RANGE ) % MAX_VALUE )
    next_log = ( cnt + LOG_INCR ) % MAX_VALUE
    for xx in range( RANGE ):
        await ClockCycles( dut.CLK, 1 )
        test_grey_cnt( dut, cnt )
        cnt = ( cnt + 1 ) % MAX_VALUE
        if cnt == next_log:
            dut._log.info( "Count up to %d", cnt )
            next_log = ( cnt + LOG_INCR ) % MAX_VALUE
