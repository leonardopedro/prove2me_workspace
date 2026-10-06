-- Generated from ChapterDirectSumEdge.lean — theorem BookProof.DirectSumEdge.norm_sq_dsCore_eq_sum
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEsa
open BookProof.DirectSumEdge

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}



open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section


theorem BookProof.DirectSumEdge.norm_sq_dsCore_eq_sum (x : dsCore D) :
    ‖(x : lp G 2)‖ ^ 2 = ∑ i ∈ supportFinset x, ‖((x : lp G 2) : ∀ i, G i) i‖ ^ 2 := by sorry
