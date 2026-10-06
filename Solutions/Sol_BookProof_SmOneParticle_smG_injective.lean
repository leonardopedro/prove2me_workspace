-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.smG_injective
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective fun p : Fin 8 × Fin 3 => smG p.1 p.2 := by

  intro p q h
  have := smIdx.injective h
  simpa using this
