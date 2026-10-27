-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.outerCore_le_friedDom
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
import Theorems.Thm_BookProof_QgOuterFockFL_polyGaussCore_le_harmFriedDom
open BookProof.SqSumOuterFamily




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

variable (dim : ℕ → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution : outerCore dim ≤ outerFriedDom dim := by

  intro x hx
  refine ⟨fun n => polyGaussCore_le_harmFriedDom (dim n) (hx.2 n), ?_⟩
  have hfun : (fun n : ℕ => opTot (harmFried (dim n)).op ((x : outerFock dim) n))
      = fun n : ℕ => (harmCore ⟨(x : outerFock dim) n, hx.2 n⟩ : L2d (dim n)) := by
    funext n
    rw [opTot_of_mem _ (polyGaussCore_le_harmFriedDom (dim n) (hx.2 n)),
      harmFried_op_core (dim n) ⟨(x : outerFock dim) n, hx.2 n⟩]
  rw [hfun]
  refine memLp_of_finite_support (Set.Finite.subset hx.1 fun n hn => ?_)
  simp only [Set.mem_setOf_eq] at hn ⊢
  intro h0
  refine hn ?_
  have hz : (⟨(x : outerFock dim) n, hx.2 n⟩ : polyGaussCore (d := dim n)) = 0 :=
    Subtype.ext h0
  rw [hz, map_zero]
