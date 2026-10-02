-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.krylovOrthonormal_nested
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
 in
theorem solution {H : E →ₗ[ℂ] E} {v : E} {m n : ℕ} (hmn : m ≤ n)
    (i : Fin m) :
    krylovOrthonormalSeq H v (i : ℕ)
      = krylovOrthonormalSeq H v ((Fin.castLE hmn i : Fin n) : ℕ) := rfl

omit [Complete := Space
