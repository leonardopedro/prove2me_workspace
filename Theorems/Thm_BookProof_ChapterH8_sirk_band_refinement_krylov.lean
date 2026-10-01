-- Generated from ChapterH8Bases.lean — theorem BookProof.ChapterH8.sirk_band_refinement_krylov
import Mathlib
import Definitions.Def_ChapterH8Bases
open BookProof.ChapterH8

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

open ContinuousLinearMap

ov flag itself.**  For orders `m ≤ n` at which the Krylov
sequence has not broken down, and a generator `X` leaving both Krylov ranges
invariant, the order-`n` SIRK approximant of `p(X) u` agrees with the order-`m`
one on the order-`m` data: the approximations really do nest, with the bases the
method builds. -/
theorem BookProof.ChapterH8.sirk_band_refinement_krylov {m n : ℕ} (hmn : m ≤ n) (H : E →ₗ[ℂ] E) (v : E)
    (X : E →L[ℂ] E) (hli : LinearIndependent ℂ (fun i : Fin n => (H ^ (i : ℕ)) v))
    (hinvm : ∀ x : EuclideanSpace ℂ (Fin m), ∃ y : EuclideanSpace ℂ (Fin m),
      X (krylovEmbedding H v (krylov_li_of_le hmn hli) x)
        = krylovEmbedding H v (krylov_li_of_le hmn hli) y)
    (hinvn : ∀ x : EuclideanSpace ℂ (Fin n), ∃ y : EuclideanSpace ℂ (Fin n),
      X (krylovEmbedding H v hli x) = krylovEmbedding H v hli y)
    (p : Polynomial ℂ) (u : E)
    (hu : krylovEmbedding H v (krylov_li_of_le hmn hli)
      ((adjoint (krylovEmbedding H v (krylov_li_of_le hmn hli))) u) = u) :
    krylovEmbedding H v hli
        ((Polynomial.aeval (compress (krylovEmbedding H v hli) X) p)
          ((adjoint (krylovEmbedding H v hli)) u))
      = krylovEmbedding H v (krylov_li_of_le hmn hli)
        ((Polynomial.aeval (compress (krylovEmbedding H v (krylov_li_of_le hmn hli)) X) p)
          ((adjoint (krylovEmbedding H v (krylov_li_of_le hmn hli))) u)) :=
  sirk_band_refinem := by sorry
