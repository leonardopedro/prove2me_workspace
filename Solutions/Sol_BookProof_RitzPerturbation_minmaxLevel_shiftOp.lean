-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxLevel_shiftOp
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_minmaxSet_nonempty_congr
import Theorems.Thm_BookProof_RitzPerturbation_rayleighSup_shiftOp
import Theorems.Thm_BookProof_RitzMinMax_minmaxSet_bddBelow
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (c : ℝ) (k : ℕ)
    (hne : (minmaxSet T k).Nonempty) :
    minmaxLevel (shiftOp T c) k = minmaxLevel T k + c := by

  have hne' : (minmaxSet (shiftOp T c) k).Nonempty := minmaxSet_nonempty_congr T _ hne
  refine le_antisymm ?_ ?_
  · have key : minmaxLevel (shiftOp T c) k - c ≤ minmaxLevel T k := by
      refine le_csInf hne ?_
      rintro t ⟨S, hrank, rfl⟩
      have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
      have h : minmaxLevel (shiftOp T c) k ≤ rayleighSup (shiftOp T c) S :=
        csInf_le (minmaxSet_bddBelow (shiftOp T c) k) ⟨S, hrank, rfl⟩
      rw [rayleighSup_shiftOp T c hpos] at h
      linarith
    linarith
  · have key : minmaxLevel T k + c ≤ minmaxLevel (shiftOp T c) k := by
      refine le_csInf hne' ?_
      rintro t ⟨S, hrank, rfl⟩
      have hpos : 0 < Module.finrank ℂ S := by rw [hrank]; omega
      have h : minmaxLevel T k ≤ rayleighSup T S :=
        csInf_le (minmaxSet_bddBelow T k) ⟨S, hrank, rfl⟩
      rw [rayleighSup_shiftOp T c hpos]
      linarith
    linarith
