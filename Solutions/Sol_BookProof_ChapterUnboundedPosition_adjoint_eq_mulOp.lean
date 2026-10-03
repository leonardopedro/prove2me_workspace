-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.adjoint_eq_mulOp
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_mulOp_adjoint_apply
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) {phi eta : L2Z} (hphi : phi ∈ mulDomain f)
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    eta = mulOp f ⟨phi, hphi⟩ :=
  si : L2Z), eta⟫_ℂ) :
      eta = mulOp f ⟨phi, hphi⟩ := by
    refine lp.ext (funex
