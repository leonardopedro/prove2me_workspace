-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.lagFockCore_le_friedDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_NsFullLagrangian_polyGaussCore_le_lagFriedDom
import Theorems.Thm_BookProof_NsFullLagrangian_lagFried_op_core
open BookProof.NsFullLagrangian




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) :
    lagFockCore ≤ (lagOuterComparison lam lam' mu gg).dom := by

  intro x hx
  refine ⟨fun n => polyGaussCore_le_lagFriedDom lam lam' mu gg n (hx.2 n), ?_⟩
  have hfun : (fun n : ℕ => opTot (lagFried lam lam' mu gg n).op ((x : lagFockSpace) n))
      = fun n : ℕ =>
        (lagSectorHam lam lam' mu gg n ⟨(x : lagFockSpace) n, hx.2 n⟩ : L2d (n * 36)) := by
    funext n
    rw [opTot_of_mem _ (polyGaussCore_le_lagFriedDom lam lam' mu gg n (hx.2 n)),
      lagFried_op_core lam lam' mu gg n ⟨(x : lagFockSpace) n, hx.2 n⟩]
  rw [hfun]
  refine memLp_of_finite_support (Set.Finite.subset hx.1 fun n hn => ?_)
  simp only [Set.mem_setOf_eq] at hn ⊢
  intro h0
  refine hn ?_
  have hz : (⟨(x : lagFockSpace) n, hx.2 n⟩ : polyGaussCore (d := n * 36)) = 0 :=
    Subtype.ext h0
  rw [hz, map_zero]
