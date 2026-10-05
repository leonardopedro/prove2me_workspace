-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.L_gf_invariant
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : S.s (S.s (Psi S)) = S.zero (2, 1) := S.s_nilpotent 2 (-1) (Psi S)
