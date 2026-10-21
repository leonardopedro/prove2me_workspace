-- Generated from ChapterNavierStokesGaugeY2.lean — solution of BookProof.NavierStokesGaugeY2.genY2_genY2_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesGaugeY2
import Theorems.Thm_BookProof_NavierStokesGaugeY2_end_ext_of_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY2_commutator_leibniz
import Theorems.Thm_BookProof_NavierStokesGaugeY2_genY2_leibniz
open BookProof.NavierStokesGaugeY2




open MvPolynomial BookProof.NavierStokesGaugeY

set_option maxHeartbeats 1000000 in
theorem solution (j k : Fin 3) : ⁅genY2 j, genY2 k⁆ = 0 := by

  refine end_ext_of_leibniz _
    (commutator_leibniz _ _ (genY2_leibniz j) (genY2_leibniz k)) (fun c => ?_) (fun v => ?_)
  · simp [Ring.lie_def]
  · rw [Ring.lie_def]
    cases v with
    | x m => simp
    | y m => by_cases h : j = m <;> by_cases h' : k = m <;> simp [h, h']
    | u i =>
        by_cases h : j = k
        · subst h; simp
        · simp [h, Ne.symm h]
    | uD i m => by_cases h : j = m <;> by_cases h' : k = m <;> simp [h, h']
    | uL i => simp
