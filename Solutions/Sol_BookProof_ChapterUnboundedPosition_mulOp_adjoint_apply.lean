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
  → ℂ) k = (eta : ℤ → ℂ) k) ∧ phi ∈ mulDomain f := by
    have hpt : ∀ k, (f k : ℂ) * (phi : ℤ → ℂ) k = (eta : ℤ → ℂ) k := by
      intro k
      have hk := h ⟨lp.single 2 k (1 : ℂ), single_mem_mulDomain f k 1⟩
      rw [mulOp_single f k (1 : ℂ), inner_single_left, inner_single_left] at hk
      simpa [Complex.conj_ofReal] using hk
    refine ⟨hpt, ?_⟩
    change Memℓp _ 2
    have hfun : (fun k => (f k : ℂ) * (phi : ℤ → ℂ) k) = (eta :
