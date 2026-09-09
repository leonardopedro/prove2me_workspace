-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.exists_l2dHilbertBasisNat
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffHashimoto








open Filter Topology



open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 3 →₀ ℕ)) :
    Nonempty (HilbertBasis ℕ ℂ (L2d 3)) := by

  classical
  set b : HilbertBasis (Fin 3 →₀ ℕ) ℂ (L2d 3) := hermiteMvBasis (d := 3) with hb
  refine ⟨HilbertBasis.mk (v := fun n : ℕ => b (e n)) (b.orthonormal.comp _ e.injective) ?_⟩
  have hspan := b.dense_span
  have hrange : Set.range (fun n : ℕ => b (e n)) = Set.range (b : (Fin 3 →₀ ℕ) → L2d 3) := by
    rw [show (fun n : ℕ => b (e n)) = (b : (Fin 3 →₀ ℕ) → L2d 3) ∘ e from rfl, Set.range_comp,
      e.surjective.range_eq, Set.image_univ]
  rw [hrange]
  exact hspan.ge
