-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxLevel_mono_form
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzMinMax_minmaxSet_bddBelow
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
theorem solution (T T' : F →L[ℂ] F) (k : ℕ)
    (hle : ∀ x : F, rayleighVal T x ≤ rayleighVal T' x)
    (hne : (minmaxSet T' k).Nonempty) :
    minmaxLevel T k ≤ minmaxLevel T' k := by

  refine le_csInf hne ?_
  rintro t ⟨S, hrank, rfl⟩
  have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
  have h1 : minmaxLevel T k ≤ rayleighSup T S :=
    csInf_le (minmaxSet_bddBelow T k) ⟨S, hrank, rfl⟩
  have h2 : rayleighSup T S ≤ rayleighSup T' S := by
    refine csSup_le (rayleighSetOn_nonempty T hpos) ?_
    rintro s ⟨x, hx, hx1, rfl⟩
    exact (hle x).trans (rayleighVal_le_rayleighSup T' hx hx1)
  linarith
