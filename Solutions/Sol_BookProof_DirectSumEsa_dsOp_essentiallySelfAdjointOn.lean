-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.dsOp_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_deficiencyTrivialAt
open BookProof.DirectSumEsa



open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]
variable {D : ∀ i, Submodule ℂ (G i)}

set_option maxHeartbeats 1000000 in
theorem solution (H : ∀ i, D i →ₗ[ℂ] G i)
    (h : ∀ i, EssentiallySelfAdjointOn (D i) (H i)) :
    EssentiallySelfAdjointOn (dsCore D) (dsOp H) :=
  ⟨dsOp_deficiencyTrivialAt H (fun i => (h i).1),
      dsOp_deficiencyTrivialAt H (fun i => (h i).2)⟩
