-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_compression_block
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_compression_block (n : ℕ) (X : E →L[ℂ] E)
    (Vn : EuclideanSpace ℂ (Fin n) →L[ℂ] E)
    (Vm : EuclideanSpace ℂ (Fin (n + 1)) →L[ℂ] E)
    (hnest : ∀ i : Fin n, Vn (EuclideanSpace.single i (1 : ℂ))
      = Vm (EuclideanSpace.single (Fin.castSucc i) (1 : ℂ)))
    (i j : Fin n) :
    reduceGenerator n Vn X i j
      = reduceGenerator (n + 1) Vm X (Fin.castSucc i) (Fin.castSucc j) := by sorry
