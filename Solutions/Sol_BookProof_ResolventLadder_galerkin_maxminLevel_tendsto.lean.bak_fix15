-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.galerkin_maxminLevel_tendsto
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_minmaxLevel_neg
import Theorems.Thm_BookProof_ResolventLadder_minmaxLevelIn_neg
import Theorems.Thm_BookProof_RitzMinMax_galerkin_minmaxLevel_tendsto
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (k : ℕ) :
    Tendsto (fun m : ℕ => maxminLevelIn R (galerkinSpan b m) k) atTop
      (nhds (maxminLevel R k)) := by

  have h := galerkin_minmaxLevel_tendsto (-R) b k
  simp only [minmaxLevel_neg, minmaxLevelIn_neg] at h
  simpa using h.neg
