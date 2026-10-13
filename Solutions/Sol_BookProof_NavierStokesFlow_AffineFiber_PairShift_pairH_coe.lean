-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.PairShift.pairH_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_PairShift_pairH_apply
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesShiftHamiltonian
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber.PairShift



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian
open BookProof.NavierStokesFlow.ShiftHamiltonian.ShiftData
open BookProof.NavierStokesFlow.AffineFiber

variable {ι : Type*}

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)

set_option maxHeartbeats 1000000 in
theorem solution (x : maxDom P.sym) (β : ι) :
    ((pairH P x : L2I ι) : ι → ℂ) β
      = P.fst.hFun ((x : L2I ι) : ι → ℂ) β + P.snd.hFun ((x : L2I ι) : ι → ℂ) β := by

  rw [pairH_apply, lp.coeFn_add]
  rfl
