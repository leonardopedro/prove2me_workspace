-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.maxminLevelIn_le_maxminLevel
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_minmaxLevel_neg
import Theorems.Thm_BookProof_ResolventLadder_minmaxSetIn_neg
import Theorems.Thm_BookProof_ResolventLadder_minmaxLevelIn_neg
import Theorems.Thm_BookProof_RitzMinMax_minmaxLevel_le_minmaxLevelIn
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterSirkRitzMinMax
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology
open BookProof.RitzMinMax

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ)
    (hne : (maxminSetIn R W k).Nonempty) : maxminLevelIn R W k ≤ maxminLevel R k := by

  have hne' : (minmaxSetIn (-R) W k).Nonempty := by
    rw [minmaxSetIn_neg]
    obtain ⟨t, ht⟩ := hne
    exact ⟨-t, by rwa [Set.mem_neg, neg_neg]⟩
  have h := minmaxLevel_le_minmaxLevelIn (-R) W k hne'
  rw [minmaxLevel_neg, minmaxLevelIn_neg] at h
  linarith
