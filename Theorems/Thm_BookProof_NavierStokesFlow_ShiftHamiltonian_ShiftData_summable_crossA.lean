-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.summable_crossA
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData

variable {ι : Type*} (S : ShiftData ι)


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.summable_crossA {X Y : ι → ℂ}
    (hX : Summable fun β => (S.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossA X Y) := by sorry
