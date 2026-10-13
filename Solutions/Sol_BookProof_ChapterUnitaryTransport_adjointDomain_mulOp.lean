-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.adjointDomain_mulOp
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in

theorem solution (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl
