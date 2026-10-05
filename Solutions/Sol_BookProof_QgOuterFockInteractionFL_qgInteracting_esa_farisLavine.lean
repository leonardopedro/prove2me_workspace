-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.qgInteracting_esa_farisLavine
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_esa_farisLavine
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
theorem solution (lam : ℝ) :
    EssentiallySelfAdjointOn qgOuterFriedDom
        (dsFibOp (fun n : ℕ => harmFried (n * 84)) (qgIntFamily lam).secExt
          (qgIntFamily lam).flK (qgIntFamily lam).secExt_rel) ∧
      ∀ x : qgOuterCore, ∃ h : (x : qgOuterFock) ∈ qgOuterFriedDom,
        dsFibOp (fun n : ℕ => harmFried (n * 84)) (qgIntFamily lam).secExt
            (qgIntFamily lam).flK (qgIntFamily lam).secExt_rel
            ⟨(x : qgOuterFock), h⟩ = (qgIntFamily lam).outerHam x := (qgIntFamily lam).esa_farisLavine
