#!/usr/bin/env bash
# Download the Fluke DMM manuals listed in README.md from Fluke's public asset
# servers. Safe to re-run — curl skips unchanged files with --remote-time -z.
#
# Requires network egress to *.fluke.com. When run under the Claude Code
# sandbox, ~/.claude/settings.json must include the relevant hosts under
# sandbox.network.allowedDomains (takes effect on next session start).
set -euo pipefail

cd "$(dirname "$0")"
mkdir -p pdf
cd pdf

fetch() {
  local url="$1" out="$2"
  echo "==> $out"
  curl -fSL --retry 3 --retry-delay 2 --max-time 120 \
       --remote-time -z "$out" -o "$out" "$url"
}

# 87V / 87V MAX / 87V Ex / 80 Series
fetch "https://assets.fluke.com/manuals/87_89iv_umeng0200.pdf"                                      "fluke_87_89_series_iv_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/87______umeng0800.pdf"                                      "fluke_87_true_rms_users_manual.pdf"
fetch "https://media.fluke.com/d6882a66-83b2-4309-9ea7-b10800c2b791_original%20file.pdf"            "fluke_87v_max_users_manual.pdf"
fetch "https://media.fluke.com/fae6d611-fd60-4d38-905a-b10800c2b759_original%20file.pdf"            "fluke_87v_max_users_manual_supplement.pdf"
fetch "https://media.fluke.com/b62034b8-77ab-4322-9ad8-b10800c2b662_original%20file.pdf"            "fluke_87v_ex_users_manual_en.pdf"
fetch "https://assets.fluke.com/manuals/87vex___umger0000.pdf"                                      "fluke_87v_ex_users_manual_de.pdf"
fetch "https://assets.fluke.com/manuals/87vex___umspa0000.pdf"                                      "fluke_87v_ex_users_manual_es.pdf"
fetch "https://assets.fluke.com/manuals/87vex___umfre0000.pdf"                                      "fluke_87v_ex_users_manual_fr.pdf"
fetch "https://assets.fluke.com/manuals/83_85_87smeng0500.pdf"                                      "fluke_83_85_87_service_manual.pdf"
fetch "https://assets.fluke.com/manuals/8xiii___sieng0200.pdf"                                      "fluke_80_series_iii_users_manual.pdf"

# 77 IV / 75 / 77 Series
fetch "https://assets.fluke.com/manuals/77iv____umeng0000.pdf"                                      "fluke_77_iv_users_manual.pdf"
fetch "https://dam-assets.fluke.com/s3fs-public/77iv____cieng0100.pdf"                              "fluke_77_iv_calibration.pdf"
fetch "https://dam-assets.fluke.com/s3fs-public/77iii___smeng0100.pdf"                              "fluke_77_iii_service_manual.pdf"
fetch "https://assets.fluke.com/manuals/7x2x____isswe0200.pdf"                                      "fluke_77_75_23_21_series_iii_instr.pdf"

# 27 II / 28 II
fetch "https://assets.fluke.com/manuals/2x_2____umeng0000.pdf"                                      "fluke_27ii_28ii_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/2xii____gseng0000.pdf"                                      "fluke_27ii_28ii_quickstart.pdf"
fetch "https://media.fluke.com/9f0b48bf-43db-4463-9330-b2db003c2e34_original%20file.pdf"            "fluke_27ii_28ii_calibration.pdf"

# 114 / 115 / 116 / 117
fetch "https://assets.fluke.com/manuals/114_____umfre0000.pdf"                                      "fluke_114_115_117_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/115c117cumeng0100.pdf"                                      "fluke_115c_117c_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/114_____cieng0100.pdf"                                      "fluke_114_115_116_117_calibration.pdf"
fetch "https://media.fluke.com/5e1db354-3a6e-49cf-9edd-b10800c0e608_original%20file.pdf"            "fluke_110_113_114_115_117_users_manual_zh.pdf"
fetch "https://media.fluke.com/ce54d963-3be9-4e70-8a3e-b1060070fdfd_original%20file.pdf"            "fluke_114_115_116_117_datasheet.pdf"

# 175 / 177 / 179
fetch "https://assets.fluke.com/manuals/175_____umeng0000.pdf"                                      "fluke_175_177_179_users_manual_2003.pdf"
fetch "https://assets.fluke.com/manuals/175_____umeng0100.pdf"                                      "fluke_175_177_179_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/175_____umjpn0200.pdf"                                      "fluke_175_177_179_users_manual_jp.pdf"
fetch "https://assets.fluke.com/manuals/17x_____cieng0400.pdf"                                      "fluke_175_177_179_calibration.pdf"
fetch "https://assets.fluke.com/manuals/17x_____cieng0600.pdf"                                      "fluke_175_177_179_calibration_r6.pdf"

