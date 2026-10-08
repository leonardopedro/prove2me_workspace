-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.hop_mul
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*} (S : ShiftData ι)

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.hop_mul (g : ι → ℂ) (Y : ι → ℂ) (β : ι) :
    S.hop g β * Y β = S.hop (fun α => g α * Y (S.shift α)) β := by sorry
