-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.fockH_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOpD_isSymmetricDom
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
    FullEsa.IsSymmetricDom (fockH hw) := dsOpD_isSymmetricDom _ (fun n => multOp_isSymmetricDom _ (sectorEnergy_measurable hw n))
