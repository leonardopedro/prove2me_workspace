-- Generated from ChapterA1.lean — solution of BookProof.ChapterA.conjugation_avg_fixed
import Mathlib
import Definitions.Def_ChapterA1
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = x) (x : V) :
    θ ((2⁻¹ : ℂ) • (x + θ x)) = (2⁻¹ : ℂ) • (x + θ x) := by

  have key : θ (x + θ x) = x + θ x := by rw [map_add, hθ, add_comm]
  rw [θ.map_smulₛₗ, key]
  simp [map_ofNat]
