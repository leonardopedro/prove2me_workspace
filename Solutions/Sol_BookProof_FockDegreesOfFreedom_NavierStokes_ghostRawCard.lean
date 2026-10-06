-- Generated from ChapterFockDegreesOfFreedom.lean — solution of BookProof.FockDegreesOfFreedom.NavierStokes.ghostRawCard
import Mathlib
import Definitions.Def_ChapterFockDegreesOfFreedom
open BookProof.FockDegreesOfFreedom
open BookProof.FockDegreesOfFreedom.NavierStokes




open Fintype

set_option maxHeartbeats 1000000 in
theorem solution : Fintype.card GhostRaw = 3 + 1 := by
 simp
