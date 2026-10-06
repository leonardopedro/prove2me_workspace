-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.SqFamily.esa_farisLavine
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_SqSumOuterFamily_outerCore_le_friedDom
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_flc_nonneg
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secExt_symmetricOn
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secExt_core
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secExt_rel
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secExt_commForm_le
import Theorems.Thm_BookProof_QgOuterFockFL_dsFibOp_essentiallySelfAdjointOn
import Theorems.Thm_BookProof_QgOuterFockFL_dsFibOp_fib
import Theorems.Thm_BookProof_QgOuterFockFL_polyGaussCore_le_harmFriedDom
open BookProof.SqSumOuterFamily
open BookProof.SqSumOuterFamily.SqFamily




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

variable (dim : ℕ → ℕ)
variable (F : SqFamily)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (outerFriedDom F.dim)
        (dsFibOp (fun n : ℕ => harmFried (F.dim n)) F.secExt F.flK F.secExt_rel) ∧
      ∀ x : outerCore F.dim, ∃ h : (x : outerFock F.dim) ∈ outerFriedDom F.dim,
        dsFibOp (fun n : ℕ => harmFried (F.dim n)) F.secExt F.flK F.secExt_rel
            ⟨(x : outerFock F.dim), h⟩ = F.outerHam x := by

  refine ⟨dsFibOp_essentiallySelfAdjointOn F.flc_nonneg F.secExt_rel F.secExt_symmetricOn
    F.secExt_commForm_le, fun x => ?_⟩
  refine ⟨outerCore_le_friedDom F.dim x.2, ?_⟩
  refine lp.ext (funext fun n => ?_)
  have hfib : ((dsFibOp (fun n : ℕ => harmFried (F.dim n)) F.secExt F.flK F.secExt_rel
        ⟨(x : outerFock F.dim), outerCore_le_friedDom F.dim x.2⟩ : outerFock F.dim)
      : ∀ n : ℕ, L2d (F.dim n)) n
      = F.secExt n ⟨((x : outerFock F.dim) : ∀ n : ℕ, L2d (F.dim n)) n,
          polyGaussCore_le_harmFriedDom (F.dim n) (x.2.2 n)⟩ :=
    dsFibOp_fib F.secExt_rel _ n
  rw [hfib, F.secExt_core n ⟨(x : outerFock F.dim) n, x.2.2 n⟩]
  exact (dsOp_coe (fun n : ℕ => F.secHam n) x n).symm
