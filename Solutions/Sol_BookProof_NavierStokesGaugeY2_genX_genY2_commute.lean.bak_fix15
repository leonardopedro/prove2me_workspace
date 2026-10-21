-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genX_genY2_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_end_ext_of_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY2_commutator_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY_genX_leibniz
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) : ⁅genX j, genY2 k⁆ = 0 := by

  refine end_ext_of_leibniz _
    (commutator_leibniz _ _ (genX_leibniz j) (genY2_leibniz k)) (fun c => ?_) (fun v => ?_)
  · simp [Ring.lie_def, genX_apply]
  · rw [Ring.lie_def]
    cases v with
    | x m => by_cases h : j = m <;> simp [genX_apply, pderiv_X, h]
    | y m => by_cases h : k = m <;> simp [genX_apply, pderiv_X, h]
    | u i => simp [genX_apply, pderiv_X]
    | uD i m => by_cases h : k = m <;> simp [genX_apply, pderiv_X, h]
    | uL i => simp [genX_apply, pderiv_X]
