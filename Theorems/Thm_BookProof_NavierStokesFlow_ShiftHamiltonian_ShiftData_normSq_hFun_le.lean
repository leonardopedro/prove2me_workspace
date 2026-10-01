-- Generated from ChapterNavierStokesShiftHamiltonian.lean — theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.normSq_hFun_le
import Mathlib
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData

variable {ι : Type*} (S : ShiftData ι)


open scoped ENNReal



open LpNat FarisLavine IkebeKato

theorem BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData.normSq_hFun_le (X : ι → ℂ) (β : ι) :
    ‖S.hFun X β‖ ^ 2
      ≤ 2 * S.hop (fun α => (S.ampSeq X α) ^ 2) β + 2 * (S.ampSeq X (S.shift β)) ^ 2 := by sorry
