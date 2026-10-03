-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.phaseUnitary_apply
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.phaseUnitary_apply (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseUnitary f (s + t) psi = phaseUnitary f s (phaseUnitary f t psi) := by sorry
