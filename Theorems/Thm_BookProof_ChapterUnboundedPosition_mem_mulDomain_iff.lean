-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.mem_mulDomain_iff
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.mem_mulDomain_iff (f : ℤ → ℝ) (psi : L2Z) :
    psi ∈ mulDomain f ↔ Memℓp (fun k => (f k : ℂ) * (psi : ℤ → ℂ) k) 2 := by sorry
