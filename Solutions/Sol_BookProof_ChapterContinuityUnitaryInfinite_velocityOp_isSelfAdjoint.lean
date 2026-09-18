-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.velocityOp_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
theorem solution (v : LinfZ) : IsSelfAdjoint (velocityOp v) := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)
