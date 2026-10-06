-- Generated from ChapterFockDegreesOfFreedom.lean — solution of BookProof.FockDegreesOfFreedom.NavierStokes.jetCard_firstOrder
import Mathlib
import Definitions.Def_ChapterFockDegreesOfFreedom
open BookProof.FockDegreesOfFreedom
open BookProof.FockDegreesOfFreedom.NavierStokes




open Fintype

set_option maxHeartbeats 1000000 in
theorem solution :
    Fintype.card (Fin 3 ⊕ Fin 3 ⊕ (Fin 3 × Fin 3)) = 15 := by
 simp
