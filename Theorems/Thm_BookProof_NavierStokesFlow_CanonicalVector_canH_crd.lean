-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.canH_crd
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.CanonicalVector.canH_crd (x : lpFiniteModes Vel) (γ : Vel) :
    crd (canH A c x) γ = canFun A c (crd x) γ := by sorry
