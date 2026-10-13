-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFieldSum_symmetricOn
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_realCoeff_magPolyN
import Theorems.Thm_BookProof_YmFockFriedrichs_realCoeff_gaussPolyN
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ)
    (s : Fin (n * 24) ⊕ Fin (n * 8)) :
    SymmetricOn (polyGaussCore (d := n * 99))
      ((polyGaussCore (d := n * 99)).subtype.comp (ymFieldSum fabc n s)) := by

  rcases s with m₁ | m₂
  · exact (coreRepPoly (n * 99)).symmetricOn_op (mulOp_polySym (realCoeff_magPolyN _ _ _ _))
  · exact (coreRepPoly (n * 99)).symmetricOn_op (mulOp_polySym (realCoeff_gaussPolyN _ _))
