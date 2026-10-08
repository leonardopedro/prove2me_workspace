-- Generated from ChapterPauliLorentz.lean — solution of BookProof.ChapterPauliLorentz.sigma1sigma3_anti
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : σ1 * σ3 + σ3 * σ1 = 0 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ1, σ3]
