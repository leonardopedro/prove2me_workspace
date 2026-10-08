-- Generated from ChapterDirectSumEdge.lean — theorem BookProof.DirectSumEdge.inner_dsCore_eq_sum
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


theorem BookProof.DirectSumEdge.inner_dsCore_eq_sum (x : dsCore D) (g : lp G 2) :
    (inner ℂ (x : lp G 2) g : ℂ)
      = ∑ i ∈ supportFinset x,
          (inner ℂ (((x : lp G 2) : ∀ i, G i) i) ((g : ∀ i, G i) i) : ℂ) := by sorry
