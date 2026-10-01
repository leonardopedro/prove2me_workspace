-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.hasDerivAt_phase
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterNsLagrangianDetConvolution
open BookProof.NsLagrangianDet
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

dsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

theorem BookProof.ChapterUnboundedPosition.hasDerivAt_phase := by sorry
