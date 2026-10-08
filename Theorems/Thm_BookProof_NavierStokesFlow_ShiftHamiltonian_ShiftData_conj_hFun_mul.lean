-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.conj_hFun_mul
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.conj_hFun_mul (X Y : ι → ℂ) (β : ι) :
    (starRingEnd ℂ) (S.hFun X β) * Y β
      = -Complex.I * S.hop (S.crossA X Y) β + Complex.I * S.crossB X Y β := by sorry
