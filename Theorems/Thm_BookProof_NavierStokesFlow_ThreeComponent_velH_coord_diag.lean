-- Generated from ChapterNavierStokesThreeComponent.lean — theorem BookProof.NavierStokesFlow.ThreeComponent.velH_coord_diag
import Mathlib
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesSignedShift
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift.SignedHop
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ThreeComponent


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

theorem BookProof.NavierStokesFlow.ThreeComponent.velH_coord_diag :
    ((velH A c (velState A c ![0, 0, 0]) : L2I Vel) : Vel → ℂ) ![2, 0, 0]
      = Complex.I * ((A 0 0 * Real.sqrt 2 / 2 : ℝ) : ℂ) := by sorry
