-- Generated from ChapterDirectSumEdge.lean — theorem BookProof.DirectSumEdge.mem_supportFinset
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


theorem BookProof.DirectSumEdge.mem_supportFinset {x : dsCore D} {i : ι} :
    i ∈ supportFinset x ↔ ((x : lp G 2) : ∀ i, G i) i ≠ 0 := by sorry
