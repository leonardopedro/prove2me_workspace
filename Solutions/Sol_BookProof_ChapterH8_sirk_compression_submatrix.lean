-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_compression_submatrix
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_sirk_compression_block
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (X : E →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin (n + 1)) →L[ℂ] E)
    (hnest : ∀ i : Fin n, Vn (EuclideanSpace.single i (1 : ℂ))
      = Vm (EuclideanSpace.single (Fin.castSucc i) (1 : ℂ))) :
    reduceGenerator n Vn X
      = (reduceGenerator (n + 1) Vm X).submatrix Fin.castSucc Fin.castSucc := by

  ext i j
  simpa using sirk_compression_block n X Vn Vm hnest i j
