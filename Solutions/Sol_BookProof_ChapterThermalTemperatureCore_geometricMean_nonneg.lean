-- Generated from ChapterThermalTemperatureCore.lean — solution of BookProof.ChapterThermalTemperatureCore.geometricMean_nonneg
import Mathlib
import Definitions.Def_ChapterThermalTemperatureCore
import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
open BookProof.ChapterThermalTemperatureCore



noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {r : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ r) (h1 : r < 1) : 0 ≤ geometricMean r := div_nonneg h0 (by linarith)
