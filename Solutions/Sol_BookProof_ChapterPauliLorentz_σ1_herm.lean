-- Generated from ChapterPauliLorentz.lean — solution of BookProof.ChapterPauliLorentz.sigma1_herm
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : σ1ᴴ = σ1 := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [σ1, Matrix.conjTranspose_apply]
