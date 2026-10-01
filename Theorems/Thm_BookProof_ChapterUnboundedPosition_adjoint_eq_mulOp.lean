-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.adjoint_eq_mulOp
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

i⟩, fun psi => mulOp_symmetric f psi ⟨phi, hphi⟩⟩

theorem BookProof.ChapterUnboundedPosition.adjoint_eq_mulOp (f : ℤ → ℝ) {phi eta : L2Z} (hphi : phi ∈ mulDomain f)
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(p := by sorry
