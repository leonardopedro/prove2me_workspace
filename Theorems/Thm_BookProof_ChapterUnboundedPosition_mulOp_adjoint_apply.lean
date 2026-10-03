-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.mulOp_adjoint_apply
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.mulOp_adjoint_apply (f : ℤ → ℝ) {phi eta : L2Z}
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    (∀ k, (f k : ℂ) * (phi : ℤ → ℂ) k = (eta : ℤ → ℂ) k) ∧ phi ∈ mulDomain f := by sorry
