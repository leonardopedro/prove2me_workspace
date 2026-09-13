-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.minmaxLevel_le_minmaxLevelIn
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_minmaxSet_bddBelow
import Theorems.Thm_BookProof_RitzMinMax_minmaxSetIn_subset
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ)
    (hne : (minmaxSetIn T W k).Nonempty) :
    minmaxLevel T k ≤ minmaxLevelIn T W k := csInf_le_csInf (minmaxSet_bddBelow T k) hne (minmaxSetIn_subset T W k)
