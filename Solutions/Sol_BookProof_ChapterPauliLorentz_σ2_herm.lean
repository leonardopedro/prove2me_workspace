-- Generated from ChapterPauliLorentz.lean — solution of BookProof.ChapterPauliLorentz.sigma2_herm
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : σ2ᴴ = σ2 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ2, Matrix.conjTranspose_apply, Complex.conj_I]
