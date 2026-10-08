-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.constrainedSpectrum_eq_univ_of_isUnconstrained
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterGaugeUnconstrainedSpectrum



variable {X : Type*}

variable {G : Type*} [Group G]

theorem BookProof.ChapterGaugeUnconstrainedSpectrum.constrainedSpectrum_eq_univ_of_isUnconstrained {U : G → Op X}
    (hU : IsUnconstrainedGaugeFixing U) (hU1 : U 1 = LinearMap.id) :
    constrainedSpectrum U = Set.univ := by sorry
