-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.viscous_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_add
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_sum
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_comp_prime
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_add_prime
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_real_smul_prime
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_sqQ_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_visSym_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_visSym_dom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : S.data.viscous = mulD μ S.visSym_meas S.visSym_dom := by

  have hsq : ∀ i : Fin 3, (S.Qop i).comp (S.Qop i)
      = mulD μ ((S.Q_meas i).pow_const 2) (S.sqQ_dom i) := fun i =>
    mulD_comp_prime μ (S.Q_meas i) (S.Q_meas i) ((S.Q_meas i).pow_const 2) (S.Q_dom i)
      (S.Q_dom i) (S.sqQ_dom i) fun x => by rw [pow_two]
  have hfold : mulD μ ((S.Q_meas 0).pow_const 2) (S.sqQ_dom 0)
      + mulD μ ((S.Q_meas 1).pow_const 2) (S.sqQ_dom 1)
      + mulD μ ((S.Q_meas 2).pow_const 2) (S.sqQ_dom 2)
      = mulD μ (Finset.univ.measurable_sum fun i (_ : i ∈ Finset.univ) =>
            (S.Q_meas i).pow_const 2)
          (DominatedOn.sum Finset.univ fun i _ => S.sqQ_dom i) := by
    rw [mulD_add_prime μ ((S.Q_meas 0).pow_const 2) ((S.Q_meas 1).pow_const 2)
        (((S.Q_meas 0).pow_const 2).add ((S.Q_meas 1).pow_const 2)) (S.sqQ_dom 0) (S.sqQ_dom 1)
        ((S.sqQ_dom 0).add (S.sqQ_dom 1)) fun _ => rfl]
    exact mulD_add_prime μ _ _ _ _ _ _ fun x => by
      rw [Fin.sum_univ_three]
      simp [Pi.add_apply]
  have hsum : (∑ i : Fin 3, (S.Qop i).comp (S.Qop i))
      = mulD μ (Finset.univ.measurable_sum fun i (_ : i ∈ Finset.univ) =>
            (S.Q_meas i).pow_const 2)
          (DominatedOn.sum Finset.univ fun i _ => S.sqQ_dom i) := by
    rw [Fin.sum_univ_three, hsq 0, hsq 1, hsq 2]
    exact hfold
  have hvis : S.data.viscous = ((S.nu : ℝ) : ℂ) • (∑ i : Fin 3, (S.Qop i).comp (S.Qop i)) := rfl
  rw [hvis, hsum]
  exact mulD_real_smul_prime μ S.nu _ _ _ _ fun _ => rfl
