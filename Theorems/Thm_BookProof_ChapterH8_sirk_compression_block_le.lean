-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_compression_block_le
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_compression_block_le {m n : ℕ} (hmn : m ≤ n) (X : E →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin m) →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (hnest : ∀ i : Fin m, Vm (EuclideanSpace.single i (1 : ℂ))
      = Vn (EuclideanSpace.single (Fin.castLE hmn i) (1 : ℂ)))
    (i j : Fin m) :
    reduceGenerator m Vm X i j
      = reduceGenerator n Vn X (Fin.castLE hmn i) (Fin.castLE hmn j) := by sorry
