-- Generated from ChapterGraphCoreTransfer.lean — solution of BookProof.GraphCore.IsGraphCore.refl
import Mathlib
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore




open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D₂ : Submodule ℂ F} (T : D₂ →ₗ[ℂ] F) : IsGraphCore D₂ T := fun x ε hε => ⟨x, x.2, by simpa using hε, by simpa using hε⟩
