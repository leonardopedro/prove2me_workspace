-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFullOuterN_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_nsFried_op_core
import Theorems.Thm_BookProof_NsFullEuler_nsOuterN_apply
import Theorems.Thm_BookProof_NsFullEuler_nsFockCore_le_friedDom
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) :
    IsPositiveSelfAdjointExtension (nsFullFockHam nu lam mu gg)
      (nsOuterComparison nu lam mu gg).op :=
  (nsOuterComparison nu lam mu gg).isPositiveSelfAdjointExtension
      (nsFullFockHam nu lam mu gg) (fun x => by
        refine ⟨nsFockCore_le_friedDom nu lam mu gg x.2, ?_⟩
        refine lp.ext (funext fun n => ?_)
        erw [nsOuterN_apply, nsFried_op_core nu lam mu gg n ⟨(x : nsFockSpace) n, x.2.2 n⟩]
        exact rfl)
