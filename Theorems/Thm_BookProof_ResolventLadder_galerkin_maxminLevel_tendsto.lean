-- Generated from ChapterResolventMinMaxLadder.lean — theorem BookProof.ResolventLadder.galerkin_maxminLevel_tendsto
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.HermiteGalerkin
open BookProof.RitzMinMax
open BookProof.ResolventLadder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}


noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology


theorem BookProof.ResolventLadder.galerkin_maxminLevel_tendsto (R : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (k : ℕ) :
    Tendsto (fun m : ℕ => maxminLevelIn R (galerkinSpan b m) k) atTop
      (nhds (maxminLevel R k)) := by sorry