# 233 remote display
fetch "https://media.fluke.com/003ea73c-1bcd-40ca-9fbe-b10800c169e5_original%20file.pdf"            "fluke_233_users_manual.pdf"
fetch "https://media.fluke.com/c967a2c9-42e3-43de-a945-b10800c16718_original%20file.pdf"            "fluke_233_users_manual_alt.pdf"
fetch "https://dam-assets.fluke.com/s3fs-public/233_____cieng0000.pdf"                              "fluke_233_calibration.pdf"
fetch "https://media.fluke.com/673b0c0f-15a5-4be5-8c0e-b10600679fb9_original%20file.pdf"            "fluke_233_datasheet.pdf"

# 287 / 289 logging
fetch "https://assets.fluke.com/manuals/287_289_umeng0100.pdf"                                      "fluke_287_289_users_manual_r1.pdf"
fetch "https://dam-assets.fluke.com/s3fs-public/287_289_umeng0200.pdf"                              "fluke_287_289_users_manual_r2.pdf"
fetch "https://media.fluke.com/482d0d19-146b-484e-a5b6-b10800c17f06_original%20file.pdf"            "fluke_287_289_users_manual_de.pdf"
fetch "https://assets.fluke.com/manuals/287_289_cmeng0000.pdf"                                      "fluke_287_289_calibration.pdf"
fetch "https://assets.fluke.com/manuals/287_289_cmeng0105.pdf"                                      "fluke_287_289_calibration_supplement.pdf"
fetch "https://media.fluke.com/fa855fea-0b96-423b-8019-b10600677e71_original%20file.pdf"            "fluke_287_289_event_logging_appnote.pdf"

# 101 / 106 / 107 pocket
fetch "https://assets.fluke.com/manuals/101_____umeng0100.pdf"                                      "fluke_101_users_manual.pdf"
fetch "https://media.fluke.com/43695427-8f3d-4217-bfef-b10800c0e252_original%20file.pdf"            "fluke_101_users_manual_alt.pdf"
fetch "https://assets.fluke.com/manuals/106_____umeng0100.pdf"                                      "fluke_106_107_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/106_____umeng0000.pdf"                                      "fluke_106_107_users_manual_orig.pdf"
fetch "https://assets.fluke.com/manuals/106_____umpor0000.pdf"                                      "fluke_106_107_users_manual_pt.pdf"
fetch "https://media.fluke.com/f7ce60ca-d743-48c0-a8fc-b10600683bc5_original%20file.pdf"            "fluke_101_datasheet.pdf"

# 15B+ / 17B+ / 18B+
fetch "https://assets.fluke.com/manuals/151718__umeng0000.pdf"                                      "fluke_15bplus_17bplus_18bplus_users_manual.pdf"
fetch "https://media.fluke.com/39566075-7bc3-45bf-9afd-b2d90071dd51_original%20file.pdf"            "fluke_15bplus_17bplus_18bplus_users_manual_pt.pdf"
fetch "https://media.fluke.com/11f1df9e-b9f3-4e31-8144-b10800c110f6_original%20file.pdf"            "fluke_15bplus_17bplus_calibration.pdf"
fetch "https://assets.fluke.com/manuals/15b17b__umeng0400.pdf"                                      "fluke_15b_17b_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/15b17b__umspa0000.pdf"                                      "fluke_15b_17b_users_manual_es.pdf"
fetch "https://assets.fluke.com/manuals/18b_____umeng0100.pdf"                                      "fluke_18b_users_manual.pdf"

# Bench / precision
fetch "https://assets.fluke.com/manuals/8808a___umeng0000.pdf"                                      "fluke_8808a_users_manual.pdf"
fetch "https://assets.fluke.com/manuals/884xa___umeng0200.pdf"                                      "fluke_8845a_8846a_users_manual_r2.pdf"
fetch "https://media.fluke.com/fe06f115-fcf7-42bd-a42a-b10800c2bc5d_original%20file.pdf"            "fluke_8845a_8846a_users_manual_r3.pdf"
fetch "https://assets.fluke.com/manuals/884xa___umeng0000.pdf"                                      "fluke_8845a_8846a_users_manual_orig.pdf"
fetch "https://assets.fluke.com/manuals/884xa___umchi0200.pdf"                                      "fluke_8845a_8846a_users_manual_zh.pdf"
fetch "https://assets.fluke.com/manuals/8845a___pmeng0100.pdf"                                      "fluke_8845a_8846a_programmers_manual.pdf"
fetch "https://media.fluke.com/962bdcd3-536d-4e22-8108-b10800c2bba0_original%20file.pdf"            "fluke_8845a_8846a_calibration.pdf"
fetch "https://dam-assets.fluke.com/s3fs-public/2748044_6200_ENG_B_W.PDF"                           "fluke_8845a_8846a_extended_specs.pdf"
fetch "https://assets.fluke.com/manuals/8508A___umeng0300.pdf"                                      "fluke_8508a_users_manual.pdf"

echo
echo "Done. Files:"
ls -la | tail -n +2
