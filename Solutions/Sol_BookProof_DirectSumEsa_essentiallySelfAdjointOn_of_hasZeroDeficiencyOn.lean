-- Generated from ChapterDirectSumEsa.lean — solution of BookProof.DirectSumEsa.essentiallySelfAdjointOn_of_hasZeroDeficiencyOn
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
    (A : Dom →ₗ[ℂ] Dom) (h : HasZeroDeficiencyOn Dom A) :
    EssentiallySelfAdjointOn Dom (Dom.subtype.comp A) := by

  constructor
  · intro w hw
    refine h.1 w (fun v => ?_)
    have hv : (inner ℂ (((Dom.subtype.comp A) v : F)) w : ℂ)
        = Complex.I * inner ℂ ((v : F)) w := hw v
    rw [inner_smul_right]
    exact hv
  · intro w hw
    refine h.2 w (fun v => ?_)
    have hv : (inner ℂ (((Dom.subtype.comp A) v : F)) w : ℂ)
        = -Complex.I * inner ℂ ((v : F)) w := hw v
    rw [inner_neg_right, inner_smul_right]
    exact hv.trans (by ring)
