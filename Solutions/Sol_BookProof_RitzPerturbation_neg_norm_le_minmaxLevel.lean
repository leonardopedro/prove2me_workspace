-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.neg_norm_le_minmaxLevel
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (k : ℕ) (hne : (minmaxSet T k).Nonempty) :
    -‖T‖ ≤ minmaxLevel T k := by

  refine le_csInf hne ?_
  rintro t ⟨S, hrank, rfl⟩
  exact neg_norm_le_rayleighSup T (by rw [hrank]; omega)
