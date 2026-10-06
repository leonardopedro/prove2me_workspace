-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.smW_ne_smB
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

set_option maxHeartbeats 1000000 in
theorem solution (k i : Fin 3) (j : Fin 3) : smW k i ≠ smB j := by

  intro h
  have := smIdx.injective h
  simp at this
