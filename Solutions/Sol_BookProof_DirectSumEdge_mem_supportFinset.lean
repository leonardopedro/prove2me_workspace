-- Generated from ChapterDirectSumEdge.lean — solution of BookProof.DirectSumEdge.mem_supportFinset
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
open BookProof.DirectSumEdge




open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

set_option maxHeartbeats 1000000 in
theorem solution {x : dsCore D} {i : ι} :
    i ∈ supportFinset x ↔ ((x : lp G 2) : ∀ i, G i) i ≠ 0 := x.2.1.mem_toFinset
