-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxLevel_le_norm
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzMinMax_minmaxSet_bddBelow
import Theorems.Thm_BookProof_RitzMinMax_rayleighSup_le_norm
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (k : ℕ) (hne : (minmaxSet T k).Nonempty) :
    minmaxLevel T k ≤ ‖T‖ := by

  obtain ⟨t, S, hrank, rfl⟩ := hne
  exact (csInf_le (minmaxSet_bddBelow T k) ⟨S, hrank, rfl⟩).trans (rayleighSup_le_norm T S)
