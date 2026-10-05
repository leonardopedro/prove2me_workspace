-- Generated from ChapterQgOuterFockFullFL.lean — solution of BookProof.QgOuterFockFullFL.qgOuterFock_esa_farisLavine_full
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgFLc_nonneg
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgSectorExt_symmetricOn
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgSectorExt_core
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgSectorExt_rel
import Theorems.Thm_BookProof_QgOuterFockFullFL_qgSectorExt_commForm_le
import Theorems.Thm_BookProof_QgOuterFockFL_qgOuterFock_esa_farisLavine
open BookProof.QgOuterFockFullFL




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open Filter Topology

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn qgOuterFriedDom
        (dsFibOp (fun n : ℕ => harmFried (n * 84)) qgSectorExt qgFLK qgSectorExt_rel) ∧
      ∀ x : qgOuterCore, ∃ h : (x : qgOuterFock) ∈ qgOuterFriedDom,
        dsFibOp (fun n : ℕ => harmFried (n * 84)) qgSectorExt qgFLK qgSectorExt_rel
            ⟨(x : qgOuterFock), h⟩ = qgOuterHam x :=
  qgOuterFock_esa_farisLavine qgSectorExt qgSectorExt_symmetricOn qgSectorExt_core
      qgFLK qgFLc qgFLc_nonneg qgSectorExt_rel qgSectorExt_commForm_le
