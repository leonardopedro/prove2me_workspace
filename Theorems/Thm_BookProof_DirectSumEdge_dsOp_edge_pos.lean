-- Generated from ChapterDirectSumEdge.lean — theorem BookProof.DirectSumEdge.dsOp_edge_pos
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
open BookProof.DirectSumEsa
open BookProof.DirectSumEdge



open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}


theorem BookProof.DirectSumEdge.dsOp_edge_pos (H : ∀ i, D i →ₗ[ℂ] G i) {nu : ℝ} (hnu : 0 < nu) (nus : ι → ℝ)
    (hle : ∀ i, nu ≤ nus i)
    (hedge : ∀ i (u : D i), nus i * ‖(u : G i)‖ ^ 2 ≤ quadForm (H i) u) (x : dsCore D)
    (hx : (x : lp G 2) ≠ 0) :
    0 < quadForm (dsOp H) x := by sorry
