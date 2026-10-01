-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.phaseUnitary_apply
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

eUnitary_zero (f : ℤ → ℝ) (psi : L2Z) : phaseUnitary f 0 psi = psi :=
  phaseLin_zero f psi

theorem BookProof.ChapterUnboundedPosition.phaseUnitary_apply (f : ℤ → ℝ) := by sorry
