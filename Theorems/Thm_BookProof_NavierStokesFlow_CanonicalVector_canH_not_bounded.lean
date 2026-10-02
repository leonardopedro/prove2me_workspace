-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.canH_not_bounded
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.CanonicalVector.canH_not_bounded (hA : A 0 0 ≠ 0) (C : ℝ) :
    ∃ x : lpFiniteModes Vel, ‖(x : L2I Vel)‖ = 1
      ∧ C < ‖((canH A c x : lpFiniteModes Vel) : L2I Vel)‖ := by sorry
