-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.hasSum_inner_shiftH_left
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.NavierStokesFlow.HermiteFarisLavine
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData

variable {ι : Type*} (S : ShiftData ι)


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.hasSum_inner_shiftH_left (x : maxDom S.sym) (y : L2I ι) :
    HasSum (fun β => -Complex.I * S.crossA ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β
        + Complex.I * S.crossB ((x : L2I ι) : ι → ℂ) ((y : ι → ℂ)) β)
      (inner ℂ (shiftH S x : L2I ι) y) := by sorry
