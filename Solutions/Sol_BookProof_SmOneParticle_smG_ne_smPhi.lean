-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.smG_ne_smPhi
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) (i : Fin 3) (b : Fin 4) : smG a i ≠ smPhi b := by

  intro h
  have := smIdx.injective h
  simp at this
