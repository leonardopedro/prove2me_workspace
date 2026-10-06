-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.chargeConj_smul
import Mathlib
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (v : Fin 4 → ℂ) :
    chargeConj (c • v) = conj c • chargeConj v := by

  funext i; simp [chargeConj]
