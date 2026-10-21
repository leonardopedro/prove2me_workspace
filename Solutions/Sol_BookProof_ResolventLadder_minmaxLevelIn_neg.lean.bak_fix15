-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.minmaxLevelIn_neg
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_minmaxSetIn_neg
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
theorem solution (R : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ) :
    minmaxLevelIn (-R) W k = -maxminLevelIn R W k := by

  rw [minmaxLevelIn, minmaxSetIn_neg, Real.sInf_neg, maxminLevelIn]
