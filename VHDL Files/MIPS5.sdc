set_time_format -unit ns -decimal_places 3

derive_clock_uncertainty
derive_pll_clocks


create_clock -name {SCLK} -period 9 [get_ports {SCLK}]