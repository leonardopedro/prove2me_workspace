-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.testState_coe_zero
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian



theorem BookProof.NavierStokesFlow.FockManyMode.testState_coe_zero (i₀ : Fin d) :
    ((testState κ i₀ : L2I (Occ d)) : Occ d → ℂ) 0 = 1 := by sorry
