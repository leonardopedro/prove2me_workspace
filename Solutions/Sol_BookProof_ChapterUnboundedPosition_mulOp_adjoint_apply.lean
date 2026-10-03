-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.mulOp_adjoint_apply
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_single_mem_mulDomain
import Theorems.Thm_BookProof_ChapterUnboundedPosition_mulOp_single
import Theorems.Thm_BookProof_ChapterUnboundedPosition_inner_single_left
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) {phi eta : L2Z}
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    (∀ k, (f k : ℂ) * (phi : ℤ → ℂ) k = (eta : ℤ → ℂ) k) ∧ phi ∈ mulDomain f := 
