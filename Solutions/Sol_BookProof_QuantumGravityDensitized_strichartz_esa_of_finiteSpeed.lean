-- Generated from ChapterQuantumGravityDensitized.lean — solution of BookProof.QuantumGravityDensitized.strichartz_esa_of_finiteSpeed
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized




open Filter Topology BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (finiteSpeed : ∀ z : ℂ, z.im ≠ 0 → DeficiencyTrivialAt D H z) :
    EssentiallySelfAdjointOn D H := ⟨finiteSpeed Complex.I (by simp), finiteSpeed (-Complex.I) (by simp)⟩
