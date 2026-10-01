-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.PairShift.pairH_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom P.sym) :
    (pairH P x : L2I ι) = (ShiftData.shiftH P.fst x : L2I ι)
      + (ShiftData.shiftH P.snd x : L2I ι) := rfl
