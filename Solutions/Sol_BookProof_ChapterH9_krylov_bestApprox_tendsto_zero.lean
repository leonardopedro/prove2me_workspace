-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.krylov_bestApprox_tendsto_zero
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_norm_sub_starProjection_le
import Theorems.Thm_BookProof_ChapterH5_krylovSpan_mono
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
 := 
