-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsRedFullOuterN_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_redFried_op_core
import Theorems.Thm_BookProof_NsFullEuler_nsRedOuterN_apply
import Theorems.Thm_BookProof_NsFullEuler_nsRedFockCore_le_friedDom
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    IsPositiveSelfAdjointExtension (nsRedFullFockHam nu k) (nsRedOuterComparison nu k).op :=
  (nsRedOuterComparison nu k).isPositiveSelfAdjointExtension (nsRedFullFockHam nu k)
      (fun x => by
        refine ⟨nsRedFockCore_le_friedDom nu k x.2, ?_⟩
        refine lp.ext (funext fun n => ?_)
        erw [nsRedOuterN_apply, redFried_op_core nu k n ⟨(x : nsRedFockSpace) n, x.2.2 n⟩]
        exact rfl)
