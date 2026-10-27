-- Generated from ChapterNavierStokesFockLagrangian.lean — solution of BookProof.NavierStokesFlow.FockLagrangian.LagSymbols.hFull_eq_mulD
import Mathlib
import Definitions.Def_ChapterNavierStokesFockLagrangian
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_DominatedOn_add
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_mulD_add_prime
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_total_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_kinSym_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_visSym_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_driSym_meas
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_kinSym_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_visSym_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_driSym_dom
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_kinetic_eq
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_viscous_eq
import Theorems.Thm_BookProof_NavierStokesFlow_FockLagrangian_LagSymbols_drift_eq
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian.LagSymbols



open MeasureTheory



open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]
variable {μ : Measure X} (S : LagSymbols X μ)

set_option maxHeartbeats 1000000 in
theorem solution : S.data.hFull = mulD μ S.total_meas S.total_dom := by

  have hdec : S.data.hFull
      = S.data.kinetic + S.data.viscous + S.data.drift + S.data.constraintOp := rfl
  have hcon : S.data.constraintOp = mulD μ S.c_meas S.c_dom := rfl
  have hfold1 : mulD μ S.kinSym_meas S.kinSym_dom + mulD μ S.visSym_meas S.visSym_dom
      = mulD μ (S.kinSym_meas.add S.visSym_meas) (S.kinSym_dom.add S.visSym_dom) :=
    mulD_add_prime μ S.kinSym_meas S.visSym_meas (S.kinSym_meas.add S.visSym_meas) S.kinSym_dom
      S.visSym_dom (S.kinSym_dom.add S.visSym_dom) fun _ => rfl
  have hfold2 : mulD μ (S.kinSym_meas.add S.visSym_meas) (S.kinSym_dom.add S.visSym_dom)
        + mulD μ S.driSym_meas S.driSym_dom
      = mulD μ ((S.kinSym_meas.add S.visSym_meas).add S.driSym_meas)
          ((S.kinSym_dom.add S.visSym_dom).add S.driSym_dom) :=
    mulD_add_prime μ (S.kinSym_meas.add S.visSym_meas) S.driSym_meas
      ((S.kinSym_meas.add S.visSym_meas).add S.driSym_meas)
      (S.kinSym_dom.add S.visSym_dom) S.driSym_dom
      ((S.kinSym_dom.add S.visSym_dom).add S.driSym_dom) fun _ => rfl
  have hfold3 : mulD μ ((S.kinSym_meas.add S.visSym_meas).add S.driSym_meas)
            ((S.kinSym_dom.add S.visSym_dom).add S.driSym_dom)
        + mulD μ S.c_meas S.c_dom = mulD μ S.total_meas S.total_dom :=
    mulD_add_prime μ _ _ _ _ _ _ fun _ => rfl
  rw [hdec, S.kinetic_eq, S.viscous_eq, S.drift_eq, hcon]
  exact hfold1 ▸ (hfold2 ▸ hfold3)
