-- Generated from ChapterDirectSumEsa.lean — theorem BookProof.DirectSumEsa.dsOp_deficiencyTrivialAt
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

theorem BookProof.DirectSumEsa.dsOp_deficiencyTrivialAt (H : ∀ i, D i →ₗ[ℂ] G i) {z : ℂ}
    (h : ∀ i, DeficiencyTrivialAt (D i) (H i) z) :
    DeficiencyTrivialAt (dsCore D) (dsOp H) z := by sorry
