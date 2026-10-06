-- Generated from ChapterSmOneParticle.lean — theorem BookProof.SmOneParticle.norm_mulVec_le_sum
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

theorem BookProof.SmOneParticle.norm_mulVec_le_sum (hV : IsMixing V) (b : Fin 3 → ℂ) (i : Fin 3) :
    ‖(V *ᵥ b) i‖ ≤ ∑ j : Fin 3, ‖b j‖ := by sorry
