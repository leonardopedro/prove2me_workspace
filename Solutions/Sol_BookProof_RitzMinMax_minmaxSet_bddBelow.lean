-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.minmaxSet_bddBelow
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_neg_norm_le_rayleighSup
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (k : ℕ) : BddBelow (minmaxSet T k) := by

  refine ⟨-‖T‖, ?_⟩
  rintro t ⟨S, hrank, rfl⟩
  exact neg_norm_le_rayleighSup T (by rw [hrank]; omega)
