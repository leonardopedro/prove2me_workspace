-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.numRange_compress_mono
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_numRange_compress_subset
import Theorems.Thm_BookProof_ChapterH9_compress_compress
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖) :
    numRange (compress Vn X) ⊆ numRange (compress Vm X) := by

  rw [compress_compress Vn Vm J X hJ]
  exact numRange_compress_subset J (compress Vm X) hJiso
