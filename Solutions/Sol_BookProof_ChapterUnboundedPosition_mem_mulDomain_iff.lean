-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.mem_mulDomain_iff
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (psi : L2Z) :
    psi ∈ mulDomain f ↔ Memℓp (fun k => (f k : ℂ) * (psi : ℤ → ℂ) k) 2 := Iff.rfl
