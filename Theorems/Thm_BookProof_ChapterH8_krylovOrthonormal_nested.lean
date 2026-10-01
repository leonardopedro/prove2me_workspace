-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.krylovOrthonormal_nested
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

 in
theorem BookProof.ChapterH8.krylovOrthonormal_nested {H : E →ₗ[ℂ] E} {v : E} {m n : ℕ} (hmn : m ≤ n)
    (i : Fin m) :
    krylovOrthonormalSeq H v (i : ℕ)
      = krylovOrthonormalSeq H v ((Fin.castLE hmn i : Fin n) : ℕ) := rfl

omit [Complete := by sorry
