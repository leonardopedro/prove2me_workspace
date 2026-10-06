-- Generated from ChapterDirectSumEdge.lean — solution of BookProof.DirectSumEdge.dsOp_edge_of_fibre_edges_le
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Theorems.Thm_BookProof_DirectSumEdge_dsOp_edge_of_fibre_edges
open BookProof.DirectSumEdge




open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

set_option maxHeartbeats 1000000 in
theorem solution (H : ∀ i, D i →ₗ[ℂ] G i) (nu : ℝ) (nus : ι → ℝ)
    (hle : ∀ i, nu ≤ nus i)
    (hedge : ∀ i (u : D i), nus i * ‖(u : G i)‖ ^ 2 ≤ quadForm (H i) u) (x : dsCore D) :
    nu * ‖(x : lp G 2)‖ ^ 2 ≤ quadForm (dsOp H) x := by

  refine dsOp_edge_of_fibre_edges H nu (fun i u => le_trans ?_ (hedge i u)) x
  exact mul_le_mul_of_nonneg_right (hle i) (sq_nonneg _)
