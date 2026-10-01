-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.strichartz_esa_of_finiteSpeed
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.strichartz_esa_of_finiteSpeed {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (finiteSpeed : ∀ z : ℂ, z.im ≠ 0 → DeficiencyTrivialAt D H z) :
    EssentiallySelfAdjointOn D H := by sorry
