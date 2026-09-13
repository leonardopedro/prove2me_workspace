-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.minmaxLevel_mono
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_rayleighSup_mono
import Theorems.Thm_BookProof_RitzMinMax_minmaxSet_bddBelow
import Theorems.Thm_BookProof_RitzMinMax_exists_le_finrank_eq
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) {k l : ℕ} (hkl : k ≤ l)
    (hne : (minmaxSet T l).Nonempty) : minmaxLevel T k ≤ minmaxLevel T l := by

  refine le_csInf hne ?_
  rintro t ⟨S, hrank, rfl⟩
  have hfd : FiniteDimensional ℂ S := .of_finrank_pos (by rw [hrank]; omega)
  obtain ⟨S₀, hS₀le, hS₀rank⟩ :=
    exists_le_finrank_eq (S := S) (n := k + 1) (by rw [hrank]; omega)
  have hlow : minmaxLevel T k ≤ rayleighSup T S₀ :=
    csInf_le (minmaxSet_bddBelow T k) ⟨S₀, hS₀rank, rfl⟩
  exact hlow.trans (rayleighSup_mono T hS₀le (by rw [hS₀rank]; omega))
