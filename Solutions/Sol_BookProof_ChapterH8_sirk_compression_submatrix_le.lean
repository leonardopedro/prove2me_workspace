-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_compression_submatrix_le
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH8_sirk_compression_block_le
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin m) →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (hnest : ∀ i : Fin m, Vm (EuclideanSpace.single i (1 : ℂ))
      = Vn (EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ))) :
    reduceGenerator m Vm X
      = (reduceGenerator n Vn X).submatrix (Fin.castLE hmn) (Fin.castLE hmn) := by

  ext i j
  simpa using sirk_compression_block_le hmn X Vm Vn hnest i j
