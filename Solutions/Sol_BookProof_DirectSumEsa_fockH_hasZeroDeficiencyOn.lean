-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.fockH_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOpD_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_multOp_hasZeroDeficiencyOn
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
    HasZeroDeficiencyOn (fockCore w) (fockH hw) :=
  dsOpD_hasZeroDeficiencyOn _
      (fun n => multOp_hasZeroDeficiencyOn _ (sectorEnergy_measurable hw n))
