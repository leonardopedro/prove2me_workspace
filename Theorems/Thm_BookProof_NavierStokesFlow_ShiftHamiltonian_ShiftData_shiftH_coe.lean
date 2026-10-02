-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_coe
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData

variable {ι : Type*} (S : ShiftData ι)


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.shiftH_coe (x : maxDom S.sym) (β : ι) :
    ((shiftH S x : L2I ι) : ι → ℂ) β = S.hFun ((x : L2I ι) : ι → ℂ) β := by sorry
