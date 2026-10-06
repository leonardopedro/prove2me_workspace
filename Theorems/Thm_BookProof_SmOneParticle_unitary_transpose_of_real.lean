-- Generated from ChapterSmOneParticle.lean — theorem BookProof.SmOneParticle.unitary_transpose_of_real
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

theorem BookProof.SmOneParticle.unitary_transpose_of_real (hV : IsMixing V) (hreal : ∀ i j, (V i j).im = 0) :
    V * Vᵀ = 1 := by sorry
