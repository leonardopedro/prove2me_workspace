-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.transported_position_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


theorem BookProof.ChapterUnitaryTransport.transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) := by sorry
