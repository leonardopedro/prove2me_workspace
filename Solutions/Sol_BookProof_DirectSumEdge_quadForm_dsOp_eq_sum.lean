-- Generated from ChapterDirectSumEdge.lean — solution of BookProof.DirectSumEdge.quadForm_dsOp_eq_sum
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Theorems.Thm_BookProof_DirectSumEdge_inner_dsOp_eq_sum
open BookProof.DirectSumEdge




open BookProof.FarisLavine BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

set_option maxHeartbeats 1000000 in
theorem solution (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) :
    quadForm (dsOp H) x
      = ∑ i ∈ supportFinset x,
          quadForm (H i) ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ := by

  unfold quadForm
  rw [inner_dsOp_eq_sum H x, Complex.re_sum]
