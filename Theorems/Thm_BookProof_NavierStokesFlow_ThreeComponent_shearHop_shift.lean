-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.shearHop_shift
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.ThreeComponent.shearHop_shift (i : Fin 3) : (shearHop A c i).shift = shShear i := by sorry
