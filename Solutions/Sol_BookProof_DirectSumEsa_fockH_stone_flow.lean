-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.fockH_stone_flow
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOpD_stone_flow
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_boundedEnergyCore_dense
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_multOp_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_multOp_isSymmetricDom
open BookProof.DirectSumEsa



open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable {D : ∀ i, Submodule ℂ (G i)}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {w : ℝ → ℝ} (hw : Measurable w) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint fockSpace)
      (U : ℝ → (fockSpace →L[ℂ] fockSpace)),
      EsaClosure.IsSelfAdjointExtension ((fockCore w).subtype.comp (fockH hw)) T.op ∧
        StoneBridge.IsStoneFlow T U :=
  dsOpD_stone_flow _
      (fun n => boundedEnergyCore_dense _ (sectorEnergy_measurable hw n))
      (fun n => multOp_isSymmetricDom _ (sectorEnergy_measurable hw n))
      (fun n => multOp_hasZeroDeficiencyOn _ (sectorEnergy_measurable hw n))
