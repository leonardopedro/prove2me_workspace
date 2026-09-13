-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.minmaxSet_nonempty
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_minmaxSetIn_subset
import Theorems.Thm_BookProof_RitzMinMax_minmaxSetIn_galerkin_nonempty
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) (k : ℕ) :
    (minmaxSet T k).Nonempty := (minmaxSetIn_galerkin_nonempty T b (le_refl (k + 1))).mono (minmaxSetIn_subset T _ k)
