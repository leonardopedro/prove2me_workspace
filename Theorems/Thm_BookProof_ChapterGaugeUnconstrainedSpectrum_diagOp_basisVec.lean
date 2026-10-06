-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.diagOp_basisVec
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterE4
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterE4
open BookProof.ChapterGaugeUnconstrainedSpectrum

variable {X : Type*}




theorem BookProof.ChapterGaugeUnconstrainedSpectrum.diagOp_basisVec [DecidableEq X] (d : X → ℂ) (y : X) :
    diagOp d (basisVec y) = d y • basisVec y := by sorry
