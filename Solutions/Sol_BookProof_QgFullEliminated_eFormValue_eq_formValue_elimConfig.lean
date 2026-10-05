-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eFormValue_eq_formValue_elimConfig
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_eFormValue_torsion
import Theorems.Thm_BookProof_QgFullEliminated_eFormValue_dGauge
import Theorems.Thm_BookProof_QgFullEliminated_eFormValue_gauge3d
import Theorems.Thm_BookProof_QgFourierElim_formValue_dGauge_elimConfig
import Theorems.Thm_BookProof_QgFourierElim_formValue_gauge3d_elimConfig
import Theorems.Thm_BookProof_QgFourierElim_formValue_torsion_elimConfig
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (F : FormIdx) (z : EComp → ℂ) :
    formValue k F (elimConfig k z) = eFormValue k F z := by

  rcases F with ⟨mu, nu, i⟩ | (⟨mu, nu, i⟩ | i)
  · have hF : (Sum.inl (mu, nu, i) : FormIdx) = torsionF mu nu i := rfl
    rw [hF, formValue_torsion_elimConfig, eFormValue_torsion]
    ring
  · have hF : (Sum.inr (Sum.inl (mu, nu, i)) : FormIdx) = dGaugeF mu nu i := rfl
    rw [hF, formValue_dGauge_elimConfig, eFormValue_dGauge]
  · have hF : (Sum.inr (Sum.inr i) : FormIdx) = gauge3dF i := rfl
    rw [hF, formValue_gauge3d_elimConfig, eFormValue_gauge3d]
