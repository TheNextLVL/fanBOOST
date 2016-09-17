# fanBOOST
Enables manual control of the fan of the cpu-cooler on toshiba satellite L855-11k.

> THIS IS A MODIFICATION OF THE [fanBOOST v1.00] (http://forum.notebookreview.com/threads/possible-to-control-toshiba-laptop-fan-speed-with-rw-everythin.596408/#post-9290771) made by nem0

## Use tutorial
1. Download and install [rw-read and write utility x32] (http://rweverything.com/download/).
2. Execute fanBOOST.exe with administrator permissions.
3. Select the fanboost

## How to change values
under construction...

## How works
under construction...

## TODO
- [x] First release
- [ ] Finish the documentation
- [ ] Change the GUI
- [ ] Comment all code
- [ ] Find another easiest way to modify records

## History (nem0)
> on toshiba-laptops the fan is solely controlled by the embedded controller (ec), undefined in the acpi-table and thus not recognised by a wide range of available fan control software. and it's not as easy to obtain insight into the dynamics of the control system, as the ec-firmware ain't readily available for decompiling. hence you have to observe how the ec-registers behave and identify the significant bytes. you can do that as well as change the registers with rw-read & write utility.

> so to control the speed of the fan you can address registers in the ec, changing the mode of operation.
on my toshiba satellite L750 the default operation is a four step thermally toggled automatic regulation with rpms ranging from 0 to 4200, the final step kicking in above 70c, the bottom below 40c.
when you are on the final step it is possible to boost the speed to 5100 rpm by setting the value 0x04 in byte 0x55 in the ec-register.
the fan will speed down again below the downward threshold to step 2 at 65c.

> you can also get constant boost speed by setting the value 0x07 or choose slightly less noisy overspeeds by 0x0b or 0x09.  
> an inverted tachoreading can be read at word 0x5c + 0x5d and the celsius temperature at byte 0x58.


> of course there may be no simple linear relationship between raises in fanspeed and cooling ability.
in my experience, though, the boost speed enhances the cooling effect enough to keep both the graphics core (which is located at the far end of the heatpipe) and the ordinary processor cores well below the point of intels internal processor thermal throttling at 100 C playing current games. 

> in a 3x6 min full cpuload throttlestop bench test running at 2200mhz dissipating 29-33w (rising with temperature) the auto cooling goes 93c while fanBOOST level 3 goes 85c for the max core temp.
on top of a laptop cooler auto mode goes 91c while boosted goes 82c.
so fanBOOST lowers the temperature difference to the surroundings (24c) by 8c while the laptop cooler gives a 2c drop.

> the laptop cooler basically supplies fresh air for the intakes while fanBOOST increases the flow through the radiator.

> during the benchmarks the temperature drop across the processor was 6c. from these temperatures basic cooling theory tells an 11% effective rise in airflow between the auto mode and the fastest boost speed. and a corresponding rise in cooling power.
the rise in real airflow from the centrifugal fan ought to be of the order of the rise in speed of 21%. the difference from the observed is probably mostly due to the temperature drop along the heatpipe between processor and radiator.
in a superficial way along the same line the effective rise in cooling power due to the laptop cooler can be estimated to 3%.
but the laptop cooler is quite a bit more quiet though impractical. 


> i don't know why toshiba doesn't make the fanboost available to common users. the fans may be worn down quicker of course. what toshiba has done is to implement an extra quarantining throttling system, limiting the multiplier to 18x (of 22x stock, 31x max turbo) and seriously degrading the processor effect far below the tdp of 45W until restart.
this nagging limitation can however be eliminated by throttlestop (http://www.techinferno.com/downloads), leaving it up to the processor internals to regulate the power and multiplier capabilities. it seems like throttlestop is a mere necessity if you wanna run a laptop processor somewhere near the rated performance. it can also be used to limit the cpu-multipliers to leave sufficient power headroom for the integrated gpu. a multiplier in the range of 23x - 26x is good for gaming and other gpu-intensive tasks on my i7-2670qm processor.
