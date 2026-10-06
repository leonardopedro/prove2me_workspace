-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.hasZeroDeficiencyOn_of_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
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
theorem solution {Dom : Submodule ℂ F}
    (A : Dom →ₗ[ℂ] Dom) (h : EssentiallySelfAdjointOn Dom (Dom.subtype.comp A)) :
    HasZeroDeficiencyOn Dom A := by

  constructor
  · intro w hw
    refine h.1 w (fun v => ?_)
    have hv := hw v
    rw [inner_smul_right] at hv
    exact hv
  · intro w hw
    refine h.2 w (fun v => ?_)
    have hv : (inner ℂ ((A v : F)) w : ℂ) = inner ℂ ((v : F)) (-(Complex.I • w)) := hw v
    rw [inner_neg_right, inner_smul_right] at hv
    have hval : ((Dom.subtype ∘ₗ A) v : F) = (A v : F) := rfl
    rw [hval, hv]
    ring
