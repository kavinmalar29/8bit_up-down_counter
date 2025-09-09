![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# 8-bit Up/Down Counter - Tiny Tapeout Project

- [Read the documentation for this project](docs/info.md)

## What is Tiny Tapeout?

Tiny Tapeout is an educational initiative that makes it easier and more affordable than ever to get your digital and analog designs manufactured on a real chip.

To learn more and get started, visit https://tinytapeout.com.

## About this project

This project implements an **8-bit up/down counter** in Verilog. The counter increments or decrements its value between 0 and 255 based on a control input. The counter updates on the **rising edge of the clock (`clk`)** when the **enable (`ui[0]`)** input is high. The direction is controlled by the **`up_down` (`ui[1]`)** signal. An active-low reset (`rst_n`) sets the counter to 0. The current value is output on the **`uo_out[7:0]`** bus.

### Summary of signals

- **Inputs:**
  - `ui[0]` → enable  
  - `ui[1]` → up/down control  
  - `ui[2]` → clock (`clk`)  
- **Outputs:**
  - `uo[0..7]` → 8-bit counter output  

### How it works

- When `enable` = 1:
  - `up_down` = 1 → counter increments by 1 on each clock pulse.
  - `up_down` = 0 → counter decrements by 1 on each clock pulse.
- When `enable` = 0 → counter holds its current value.
- `rst_n` = 0 → counter resets to 0.

#### Example sequence (counting up)

| Clock Cycle | Counter Value (Decimal) | Counter Value (Binary) |
| ----------- | ---------------------- | -------------------- |
| 0 (Reset)   | 0                      | 00000000             |
| 1           | 1                      | 00000001             |
| 2           | 2                      | 00000010             |
| 3           | 3                      | 00000011             |
| 4           | 4                      | 00000100             |
| …           | …                      | …                    |
| 255         | 255                    | 11111111             |
| 256         | 0                      | 00000000             | (wraps around)

#### Example sequence (counting down)

| Clock Cycle | Counter Value (Decimal) | Counter Value (Binary) |
| ----------- | ---------------------- | -------------------- |
| 0 (Reset)   | 0                      | 00000000             |
| 1           | 255                    | 11111111             |
| 2           | 254                    | 11111110             |
| 3           | 253                    | 11111101             |
| 4           | 252                    | 11111100             |
| …           | …                      | …                    |
| 256         | 0                      | 00000000             | (wraps around)

## How to test

1. Connect `clk` to a clock source (or use simulation).  
2. Set `ui[0]` high to enable counting.  
3. Set `ui[1]` high to count up, or low to count down.  
4. Toggle `rst_n` low to reset the counter.  
5. Observe `uo_out[7:0]` to verify the counter operation.  

Simulation can be performed using Verilog simulators such as Icarus Verilog or ModelSim. For TinyTapeout, the included testbench (`test/tb.v`) works with Cocotb for automated verification.

## External hardware

This project does **not require any external hardware**. All logic is contained in the TinyTapeout tile. Optionally, the 8-bit output bus can be connected to LEDs or a logic analyzer to visualize the count.

## Set up your Verilog project

1. Add your Verilog files to the `src` folder.  
2. Edit the `info.yaml` file to ensure the `top_module` is `tt_um_updown_counter` and list `project.v` in `source_files`.  
3. Ensure the testbench in `test/tb.v` instantiates `tt_um_updown_counter` with the correct ports.  
4. GitHub Actions will automatically build the ASIC files using [OpenLane](https://www.zerotoasiccourse.com/terminology/openlane/).

## Resources

- [Tiny Tapeout FAQ](https://tinytapeout.com/faq/)  
- [Digital design lessons](https://tinytapeout.com/digital_design/)  
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)  
- [Join the community](https://tinytapeout.com/discord)  
- [Build your design locally](https://www.tinytapeout.com/guides/local-hardening/)  

## What next?

- [Submit your design to the next shuttle](https://app.tinytapeout.com/).  
- Edit this README to add more details about your design and testing.  
- Share your project on social media:  
  - LinkedIn [#tinytapeout](https://www.linkedin.com/search/results/content/?keywords=%23tinytapeout) [@TinyTapeout](https://www.linkedin.com/company/100708654/)  
  - Mastodon [#tinytapeout](https://chaos.social/tags/tinytapeout) [@matthewvenn](https://chaos.social/@matthewvenn)  
  - X (Twitter) [#tinytapeout](https://twitter.com/hashtag/tinytapeout) [@tinytapeout](https://twitter.com/tinytapeout)
