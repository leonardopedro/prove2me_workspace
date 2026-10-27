-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsFockCore_le_friedDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_NsFullEuler_polyGaussCore_le_nsFriedDom
import Theorems.Thm_BookProof_NsFullEuler_nsFried_op_core
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) :
    nsFockCore ≤ (nsOuterComparison nu lam mu gg).dom := by

  intro x hx
  refine ⟨fun n => polyGaussCore_le_nsFriedDom nu lam mu gg n (hx.2 n), ?_⟩
  have hfun : (fun n : ℕ => opTot (nsFried nu lam mu gg n).op ((x : nsFockSpace) n))
      = fun n : ℕ =>
        (nsSectorHam nu lam mu gg n ⟨(x : nsFockSpace) n, hx.2 n⟩ : L2d (n * 21)) := by
    funext n
    rw [opTot_of_mem _ (polyGaussCore_le_nsFriedDom nu lam mu gg n (hx.2 n)),
      nsFried_op_core nu lam mu gg n ⟨(x : nsFockSpace) n, hx.2 n⟩]
  rw [hfun]
  refine memLp_of_finite_support (Set.Finite.subset hx.1 fun n hn => ?_)
  simp only [Set.mem_setOf_eq] at hn ⊢
  intro h0
  refine hn ?_
  have hz : (⟨(x : nsFockSpace) n, hx.2 n⟩ : polyGaussCore (d := n * 21)) = 0 :=
    Subtype.ext h0
  rw [hz, map_zero]
