-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.commDom_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift





open FullEsa

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ} (c : ComparisonData F d)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}

set_option maxHeartbeats 1000000 in
_apply (A B : D →ₗ[ℂ] D) (v : D) :
    commDom A B v = A (B v) - B (A v) := rfl

theorem solution (A B : D →ₗ[ℂ] D) :
    commDom A (B + LinearMap.id) = commDom A B := by
  ext v
  simp [commDom]

/-- **The commutator of second-quantized operators is the second quantization of
the commutators**: if operators belonging to differe :=
  nt particles commute, then
  `[∑ₖ hₖ, ∑ₗ nₗ] = ∑ₖ [hₖ, nₖ]`. -/
  theorem commDom_sum (s : Finset κ) (h n : κ → (D →ₗ[ℂ] D))
      (hcomm : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → (h k).comp (n l) = (n l).comp (h k)) :
      commDom (∑ k ∈ s, h k) (∑ k ∈ s, n k) = ∑ k ∈ s, commDom (h k) (n k) := by
    ext v
    have hexp : (commDom (∑ k ∈ s, h k) (∑ k ∈ s, n k)) v
        = ∑ k ∈ s, ∑ l ∈ s, (h k (n l v) - n l (h k v)) := by
      simp only [commDom, LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.sum_apply, map_sum,
        Finset.sum_sub_distrib]
      congr 1
      exact Finset.sum_comm
    rw [hexp]
    have hdiag : ∀ k ∈ s, ∑ l ∈ s, (h k (n l v) - n l (h k v)) = commDom (h k) (n k) v := by
