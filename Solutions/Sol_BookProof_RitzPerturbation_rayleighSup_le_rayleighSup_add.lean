-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.rayleighSup_le_rayleighSup_add
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_rayleighVal_sub_le_dist
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_nonempty
import Theorems.Thm_BookProof_RitzMinMax_rayleighVal_le_rayleighSup
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) {S : Submodule ℂ F}
    (hS : 0 < Module.finrank ℂ S) :
    rayleighSup T S ≤ rayleighSup T' S + ‖T - T'‖ := by

  refine csSup_le (rayleighSetOn_nonempty T hS) ?_
  rintro t ⟨x, hx, hx1, rfl⟩
  have h1 : rayleighVal T' x ≤ rayleighSup T' S := rayleighVal_le_rayleighSup T' hx hx1
  have h2 := rayleighVal_sub_le_dist T T' hx1
  linarith
