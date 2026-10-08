-- Generated from ChapterDirectSumEdge.lean — theorem BookProof.DirectSumEdge.inner_dsOp_eq_sum
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa
open BookProof.DirectSumEdge



open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}


theorem BookProof.DirectSumEdge.inner_dsOp_eq_sum (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) :
    (inner ℂ (x : lp G 2) (dsOp H x : lp G 2) : ℂ)
      = ∑ i ∈ supportFinset x,
          (inner ℂ (((x : lp G 2) : ∀ i, G i) i)
            (H i ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩) : ℂ) := by sorry
