-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.int_L_gf_eq_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution (I : BrstIntegral S) : I.int (sTop S (Psi S)) = 0 := I.int_of_s (Psi S)
