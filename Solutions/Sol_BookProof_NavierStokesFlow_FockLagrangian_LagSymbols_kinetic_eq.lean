-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.kinetic_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_add
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_comp'
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_add'
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_real_smul'
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_sq_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_kinSym_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_kinSym_dom
open BookProof.NavierStokesFlow



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : S.data.kinetic = mulD μ S.kinSym_meas S.kinSym_dom := by

  have hsq : ∀ i : Fin 3, (S.Pop i).comp (S.Pop i)
      = mulD μ ((S.P_meas i).pow_const 2) (S.sq_dom i) := fun i =>
    mulD_comp' μ (S.P_meas i) (S.P_meas i) ((S.P_meas i).pow_const 2) (S.P_dom i)
      (S.P_dom i) (S.sq_dom i) fun x => by rw [pow_two]
  have hfold : mulD μ ((S.P_meas 0).pow_const 2) (S.sq_dom 0)
      + mulD μ ((S.P_meas 1).pow_const 2) (S.sq_dom 1)
      + mulD μ ((S.P_meas 2).pow_const 2) (S.sq_dom 2)
      = mulD μ (Finset.univ.measurable_sum fun i (_ : i ∈ Finset.univ) =>
            (S.P_meas i).pow_const 2)
          (DominatedOn.sum Finset.univ fun i _ => S.sq_dom i) := by
    rw [mulD_add' μ ((S.P_meas 0).pow_const 2) ((S.P_meas 1).pow_const 2)
        (((S.P_meas 0).pow_const 2).add ((S.P_meas 1).pow_const 2)) (S.sq_dom 0) (S.sq_dom 1)
        ((S.sq_dom 0).add (S.sq_dom 1)) fun _ => rfl]
    exact mulD_add' μ _ _ _ _ _ _ fun x => by
      rw [Fin.sum_univ_three]
      simp [Pi.add_apply]
  have hsum : (∑ i : Fin 3, (S.Pop i).comp (S.Pop i))
      = mulD μ (Finset.univ.measurable_sum fun i (_ : i ∈ Finset.univ) =>
            (S.P_meas i).pow_const 2)
          (DominatedOn.sum Finset.univ fun i _ => S.sq_dom i) := by
    rw [Fin.sum_univ_three, hsq 0, hsq 1, hsq 2]
    exact hfold
  have hkin : S.data.kinetic = ((1 / 2 : ℝ) : ℂ) • (∑ i : Fin 3, (S.Pop i).comp (S.Pop i)) := rfl
  rw [hkin, hsum]
  exact mulD_real_smul' μ (1 / 2 : ℝ) _ _ _ _ fun _ => rfl
