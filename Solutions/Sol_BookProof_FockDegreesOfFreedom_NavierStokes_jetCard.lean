-- Generated from ChapterFockDegreesOfFreedom.lean — solution of BookProof.FockDegreesOfFreedom.NavierStokes.jetCard
import Mathlib
import Definitions.Def_ChapterFockDegreesOfFreedom
import Theorems.Thm_BookProof_FockDegreesOfFreedom_NavierStokes_card_symPair
open BookProof.FockDegreesOfFreedom
open BookProof.FockDegreesOfFreedom.NavierStokes




open Fintype

set_option maxHeartbeats 1000000 in
theorem solution : Fintype.card Jet = 33 := by

  simp [card_symPair]
