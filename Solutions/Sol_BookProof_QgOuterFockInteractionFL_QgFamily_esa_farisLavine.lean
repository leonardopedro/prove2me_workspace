-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.QgFamily.esa_farisLavine
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_flc_nonneg
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_secExt_symmetricOn
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_secExt_core
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_secExt_rel
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_QgFamily_secExt_commForm_le
import Theorems.Thm_BookProof_QgOuterFockFL_dsFibOp_essentiallySelfAdjointOn
import Theorems.Thm_BookProof_QgOuterFockFL_dsFibOp_fib
import Theorems.Thm_BookProof_QgOuterFockFL_polyGaussCore_le_harmFriedDom
import Theorems.Thm_BookProof_QgOuterFockFL_qgOuterCore_le_friedDom
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
theorem solution :
    EssentiallySelfAdjointOn qgOuterFriedDom
        (dsFibOp (fun n : ℕ => harmFried (n * 84)) F.secExt F.flK F.secExt_rel) ∧
      ∀ x : qgOuterCore, ∃ h : (x : qgOuterFock) ∈ qgOuterFriedDom,
        dsFibOp (fun n : ℕ => harmFried (n * 84)) F.secExt F.flK F.secExt_rel
            ⟨(x : qgOuterFock), h⟩ = F.outerHam x := by

  refine ⟨dsFibOp_essentiallySelfAdjointOn F.flc_nonneg F.secExt_rel F.secExt_symmetricOn
    F.secExt_commForm_le, fun x => ?_⟩
  refine ⟨qgOuterCore_le_friedDom x.2, ?_⟩
  refine lp.ext (funext fun n => ?_)
  have hfib : ((dsFibOp (fun n : ℕ => harmFried (n * 84)) F.secExt F.flK F.secExt_rel
        ⟨(x : qgOuterFock), qgOuterCore_le_friedDom x.2⟩ : qgOuterFock)
      : ∀ n : ℕ, L2d (n * 84)) n
      = F.secExt n ⟨((x : qgOuterFock) : ∀ n : ℕ, L2d (n * 84)) n,
          polyGaussCore_le_harmFriedDom (n * 84) (x.2.2 n)⟩ :=
    dsFibOp_fib F.secExt_rel _ n
  rw [hfib, F.secExt_core n ⟨(x : qgOuterFock) n, x.2.2 n⟩]
  exact (dsOp_coe (fun n : ℕ => F.secHam n) x n).symm
