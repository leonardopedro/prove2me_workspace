-- Generated from ChapterSmOneParticle.lean — theorem BookProof.SmOneParticle.yukawa_bound
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

theorem BookProof.SmOneParticle.yukawa_bound (hV : IsMixing V) (a b : Fin 3 → ℂ) :
    ‖∑ i : Fin 3, (starRingEnd ℂ) (a i) * (V *ᵥ b) i‖
      ≤ (∑ i : Fin 3, ‖a i‖) * ∑ j : Fin 3, ‖b j‖ := by sorry
