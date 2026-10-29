-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.galerkin_maxmin_gap_eventually_pos
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterVonNeumannCore
open BookProof.HermiteGalerkin


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.ResolventLadder.galerkin_maxmin_gap_eventually_pos (R : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    (hgap : maxminLevel R 1 < maxminLevel R 0) :
    ∀ᶠ m : ℕ in atTop, 0 < maxminLevelIn R (galerkinSpan b m) 0
      - maxminLevelIn R (galerkinSpan b m) 1 := by sorry
