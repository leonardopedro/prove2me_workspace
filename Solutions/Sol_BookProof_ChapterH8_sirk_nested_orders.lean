-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_nested_orders
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_sirk_krylov_tower
import Theorems.Thm_BookProof_ChapterH8_sirk_band_contained
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {K E : Type*} [Field K] [AddCommG := fun n => ⟨sirk_krylov_tower H v n, sirk_band_contained C Dmin h nv hC hD hnv hh n⟩
