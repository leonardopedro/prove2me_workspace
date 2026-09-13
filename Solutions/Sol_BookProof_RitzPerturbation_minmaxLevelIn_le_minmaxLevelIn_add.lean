-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxLevelIn_le_minmaxLevelIn_add
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_rayleighSup_le_rayleighSup_add
import Theorems.Thm_BookProof_RitzMinMax_minmaxSetIn_bddBelow
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
    minmaxLevelIn T W k ≤ minmaxLevelIn T' W k + ‖T - T'‖ := by

  have key : minmaxLevelIn T W k - ‖T - T'‖ ≤ minmaxLevelIn T' W k := by
    refine le_csInf hne ?_
    rintro t ⟨S, hSW, hrank, rfl⟩
    have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
    have h1 : minmaxLevelIn T W k ≤ rayleighSup T S :=
      csInf_le (minmaxSetIn_bddBelow T W k) ⟨S, hSW, hrank, rfl⟩
    have h2 := rayleighSup_le_rayleighSup_add T T' hpos
    linarith
  linarith
