-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.smG_ne_smDG
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) (i : Fin 3) (b : Fin 8) (k l : Fin 3) :
    smG a i ≠ smDG b k l := by

  intro h
  have := smIdx.injective h
  simp at this
