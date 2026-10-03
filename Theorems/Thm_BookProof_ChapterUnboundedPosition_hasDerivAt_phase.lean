-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.hasDerivAt_phase
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.hasDerivAt_phase (f : ℤ → ℝ) (k : ℤ) :
    HasDerivAt (fun t : ℝ => phase f t k) (Complex.I * f k) 0 := by sorry
