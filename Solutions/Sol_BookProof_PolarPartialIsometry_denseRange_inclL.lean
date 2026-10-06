-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.denseRange_inclL
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
open BookProof.PolarPartialIsometry




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))

set_option maxHeartbeats 1000000 in
theorem solution : DenseRange (inclL P) := by

  intro z
  have hz : (z : F) ∈ closure ((LinearMap.range P : Submodule ℂ F) : Set F) := by
    have hz2 : (z : F) ∈ (LinearMap.range P).topologicalClosure := z.2
    rwa [← SetLike.mem_coe, Submodule.topologicalClosure_coe] at hz2
  obtain ⟨u, hu, hlim⟩ := mem_closure_iff_seq_limit.1 hz
  refine mem_closure_iff_seq_limit.2 ⟨fun n => inclL P ⟨u n, hu n⟩, fun n => ⟨_, rfl⟩, ?_⟩
  rw [tendsto_subtype_rng]
  exact hlim
