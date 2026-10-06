-- Generated from ChapterDirectSumEdge.lean — solution of BookProof.DirectSumEdge.dsOp_edge_pos
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Theorems.Thm_BookProof_DirectSumEdge_dsOp_edge_of_fibre_edges_le
open BookProof.DirectSumEdge




open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

set_option maxHeartbeats 1000000 in
theorem solution (H : ∀ i, D i →ₗ[ℂ] G i) {nu : ℝ} (hnu : 0 < nu) (nus : ι → ℝ)
    (hle : ∀ i, nu ≤ nus i)
    (hedge : ∀ i (u : D i), nus i * ‖(u : G i)‖ ^ 2 ≤ quadForm (H i) u) (x : dsCore D)
    (hx : (x : lp G 2) ≠ 0) :
    0 < quadForm (dsOp H) x :=
  lt_of_lt_of_le
      (mul_pos hnu (pow_pos (norm_pos_iff.mpr hx) 2))
      (dsOp_edge_of_fibre_edges_le H nu nus hle hedge x)
