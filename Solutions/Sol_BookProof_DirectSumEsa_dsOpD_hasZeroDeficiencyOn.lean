-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.dsOpD_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_essentiallySelfAdjointOn
import Theorems.Thm_BookProof_DirectSumEsa_hasZeroDeficiencyOn_of_essentiallySelfAdjointOn
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
theorem solution (A : ∀ i, D i →ₗ[ℂ] D i)
    (h : ∀ i, HasZeroDeficiencyOn (D i) (A i)) :
    HasZeroDeficiencyOn (dsCore D) (dsOpD A) := by

  refine hasZeroDeficiencyOn_of_essentiallySelfAdjointOn _
    (dsOp_essentiallySelfAdjointOn (fun i => (D i).subtype.comp (A i)) (fun i => ⟨?_, ?_⟩))
  · intro w hw
    refine (h i).1 w (fun v => ?_)
    rw [inner_smul_right]
    exact hw v
  · intro w hw
    refine (h i).2 w (fun v => ?_)
    have hv : (inner ℂ ((A i v : G i)) w : ℂ) = -Complex.I * inner ℂ ((v : G i)) w := hw v
    rw [inner_neg_right, inner_smul_right, hv]
    ring
