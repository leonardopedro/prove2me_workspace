-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxLevel_le_minmaxLevelIn_add
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_minmaxSetIn_nonempty_congr
import Theorems.Thm_BookProof_RitzPerturbation_minmaxLevelIn_le_minmaxLevelIn_add
import Theorems.Thm_BookProof_RitzMinMax_minmaxLevel_le_minmaxLevelIn
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ)
    (hne : (minmaxSetIn T' W k).Nonempty) :
    minmaxLevel T k ≤ minmaxLevelIn T' W k + ‖T - T'‖ := by

  have h1 : minmaxLevel T k ≤ minmaxLevelIn T W k :=
    minmaxLevel_le_minmaxLevelIn T W k (minmaxSetIn_nonempty_congr T' T hne)
  have h2 := minmaxLevelIn_le_minmaxLevelIn_add T T' W k hne
  linarith
