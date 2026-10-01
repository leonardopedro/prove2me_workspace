-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.velocityOp_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite


open scoped ENNReal InnerProductSpace

Complex.conj_ofReal]
  ring

theorem BookProof.ChapterContinuityUnitaryInfinite.velocityOp_isSelfAdjoint (v : LinfZ) : IsSelfAdjoint (velocityOp v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)

/-! ## The Weyl-symmetrized continuity generator := by sorry
