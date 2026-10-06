-- Generated from ChapterSmOneParticle.lean — theorem BookProof.SmOneParticle.unitary_row_sum_normSq
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

variable {V U : Matrix (Fin 3) (Fin 3) ℂ}

theorem BookProof.SmOneParticle.unitary_row_sum_normSq (hV : IsMixing V) (i : Fin 3) :
    ∑ j : Fin 3, ‖V i j‖ ^ 2 = 1 := by sorry
