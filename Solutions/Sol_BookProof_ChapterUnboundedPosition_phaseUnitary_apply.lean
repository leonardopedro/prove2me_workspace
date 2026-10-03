-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.phaseUnitary_apply
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
theorem solution (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseUnitary f (s + t) psi = phaseUnitary f s (phaseUnitary f t psi) :=
  (s t : ℝ) (psi : L2Z) :
      phas
