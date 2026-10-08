-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.dsOp_essentiallySelfAdjointOn
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.DirectSumEsa


open scoped ENNReal


open BookProof.FarisLavine

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]

variable {D : ∀ i, Submodule ℂ (G i)}

theorem BookProof.DirectSumEsa.dsOp_essentiallySelfAdjointOn (H : ∀ i, D i →ₗ[ℂ] G i)
    (h : ∀ i, EssentiallySelfAdjointOn (D i) (H i)) :
    EssentiallySelfAdjointOn (dsCore D) (dsOp H) := by sorry
