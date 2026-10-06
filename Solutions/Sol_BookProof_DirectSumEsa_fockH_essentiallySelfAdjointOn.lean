-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.fockH_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_essentiallySelfAdjointOn_of_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_DirectSumEsa_fockH_hasZeroDeficiencyOn
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
    EssentiallySelfAdjointOn (fockCore w) ((fockCore w).subtype.comp (fockH hw)) := essentiallySelfAdjointOn_of_hasZeroDeficiencyOn _ (fockH_hasZeroDeficiencyOn hw)
