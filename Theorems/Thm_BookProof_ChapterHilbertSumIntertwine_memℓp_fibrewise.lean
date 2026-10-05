-- Generated from ChapterHilbertSumIntertwine.lean — theorem BookProof.ChapterHilbertSumIntertwine.memℓp_fibrewise
import Mathlib
import Definitions.Def_ChapterHilbertSumIntertwine
open BookProof.ChapterHilbertSumIntertwine

variable {ι : Type*}
variable {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)] [∀ i, InnerProductSpace ℂ (G i)]


open scoped InnerProductSpace




theorem BookProof.ChapterHilbertSumIntertwine.memℓp_fibrewise (B : ∀ i, G i →L[ℂ] G i) (hB : ∀ i u, ‖B i u‖ ≤ ‖u‖)
    (w : lp G 2) : Memℓp (fun i => B i (w i)) 2 := by sorry
