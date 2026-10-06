-- Generated from ChapterDirectSumEdge.lean — theorem BookProof.DirectSumEdge.quadForm_dsOp_eq_sum
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.DirectSumEsa
open BookProof.DirectSumEdge

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}



open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section


theorem BookProof.DirectSumEdge.quadForm_dsOp_eq_sum (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) :
    quadForm (dsOp H) x
      = ∑ i ∈ supportFinset x,
          quadForm (H i) ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ := by sorry
