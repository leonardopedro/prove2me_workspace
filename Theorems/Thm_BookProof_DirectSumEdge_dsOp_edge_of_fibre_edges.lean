-- Generated from ChapterDirectSumEdge.lean — theorem BookProof.DirectSumEdge.dsOp_edge_of_fibre_edges
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


theorem BookProof.DirectSumEdge.dsOp_edge_of_fibre_edges (H : ∀ i, D i →ₗ[ℂ] G i) (nu : ℝ)
    (hedge : ∀ i (u : D i), nu * ‖(u : G i)‖ ^ 2 ≤ quadForm (H i) u) (x : dsCore D) :
    nu * ‖(x : lp G 2)‖ ^ 2 ≤ quadForm (dsOp H) x := by sorry
