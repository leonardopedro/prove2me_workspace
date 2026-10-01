-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.adjointDomain_eq_mulDomain
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Theorems.Thm_BookProof_ChapterUnboundedPosition_mulOp_symmetric
import Theorems.Thm_BookProof_ChapterUnboundedPosition_mulOp_adjoint_apply
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
 ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ}

theorem solution (f : ℤ → ℝ) :
    adjoi :=
  ntDomain f = ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by
    ext phi
    constructor
    · rintro ⟨eta, h⟩
      exact (mulOp_adjoint_apply f h).2
    · intro hphi
      exact ⟨mulOp f ⟨phi, h
