-- Generated from ChapterH8Bases.lean — solution of BookProof.ChapterH8.krylovOrthonormal_span
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

set_option maxHeartbeats 1000000 in
 in
theorem solution (H : E →ₗ[ℂ] E) (v : E) (n : ℕ) :
    Submodule.span ℂ (Set.range (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ)))
      = krylovSpan H v n := by
  have hrange : :=
  (Set.range (fun i : Fin n => krylovOrthonormalSeq H v (i : ℕ)))
        = krylovOrthonormalSeq H v '' Set.Iio n := by
      ext x
      constructor
      · rintro ⟨i, rfl⟩
        exact ⟨i, i.2, rfl⟩
      · rintro ⟨i, hi, rfl⟩
        exact ⟨⟨i, hi⟩, rfl⟩
    rw [hrange, krylovOrthonormalSeq, span_gramSchmidtNormed, span_gramSchmidt_Iio, krylovSpan]
    congr 1
    ext x
    constructor
    · rintro ⟨i, hi, rfl⟩
      exact ⟨i, hi, rfl⟩
    · rintro ⟨i, hi, rfl⟩
      exact ⟨i, hi, rfl⟩
  
  /-- The order-`n` **
