-- Generated from ChapterHilbertSumIntertwine.lean — theorem BookProof.ChapterHilbertSumIntertwine.linearIsometryEquiv_intertwine
import Mathlib
import Definitions.Def_ChapterHilbertSumIntertwine
open BookProof.ChapterHilbertSumIntertwine

variable {ι : Type*}
variable {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)] [∀ i, InnerProductSpace ℂ (G i)]
variable {ι : Type*} {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [CompleteSpace H]


open scoped InnerProductSpace








theorem BookProof.ChapterHilbertSumIntertwine.linearIsometryEquiv_intertwine {V : ∀ i, G i →ₗᵢ[ℂ] H} (hsum : IsHilbertSum ℂ G V)
    (A : H →L[ℂ] H) (B : ∀ i, G i →L[ℂ] G i) (hB : ∀ i u, ‖B i u‖ ≤ ‖u‖)
    (hcomm : ∀ i u, V i (B i u) = A (V i u)) (v : H) (i : ι) :
    hsum.linearIsometryEquiv (A v) i = B i (hsum.linearIsometryEquiv v i) := by sorry
