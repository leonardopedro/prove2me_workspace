-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.conj_mul_hFun
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

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.conj_mul_hFun (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (X β) * S.hFun Y β
      = -Complex.I * S.crossA X Y β + Complex.I * S.hop (S.crossB X Y) β := by sorry
