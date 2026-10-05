-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ycoord_injective
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) : Function.Injective (ycoord p) := by

  intro i i' h
  have := finProdFinEquiv.injective h
  simpa using congrArg Prod.snd this
