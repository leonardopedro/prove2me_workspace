-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.torsionIdx1_ne_torsionIdx2
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QuantumGravity3DGauge_idxDE_injective
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
    torsionIdx1 m ≠ torsionIdx2 m := by

  intro h
  refine hm ?_
  have := idxDE_injective (a₁ := (torsionMu m, torsionNu m, torsionA m))
    (a₂ := (torsionNu m, torsionMu m, torsionA m)) h
  exact congrArg Prod.fst this
