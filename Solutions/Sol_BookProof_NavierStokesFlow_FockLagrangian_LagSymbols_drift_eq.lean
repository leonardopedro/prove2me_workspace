-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.drift_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_add
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_const_mul
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_add_prime
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_real_smul_prime
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_driSym_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_driSym_dom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : S.data.drift = mulD μ S.driSym_meas S.driSym_dom := by

  have hterm : ∀ i : Fin 3, ((S.force i : ℝ) : ℂ) • S.Drop i
      = mulD μ (measurable_const.mul (S.Dr_meas i))
          (DominatedOn.const_mul (S.force i) (S.Dr_dom i)) := fun i =>
    mulD_real_smul_prime μ (S.force i) (S.Dr_meas i) _ (S.Dr_dom i) _ fun _ => rfl
  have hdri : S.data.drift = ∑ i : Fin 3, ((S.force i : ℝ) : ℂ) • S.Drop i := rfl
  have hfold : mulD μ (measurable_const.mul (S.Dr_meas 0))
      (DominatedOn.const_mul (S.force 0) (S.Dr_dom 0))
      + mulD μ (measurable_const.mul (S.Dr_meas 1))
          (DominatedOn.const_mul (S.force 1) (S.Dr_dom 1))
      + mulD μ (measurable_const.mul (S.Dr_meas 2))
          (DominatedOn.const_mul (S.force 2) (S.Dr_dom 2))
      = mulD μ S.driSym_meas S.driSym_dom := by
    rw [mulD_add_prime μ _ _ ((measurable_const.mul (S.Dr_meas 0)).add
        (measurable_const.mul (S.Dr_meas 1))) _ _
      ((DominatedOn.const_mul (S.force 0) (S.Dr_dom 0)).add
        (DominatedOn.const_mul (S.force 1) (S.Dr_dom 1))) fun _ => rfl]
    exact mulD_add_prime μ _ _ _ _ _ _ fun x => by
      simp only [driSym]
      rw [Fin.sum_univ_three]
      simp [Pi.add_apply, Pi.mul_apply]
  rw [hdri, Fin.sum_univ_three, hterm 0, hterm 1, hterm 2]
  exact hfold
