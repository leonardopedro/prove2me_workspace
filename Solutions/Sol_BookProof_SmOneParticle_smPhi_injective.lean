-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.smPhi_injective
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective smPhi := by

  intro a b h
  have := smIdx.injective h
  simpa using this
