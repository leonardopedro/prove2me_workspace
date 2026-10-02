-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.lower_comm
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterGravityProjector
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterGravityProjector
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.CanonicalVector.lower_comm (i k : Fin 3) (β : Vel) : lower i (lower k β) = lower k (lower i β) := by sorry
