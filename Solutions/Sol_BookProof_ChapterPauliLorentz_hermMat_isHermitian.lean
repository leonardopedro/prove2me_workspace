-- Generated from ChapterPauliLorentz.lean — solution of BookProof.ChapterPauliLorentz.hermMat_isHermitian
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 4 → ℝ) : (hermMat x)ᴴ = hermMat x := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [hermMat, Matrix.conjTranspose_apply, Complex.conj_I] ; ring
