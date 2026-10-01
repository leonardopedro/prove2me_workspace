-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.PairShift.fst_sym
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift



open scoped ENNReal



open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : P.fst.sym = P.sym := rfl
