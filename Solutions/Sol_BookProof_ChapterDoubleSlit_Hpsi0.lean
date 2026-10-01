-- Generated from ChapterDoubleSlit.lean — solution of BookProof.ChapterDoubleSlit.Hpsi0
import Mathlib
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : H *ᵥ psi0 = fun _ => (1 / Real.sqrt 2 : ℂ) := by

  funext i
  fin_cases i <;>
    simp [H, psi0, Matrix.mulVec, dotProduct, Fin.sum_univ_two, Matrix.smul_apply]
