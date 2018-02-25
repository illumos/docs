# Build times

As a convenience, we will try to assemble some build times for various hardware
configurations here, so you can get an idea in advance of how long it will
take:

| Processor(s)               |  No. of cores  |  Memory | Time (HH:MM) |   Notes                       |
|----------------------------|----------------|---------|--------------|-------------------------------|
| 2 x Xeon X5570 2.93GHz     | 2 x 4          | 36 GB   | 00:19        | NIGHTLY_OPTIONS='-FnCDmprt'   |
| 4 x Opteron 6172 2.1 GHz   | 4 x 12         | 128 GB  | 00:21        | NIGHTLY_OPTIONS='-FnCDmprt'   |
| Xeon E3-1270 3.4 GHz       | 4              | 16 GB   | 00:23        | NIGHTLY_OPTIONS='-FnCDmprt' |
| Core i7-3770 3.4GHz        | 4              | 8 GB    | 00:28        | NIGHTLY_OPTIONS='-nCprt' (with SSD, the production build for Tribblix) |
| Xeon E3-1245V2 3.4 GHz     | 4              | 16 GB   | 00:31        | NIGHTLY_OPTIONS='-FnCDmprt' |
| Core i7-2600K 3.4 GHz      | 4              | 8 GB    | 00:35        | NIGHTLY_OPTIONS='-nClmprt' |
| 2 x Xeon E5620 2.4 GHz     | 2 x 4          | 48 GB   | 00:38        | None |
| 1 x Xeon E5607 2.27GHz     | 1 x 4          | 12 GB   | 00:46        | NIGHTLY_OPTIONS='-FnCDmprt' |
| Xeon E3-1245V2 3.4 GHz     | 4              | 16 GB   | 00:47        | NIGHTLY_OPTIONS='-FnCDlmprt' (with lint) |
| 2 x Xeon E5540 2.53 GHz    | 2 x 4          | 24 GB   | 00:50        | With lint |
| 2 x Xeon E5506 2.13 GHz    | 2 x 4          | 24 GB   | 00:50        | No dmake check |
| 1 x Xeon X5650 2.67 GHz    | 1 x 6          | 12 GB   | 00:51        | With lint, default NIGHTLY_OPTIONS |
| 2 x Xeon E5506 2.13 GHz    | 2 x 4          | 24 GB   | 01:03        | None |
| Core i7-960 3.2 GHz        | 4              | 9 GB    | 01:03        | With lint |
| 2 x Xeon E5506 2.13 GHz    | 2 x 4          | 16 GB   | 01:06        | VMware Workstation guest |
| Core i7-930 2.8 GHz        | 4              | 8 GB    | 01:07        | VMware ESXi guest |
| Xeon  E5-2676 v3 2.4GHz    | 2              | 16 GB   | 01:13        | NIGHTLY_OPTIONS='-nCprt' (Tribblix) on an AWS m4.xlarge EC2 instance |
| Core 2 Quad Q6600 2.4 GHz  | 4              | 2 GB    | 01:16        | None |
| 2 x Xeon E5310 1.6 GHz     | 2 x 4          | 32 GB   | 01:24        | None |
| 1 x Athlon II X2 240 2.8 GHz | 2            | 2 GB    | 01:27        | NIGHTLY_OPTIONS='-FnCDmprt', on a low end SSD |
| Core 2 Quad Q9300 2.5 GHz    | 4            | 7 GB    | 01:32        | None |
| 2 x Xeon E5420 @ 2.50GHz     | 2 x 4        | 4 GB    | 01:33        | Default NIGHTLY_OPTIONS; an incremental rebuild takes 13 min to walk all Makefiles |
| 2 x Opteron 2218HE 2.6 GHz   | 2 x 2        | 16 GB   | 01:42        | None |
| Core i5-540M 2.53 GHz        | 2            | 4 GB    | 01:54        | None |
| 2 x UltraSPARC-T2+ 1165 MHz  | 128 threads  | 32 GB   | 02:18        | NIGHTLY_OPTIONS='-nCprt' (the Tribblix SPARC build) |
| Core i3-370M 2.40 GHz        | 2            | 2 GB    | 02:30        | None |
| Core 2 Quad Q8200 2.33 GHz   | 4            | 5 GB    | 02:30        | Default NIGHTLY_OPTIONS. |
| Core 2 Duo T8300 2.3 GHz (T61)     | 2      | 2 GB    | 02:58        | VMware Workstation 2 CPUs |
| Core 2 Duo E6750 2.66 GHz          | 2      | 8 GB    | 02:59        | Sun Ultra 24 (with lint) |
| Core 2 Duo Celeron E3200 3.2 GHz   | 2      | 4 GB    | 03:28        | 2.4 GHz CPU over clocked to 3.2. Everything running on a low end SSD. With lint. |
| Core 2 Duo T5600 1.8 GHz           | 2      | 3.3 GB  | 04:26        | None |
| Opteron 146 2 GHz                  | 1      | 4 GB    | 07:28        | None |
| 4 x Dual-Core Opteron 8218 2.6 GHz | (8-vCPU VM)   | 16 GB (2GB VM) | 35:47 + 9:05 | VirtualBox 3.0.12 VM, with 8 vCPUs and 2GB vRAM; local vHDD; with lint and default NIGHTLY_OPTIONS='-FnCDlmprt' NOTE: Package repo did not get built at all with the first nightly run, only with the second, incremental nightly run (another 9 hours) |

### Notes

* "Bare Metal" just slightly faster than VMware guest. On the other hand, VirtualBox painfully slow.
* More cores faster but not linear increase.
* SSD use seems to provide nice speedup.
* As expected, lint checking results in longer build times.
