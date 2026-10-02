-- Generated from ChapterNavierStokesHashimoto.lean — solution of BookProof.NavierStokesFlow.NSHashimoto.exists_velHilbertBasis
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.NSHashimoto



open Filter Topology



open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ Vel) : Nonempty (HilbertBasis ℕ ℂ (L2I Vel)) := by

  classical
  let b : HilbertBasis Vel ℂ (L2I Vel) :=
    HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ (L2I Vel))
  refine ⟨HilbertBasis.mk (v := fun n : ℕ => b (e n)) (b.orthonormal.comp _ e.injective) ?_⟩
  have hspan := b.dense_span
  have hrange : Set.range (fun n : ℕ => b (e n)) = Set.range (b : Vel → L2I Vel) := by
    rw [show (fun n : ℕ => b (e n)) = (b : Vel → L2I Vel) ∘ e from rfl, Set.range_comp,
      e.surjective.range_eq, Set.image_univ]
  rw [hrange]
  exact hspan.ge
