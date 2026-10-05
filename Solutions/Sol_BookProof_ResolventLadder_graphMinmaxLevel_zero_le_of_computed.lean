-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphMinmaxLevel_zero_le_of_computed
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_graphMinmaxLevel_zero_eq
import Theorems.Thm_BookProof_ResolventLadder_maxminLevelIn_le_maxminLevel
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
theorem solution [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {W : Submodule ℂ F}
    (hne : (maxminSetIn (res hT) W 0).Nonempty)
    (hpos : 0 < maxminLevelIn (res hT) W 0) :
    graphMinmaxLevel T 0 ≤ 1 / maxminLevelIn (res hT) W 0 - 1 := by

  have hle := maxminLevelIn_le_maxminLevel (res hT) W 0 hne
  have hinv : 1 / maxminLevel (res hT) 0 ≤ 1 / maxminLevelIn (res hT) W 0 :=
    one_div_le_one_div_of_le hpos hle
  rw [graphMinmaxLevel_zero_eq hT hsv]
  linarith
