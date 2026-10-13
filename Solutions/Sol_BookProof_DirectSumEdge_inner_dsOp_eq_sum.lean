-- Generated from ChapterDirectSumEdge.lean — solution of BookProof.DirectSumEdge.inner_dsOp_eq_sum
import Mathlib
import Definitions.Def_ChapterDirectSumEdge
import Theorems.Thm_BookProof_DirectSumEdge_inner_dsCore_eq_sum
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
open BookProof.DirectSumEdge




open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] {D : ∀ i, Submodule ℂ (G i)}


@[simp] private theorem dsOp_coe (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) (i : ι) :
    ((dsOp H x : lp G 2) : ∀ i, G i) i = H i ⟨(x : lp G 2) i, x.2.2 i⟩ := rfl

set_option maxHeartbeats 1000000 in
theorem solution (H : ∀ i, D i →ₗ[ℂ] G i) (x : dsCore D) :
    (inner ℂ (x : lp G 2) (dsOp H x : lp G 2) : ℂ)
      = ∑ i ∈ supportFinset x,
          (inner ℂ (((x : lp G 2) : ∀ i, G i) i)
            (H i ⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩) : ℂ) := by

  rw [inner_dsCore_eq_sum x (dsOp H x : lp G 2)]
  exact Finset.sum_congr rfl fun i _ => by rw [dsOp_coe]
