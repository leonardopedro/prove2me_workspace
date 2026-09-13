-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.rayleighSup_le_norm
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_rayleighVal_le_norm_of_unit
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (S : Submodule ℂ F) : rayleighSup T S ≤ ‖T‖ := by

  rcases Set.eq_empty_or_nonempty (rayleighSetOn T S) with h | h
  · rw [rayleighSup, h, Real.sSup_empty]
    exact norm_nonneg _
  · refine csSup_le h ?_
    rintro t ⟨x, -, hx1, rfl⟩
    exact rayleighVal_le_norm_of_unit T hx1
