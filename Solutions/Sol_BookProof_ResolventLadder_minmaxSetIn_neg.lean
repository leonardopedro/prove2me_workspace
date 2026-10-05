-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.minmaxSetIn_neg
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_rayleighSup_neg
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ) :
    minmaxSetIn (-R) W k = -maxminSetIn R W k := by

  ext t
  rw [Set.mem_neg]
  constructor
  · rintro ⟨S, hle, hrank, rfl⟩
    exact ⟨S, hle, hrank, by rw [rayleighSup_neg, neg_neg]⟩
  · rintro ⟨S, hle, hrank, hval⟩
    exact ⟨S, hle, hrank, by rw [rayleighSup_neg, ← hval, neg_neg]⟩
