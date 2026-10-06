-- Generated from ChapterSmOneParticle.lean — solution of BookProof.SmOneParticle.smDimB_eq_card
import Mathlib
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmOneParticle

set_option maxHeartbeats 1000000 in
theorem solution : smDimB = Fintype.card SmCoord := card_smCoord.symm
