-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.torsionVec_self
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_torsionIdx1_ne_torsionIdx2
open BookProof.QgOuterFockInteractionFL




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

variable (F : QgFamily)

set_option maxHeartbeats 1000000 in
theorem solution {m : Fin 64} (hm : torsionMu m ≠ torsionNu m) :
    torsionVec m (torsionIdx1 m) = 1 := by

  rw [torsionVec, if_pos rfl, if_neg (torsionIdx1_ne_torsionIdx2 hm)]
  norm_num
