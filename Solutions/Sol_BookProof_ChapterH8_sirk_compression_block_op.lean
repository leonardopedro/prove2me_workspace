-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_compression_block_op
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
open ContinuousLinearMap in
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) :
    compress Vn X = (adjoint J).comp ((compress Vm X).comp J) := by

  subst hJ
  ext x
  simp [compress]
