-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.permOp_basisVec
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterE4
open BookProof.ChapterE4
open BookProof.ChapterGaugeUnconstrainedSpectrum

variable {X : Type*}




theorem BookProof.ChapterGaugeUnconstrainedSpectrum.permOp_basisVec [DecidableEq X] (σ : Equiv.Perm X) (y : X) :
    permOp σ (basisVec y) = basisVec (σ y) := by sorry
