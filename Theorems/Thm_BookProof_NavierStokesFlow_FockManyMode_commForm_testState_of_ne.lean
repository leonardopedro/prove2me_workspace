-- Generated from ChapterNavierStokesFockManyMode.lean — theorem BookProof.NavierStokesFlow.FockManyMode.commForm_testState_of_ne
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.ShiftHamiltonian
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockManyMode

variable {d : ℕ} {κ : Fin d → ℝ}


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian



theorem BookProof.NavierStokesFlow.FockManyMode.commForm_testState_of_ne (hκ : ∀ i, 0 ≤ κ i) {i i₀ : Fin d} (hne : i ≠ i₀) :
    commForm (ShiftData.shiftH (modeData hκ i)) (diagMax (fockSym κ)) (testState κ i₀) = 0 := by sorry
