-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.exists_eigenvalue_of_isFunctionOfSpectrum
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterE4
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterE4
open BookProof.ChapterGaugeUnconstrainedSpectrum

variable {X : Type*}




theorem BookProof.ChapterGaugeUnconstrainedSpectrum.exists_eigenvalue_of_isFunctionOfSpectrum [DecidableEq X] {T : Op X}
    (hT : IsFunctionOfSpectrum T) (y : X) :
    ∃ c : ℂ, T (basisVec y) = c • basisVec y := by sorry
